Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3B3F2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 14:03:50 +1100 (EST)
Message-ID: <510B22C2.90606@windriver.com>
Date: Thu, 31 Jan 2013 20:04:50 -0600
From: Jason Wessel <jason.wessel@windriver.com>
MIME-Version: 1.0
To: Cong Ding <dinggnu@gmail.com>
Subject: Re: [PATCH] powerpc: kernel/kgdb.c: fix memory leakage
References: <1358184395-31418-1-git-send-email-dinggnu@gmail.com>
In-Reply-To: <1358184395-31418-1-git-send-email-dinggnu@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Tiejun Chen <tiejun.chen@windriver.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/14/2013 11:26 AM, Cong Ding wrote:
> the variable backup_current_thread_info isn't freed before existing the
> function.
> 
> Signed-off-by: Cong Ding <dinggnu@gmail.com>
> ---
>  arch/powerpc/kernel/kgdb.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 8747447..5ca82cd 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -154,12 +154,12 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
>  static int kgdb_singlestep(struct pt_regs *regs)
>  {
>  	struct thread_info *thread_info, *exception_thread_info;
> -	struct thread_info *backup_current_thread_info = \
> -		(struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
> +	struct thread_info *backup_current_thread_info;



Woh...  This is definitely wrong.  You have found a problem for sure,
but this is not the right way to fix it.

It is not a good idea to kmalloc while single stepping because you can
hang the kernel if you single step any operation in kmalloc().

I am in the process of going through all the kgdb mails from the last
few months while I had been away from the project, so I didn't catch
this one and I see it has upstream commit (fefd9e6f8).  I'll submit
another patch to fix this the right way and use a static variable.
This is ok to use a static variable here because this is not something
we can recursively call at a single CPU level.

If Ben prefers we not burn the memory unless kgdb is active we can
kmalloc / kfree the space we need at the time that kgdb is
initialized.  Else we can go with this patch you see below.  We'll see
what Ben desires.

-----
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index a7bc752..bb12c8b 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -151,15 +151,16 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
 	return 1;
 }
 
+static struct thread_info kgdb_backup_thread_info[NR_CPUS];
+
 static int kgdb_singlestep(struct pt_regs *regs)
 {
 	struct thread_info *thread_info, *exception_thread_info;
-	struct thread_info *backup_current_thread_info;
+	int cpu = raw_smp_processor_id();
 
 	if (user_mode(regs))
 		return 0;
 
-	backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
 	/*
 	 * On Book E and perhaps other processors, singlestep is handled on
 	 * the critical exception stack.  This causes current_thread_info()
@@ -175,7 +176,7 @@ static int kgdb_singlestep(struct pt_regs *regs)
 
 	if (thread_info != exception_thread_info) {
 		/* Save the original current_thread_info. */
-		memcpy(backup_current_thread_info, exception_thread_info, sizeof *thread_info);
+		memcpy(&kgdb_backup_thread_info[cpu], exception_thread_info, sizeof *thread_info);
 		memcpy(exception_thread_info, thread_info, sizeof *thread_info);
 	}
 
@@ -183,9 +184,8 @@ static int kgdb_singlestep(struct pt_regs *regs)
 
 	if (thread_info != exception_thread_info)
 		/* Restore current_thread_info lastly. */
-		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
+		memcpy(exception_thread_info, &kgdb_backup_thread_info[cpu], sizeof *thread_info);
 
-	kfree(backup_current_thread_info);
 	return 1;
 }
 

-----


Thanks,
Jason.


>  
>  	if (user_mode(regs))
>  		return 0;
>  
> +	backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
>  	/*
>  	 * On Book E and perhaps other processors, singlestep is handled on
>  	 * the critical exception stack.  This causes current_thread_info()
> @@ -185,6 +185,7 @@ static int kgdb_singlestep(struct pt_regs *regs)
>  		/* Restore current_thread_info lastly. */
>  		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
>  
> +	kfree(backup_current_thread_info);
>  	return 1;
>  }
>  
> 
