Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70467B7DAC
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 08:27:57 +1100 (EST)
Date: Tue, 9 Feb 2010 13:25:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Restrict initial stack space expansion to rlimit
Message-Id: <20100209132529.bfc455b7.akpm@linux-foundation.org>
In-Reply-To: <11046.1265705967@neuling.org>
References: <20100208161014.7C6D.A69D9226@jp.fujitsu.com>
	<1273.1265695885@neuling.org>
	<20100209154141.03F0.A69D9226@jp.fujitsu.com>
	<11046.1265705967@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, aeb@cwi.nl,
	Oleg Nesterov <oleg@redhat.com>, miltonm@bga.com,
	James Morris <jmorris@namei.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Serge Hallyn <serue@us.ibm.com>, linux-fsdevel@vger.kernel.org,
	Americo Wang <xiyou.wangcong@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stable@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 09 Feb 2010 19:59:27 +1100
Michael Neuling <mikey@neuling.org> wrote:

> > > +	/* Initial stack must not cause stack overflow. */
> > > +	if (stack_expand > stack_expand_lim)
> > > +		stack_expand = stack_expand_lim;
> > >  #ifdef CONFIG_STACK_GROWSUP
> > > -	stack_base = vma->vm_end + EXTRA_STACK_VM_PAGES * PAGE_SIZE;
> > > +	stack_base = vma->vm_end + stack_expand;
> > >  #else
> > > -	stack_base = vma->vm_start - EXTRA_STACK_VM_PAGES * PAGE_SIZE;
> > > +	stack_base = vma->vm_start - stack_expand;
> > >  #endif
> > >  	ret = expand_stack(vma, stack_base);
> > >  	if (ret)
> > 
> > Umm.. It looks correct. but the nested complex if statement seems a bit ugly.
> > Instead, How about following?
> 
> I don't like the duplicated code in the #ifdef/else but I can live with it.

cleanup the cleanup:

--- a/fs/exec.c~fs-execc-restrict-initial-stack-space-expansion-to-rlimit-cleanup-cleanup
+++ a/fs/exec.c
@@ -637,20 +637,17 @@ int setup_arg_pages(struct linux_binprm 
 	 * will align it up.
 	 */
 	rlim_stack = rlimit(RLIMIT_STACK) & PAGE_MASK;
-	if (rlim_stack < stack_size)
-		rlim_stack = stack_size;
+	rlim_stack = min(rlim_stack, stack_size);
 #ifdef CONFIG_STACK_GROWSUP
-	if (stack_size + stack_expand > rlim_stack) {
+	if (stack_size + stack_expand > rlim_stack)
 		stack_base = vma->vm_start + rlim_stack;
-	} else {
+	else
 		stack_base = vma->vm_end + stack_expand;
-	}
 #else
-	if (stack_size + stack_expand > rlim_stack) {
+	if (stack_size + stack_expand > rlim_stack)
 		stack_base = vma->vm_end - rlim_stack;
-	} else {
+	else
 		stack_base = vma->vm_start - stack_expand;
-	}
 #endif
 	ret = expand_stack(vma, stack_base);
 	if (ret)
_

> > note: it's untested.
> 
> Works for me on ppc64 with 4k and 64k pages.  Thanks!
> 
> I'd still like someone with a CONFIG_STACK_GROWSUP arch to test/ACK it
> as well.

There's only one CONFIG_GROWSUP arch - parisc.

Guys, here's the rolled-up patch.  Could someone please test it on
parisc?

err, I'm not sure what one needs to do to test it, actually. 
Presumably it involves setting an unusual `ulimit -s'.  Can someone
please suggest a test plan?




From: Michael Neuling <mikey@neuling.org>

When reserving stack space for a new process, make sure we're not
attempting to expand the stack by more than rlimit allows.

This fixes a bug caused by b6a2fea39318e43fee84fa7b0b90d68bed92d2ba ("mm:
variable length argument support") and unmasked by
fc63cf237078c86214abcb2ee9926d8ad289da9b ("exec: setup_arg_pages() fails
to return errors").

This bug means that when limiting the stack to less the 20*PAGE_SIZE (eg. 
80K on 4K pages or 'ulimit -s 79') all processes will be killed before
they start.  This is particularly bad with 64K pages, where a ulimit below
1280K will kill every process.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Americo Wang <xiyou.wangcong@gmail.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Serge Hallyn <serue@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <stable@kernel.org>

 fs/exec.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff -puN fs/exec.c~fs-execc-restrict-initial-stack-space-expansion-to-rlimit fs/exec.c
--- a/fs/exec.c~fs-execc-restrict-initial-stack-space-expansion-to-rlimit
+++ a/fs/exec.c
@@ -571,6 +571,9 @@ int setup_arg_pages(struct linux_binprm 
 	struct vm_area_struct *prev = NULL;
 	unsigned long vm_flags;
 	unsigned long stack_base;
+	unsigned long stack_size;
+	unsigned long stack_expand;
+	unsigned long rlim_stack;
 
 #ifdef CONFIG_STACK_GROWSUP
 	/* Limit stack size to 1GB */
@@ -627,10 +630,24 @@ int setup_arg_pages(struct linux_binprm 
 			goto out_unlock;
 	}
 
+	stack_expand = EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+	stack_size = vma->vm_end - vma->vm_start;
+	/*
+	 * Align this down to a page boundary as expand_stack
+	 * will align it up.
+	 */
+	rlim_stack = rlimit(RLIMIT_STACK) & PAGE_MASK;
+	rlim_stack = min(rlim_stack, stack_size);
 #ifdef CONFIG_STACK_GROWSUP
-	stack_base = vma->vm_end + EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+	if (stack_size + stack_expand > rlim_stack)
+		stack_base = vma->vm_start + rlim_stack;
+	else
+		stack_base = vma->vm_end + stack_expand;
 #else
-	stack_base = vma->vm_start - EXTRA_STACK_VM_PAGES * PAGE_SIZE;
+	if (stack_size + stack_expand > rlim_stack)
+		stack_base = vma->vm_end - rlim_stack;
+	else
+		stack_base = vma->vm_start - stack_expand;
 #endif
 	ret = expand_stack(vma, stack_base);
 	if (ret)
_
