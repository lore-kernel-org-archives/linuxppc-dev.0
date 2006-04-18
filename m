Return-Path: <dwilder@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5211C67A39
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 00:02:25 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3IE2A3H022481
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 10:02:10 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3IE2A3d203602
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 10:02:10 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3IE29Lj008169
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 10:02:09 -0400
Message-ID: <4444FB7C.6080206@us.ibm.com>
Date: Tue, 18 Apr 2006 07:45:16 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ppc64-soft-reset-fixes
References: <4443D738.3040704@us.ibm.com>
	<20060417231235.36546cb6.akpm@osdl.org>
In-Reply-To: <20060417231235.36546cb6.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------010603040903060001060509"
Cc: linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010603040903060001060509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>David Wilder <dwilder@us.ibm.com> wrote:
>  
>
>> - For the crash scenario, when a CPU hangs with interrupts disabled and 
>> the other CPUs panic or user invoked kdump boot using sysrq-c. In this 
>> case, the hung CPU can not be stopped and causes the kdump boot not 
>> successful. This case can be treated as complete system hang and asks 
>> the user to activate soft-reset if all secondary CPUs are not stopped.
>>    
>>
>
>It breaks `make allmodconfig':
>
>arch/powerpc/kernel/built-in.o(.toc+0x2a00): In function `PPC64_CACHES':
>: undefined reference to `kexec_crash_image'
>
>
>  
>
Sorry for the confusion ppc64-soft-reset-fixes.patch patch is depended 
on another patch (kdump-image-rm-static.patch).   Please see my earlier 
posting at http://ozlabs.org/pipermail/linuxppc-dev/2006-April/021956.html.
My apologies for not restating this dependency in yesterdays posting.  I 
have attached the earlier patch in this email.
Again both ppc64-soft-reset-fixes.patch and kdump-image-rm-static.patch 
must be applied to keep from breaking the build.

Regards

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789


--------------010603040903060001060509
Content-Type: text/x-patch;
 name="kdump-image-rm-static.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-image-rm-static.patch"

--- 2617-rc1/kernel/kexec.c.orig	2006-04-05 13:27:53.000000000 -0700
+++ 2617-rc1/kernel/kexec.c	2006-04-05 13:27:43.000000000 -0700
@@ -903,7 +903,7 @@ static int kimage_load_segment(struct ki
  * that to happen you need to do that yourself.
  */
 struct kimage *kexec_image = NULL;
-static struct kimage *kexec_crash_image = NULL;
+struct kimage *kexec_crash_image = NULL;
 /*
  * A home grown binary mutex.
  * Nothing can wait so this mutex is safe to use
@@ -1042,7 +1042,6 @@ asmlinkage long compat_sys_kexec_load(un
 
 void crash_kexec(struct pt_regs *regs)
 {
-	struct kimage *image;
 	int locked;
 
 
@@ -1056,12 +1055,11 @@ void crash_kexec(struct pt_regs *regs)
 	 */
 	locked = xchg(&kexec_lock, 1);
 	if (!locked) {
-		image = xchg(&kexec_crash_image, NULL);
-		if (image) {
+		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 			crash_setup_regs(&fixed_regs, regs);
 			machine_crash_shutdown(&fixed_regs);
-			machine_kexec(image);
+			machine_kexec(kexec_crash_image);
 		}
 		xchg(&kexec_lock, 0);
 	}

--------------010603040903060001060509--
