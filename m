Return-Path: <halesh.sadashiv@ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] remove bogus ppc_select syscall
Date: Wed, 24 Sep 2008 19:19:16 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D56E723@insardxms01.ap.sony.com>
From: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	"Arnd Bergmann" <arnd@arndb.de>, <linuxppc-embedded@ozlabs.org>,
	<paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>One more thing noticed while building the kernel, it gave warning
>
>kernel/power/Kconfig:97:warning: 'select' used by config symbol
>'PM_SLEEP_SMP' refers to undefined symbol 'HOTPLUG_CPU'


Apologies, this is not related to the Fix.
Please ignore my previous post.

>
>Thanks
>Halesh
>
>
>
>
>>-----Original Message-----
>>From: Sadashiiv, Halesh
>>Sent: Wednesday, September 24, 2008 2:42 PM
>>To: 'Arnd Bergmann'; linuxppc-embedded@ozlabs.org; paulus@samba.org
>>Cc: benh@kernel.crashing.org; linuxppc-dev@ozlabs.org
>>Subject: RE: [PATCH] remove bogus ppc_select syscall
>>
>>
>>I have tested the provided patch on PPC32 with little modifications.
>>
>>Test passed on the PPC32.
>>
>>Modification to Arnd's Patch:
>>	In systbl.h you have changed
>>		-SYSX(sys_ni_syscall,sys_ni_syscall,ppc_select)
>>		+SYSCALL(sys_ni_syscall)
>>
>>	That has to be
>>		-SYSX(sys_ni_syscall,sys_ni_syscall,ppc_select)
>>		+SYSCALL(ni_syscall)
>>
>>Which failed the kernel build. It's a typo from your side I think.
>>After fixing it build went fine.
>>
>>Signed-off-by: Halesh Sadashiv <halesh.sadashiv@ap.sony.com>
>>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>>diff --git a/arch/powerpc/include/asm/unistd.h
>>b/arch/powerpc/include/asm/unistd.h
>>index e07d0c7..46107cc 100644
>>--- a/arch/powerpc/include/asm/unistd.h
>>+++ b/arch/powerpc/include/asm/unistd.h
>>@@ -92,7 +92,7 @@
>> #define __NR_settimeofday       79
>> #define __NR_getgroups          80
>> #define __NR_setgroups          81
>>-#define __NR_select             82
>>+/* Number 82 was the old (pre-1.3.x) select */
>> #define __NR_symlink            83
>> #define __NR_oldlstat           84
>> #define __NR_readlink           85
>>diff --git a/arch/powerpc/include/asm/systbl.h
>>b/arch/powerpc/include/asm/systbl.h
>>index f6cc7a4..5a69b32 100644
>>--- a/arch/powerpc/include/asm/systbl.h
>>+++ b/arch/powerpc/include/asm/systbl.h
>>@@ -85,7 +85,7 @@ COMPAT_SYS_SPU(gettimeofday)
>> COMPAT_SYS_SPU(settimeofday)
>> COMPAT_SYS_SPU(getgroups)
>> COMPAT_SYS_SPU(setgroups)
>>-SYSX(sys_ni_syscall,sys_ni_syscall,ppc_select)
>>+SYSCALL(ni_syscall)
>> SYSCALL_SPU(symlink)
>> OLDSYS(lstat)
>> COMPAT_SYS_SPU(readlink)
>>@@ -145,7 +145,7 @@ SYSCALL_SPU(setfsuid)
>> SYSCALL_SPU(setfsgid)
>> SYSCALL_SPU(llseek)
>> COMPAT_SYS_SPU(getdents)
>>-SYSX_SPU(sys_select,ppc32_select,ppc_select)
>>+SYSX_SPU(sys_select,ppc32_select,sys_select)
>> SYSCALL_SPU(flock)
>> SYSCALL_SPU(msync)
>> COMPAT_SYS_SPU(readv)
>>diff --git a/arch/powerpc/kernel/syscalls.c
>>b/arch/powerpc/kernel/syscalls.c index c04832c..c2e6a74 100644
>>--- a/arch/powerpc/kernel/syscalls.c
>>+++ b/arch/powerpc/kernel/syscalls.c
>>@@ -183,31 +183,6 @@ unsigned long sys_mmap(unsigned long addr, size_t
len,
>> 	return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
}
>>
>>-#ifdef CONFIG_PPC32
>>-/*
>>- * Due to some executables calling the wrong select we sometimes
>>- * get wrong args.  This determines how the args are being passed
>>- * (a single ptr to them all args passed) then calls
>>- * sys_select() with the appropriate args. -- Cort
>>- */
>>-int
>>-ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set
__user
>>*exp, struct timeval __user *tvp) -{
>>-	if ( (unsigned long)n >=3D 4096 )
>>-	{
>>-		unsigned long __user *buffer =3D (unsigned long __user
*)n;
>>-		if (!access_ok(VERIFY_READ, buffer, 5*sizeof(unsigned
long))
>>-		    || __get_user(n, buffer)
>>-		    || __get_user(inp, ((fd_set __user * __user
*)(buffer+1)))
>>-		    || __get_user(outp, ((fd_set  __user * __user
>>*)(buffer+2)))
>>-		    || __get_user(exp, ((fd_set  __user * __user
*)(buffer+3)))
>>-		    || __get_user(tvp, ((struct timeval  __user * __user
>>*)(buffer+4))))
>>-			return -EFAULT;
>>-	}
>>-	return sys_select(n, inp, outp, exp, tvp);
>>-}
>>-#endif
>>-
>> #ifdef CONFIG_PPC64
>> long ppc64_personality(unsigned long personality)  {
>>
>>Thanks
>>Halesh
>>
>>
>>
>>
>>>-----Original Message-----
>>>From: Arnd Bergmann [mailto:arnd@arndb.de]
>>>Sent: Wednesday, September 24, 2008 12:09 PM
>>>To: linuxppc-embedded@ozlabs.org; paulus@samba.org
>>>Cc: benh@kernel.crashing.org; Sadashiiv, Halesh;
linuxppc-dev@ozlabs.org
>>>Subject: [PATCH] remove bogus ppc_select syscall
>>>
>>>The ppc_select function was introduced in linux-2.3.48 in order to
>support
>>>code confusing the legacy select() calling convention with the
standard
>>one.
>>>Even 11 years ago, all correctly built code should not have done this
and
>>>could have easily been phased out. Nothing that was compiled later
should
>>>actually try to use the old_select interface, and it would have been
>>broken
>>>already on all ppc64 kernels with the syscall emulation layer.
>>>
>>>This patch brings the 32 bit compat ABI and the native 32 bit ABI for
>>>powerpc into a consistent state, by removing support for both the
>>>old_select system call number and the handler for it.
>>>
>>>The bug report triggering this came from Halesh Sadashiiv
>>><halesh.sadashiv@ap.sony.com>, who discovered that the 32 bit
>>>implementation of ppc_select would in case of a negative number
>>>of file descriptors incorrectly return -EFAULT instead of -EINVAL.
>>>There seems to be no way to fix this problem in a way that would
>>>keep broken pre-1997 binaries running.
>>>
>>>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>Cc: Halesh Sadashiiv <halesh.sadashiv@ap.sony.com>
>>>---
>>>
>>>Halesh, please test this patch to make sure it fixes the problem
>>>you reported. I do not have a ppc32 machine I can try this on.
>>>
>>>diff --git a/arch/powerpc/include/asm/unistd.h
>>b/arch/powerpc/include/asm/unistd.h
>>>index e07d0c7..46107cc 100644
>>>--- a/arch/powerpc/include/asm/unistd.h
>>>+++ b/arch/powerpc/include/asm/unistd.h
>>>@@ -92,7 +92,7 @@
>>> #define __NR_settimeofday       79
>>> #define __NR_getgroups          80
>>> #define __NR_setgroups          81
>>>-#define __NR_select             82
>>>+/* Number 82 was the old (pre-1.3.x) select */
>>> #define __NR_symlink            83
>>> #define __NR_oldlstat           84
>>> #define __NR_readlink           85
>>>diff --git a/arch/powerpc/include/asm/systbl.h
>>>b/arch/powerpc/include/asm/systbl.h
>>>index f6cc7a4..5a69b32 100644
>>>--- a/arch/powerpc/include/asm/systbl.h
>>>+++ b/arch/powerpc/include/asm/systbl.h
>>>@@ -85,7 +85,7 @@ COMPAT_SYS_SPU(gettimeofday)
>>> COMPAT_SYS_SPU(settimeofday)
>>> COMPAT_SYS_SPU(getgroups)
>>> COMPAT_SYS_SPU(setgroups)
>>>-SYSX(sys_ni_syscall,sys_ni_syscall,ppc_select)
>>>+SYSCALL(sys_ni_syscall)
>>> SYSCALL_SPU(symlink)
>>> OLDSYS(lstat)
>>> COMPAT_SYS_SPU(readlink)
>>>@@ -145,7 +145,7 @@ SYSCALL_SPU(setfsuid)
>>> SYSCALL_SPU(setfsgid)
>>> SYSCALL_SPU(llseek)
>>> COMPAT_SYS_SPU(getdents)
>>>-SYSX_SPU(sys_select,ppc32_select,ppc_select)
>>>+SYSX_SPU(sys_select,ppc32_select,sys_select)
>>> SYSCALL_SPU(flock)
>>> SYSCALL_SPU(msync)
>>> COMPAT_SYS_SPU(readv)
>>>diff --git a/arch/powerpc/kernel/syscalls.c
>>>b/arch/powerpc/kernel/syscalls.c
>>>index c04832c..c2e6a74 100644
>>>--- a/arch/powerpc/kernel/syscalls.c
>>>+++ b/arch/powerpc/kernel/syscalls.c
>>>@@ -183,31 +183,6 @@ unsigned long sys_mmap(unsigned long addr,
size_t
>len,
>>> 	return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
>>> }
>>>
>>>-#ifdef CONFIG_PPC32
>>>-/*
>>>- * Due to some executables calling the wrong select we sometimes
>>>- * get wrong args.  This determines how the args are being passed
>>>- * (a single ptr to them all args passed) then calls
>>>- * sys_select() with the appropriate args. -- Cort
>>>- */
>>>-int
>>>-ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set
__user
>>>*exp, struct timeval __user *tvp)
>>>-{
>>>-	if ( (unsigned long)n >=3D 4096 )
>>>-	{
>>>-		unsigned long __user *buffer =3D (unsigned long __user
*)n;
>>>-		if (!access_ok(VERIFY_READ, buffer, 5*sizeof(unsigned
long))
>>>-		    || __get_user(n, buffer)
>>>-		    || __get_user(inp, ((fd_set __user * __user
*)(buffer+1)))
>>>-		    || __get_user(outp, ((fd_set  __user * __user
>>>*)(buffer+2)))
>>>-		    || __get_user(exp, ((fd_set  __user * __user
*)(buffer+3)))
>>>-		    || __get_user(tvp, ((struct timeval  __user * __user
>>>*)(buffer+4))))
>>>-			return -EFAULT;
>>>-	}
>>>-	return sys_select(n, inp, outp, exp, tvp);
>>>-}
>>>-#endif
>>>-
>>> #ifdef CONFIG_PPC64
>>> long ppc64_personality(unsigned long personality)
>>> {



-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
