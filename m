Return-Path: <kniht@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04E46DDF77
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 11:12:33 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6P1CSb6001748
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 21:12:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6P1CSQL230168
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 21:12:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6P1CSGh006841
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 21:12:28 -0400
Message-ID: <4889287B.2020709@us.ibm.com>
Date: Thu, 24 Jul 2008 20:12:27 -0500
From: Jon Tollefson <kniht@us.ibm.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix compile error with binutils 2.15
References: <25a77ae6580f7ea388ccae2f190b1b3f7415a928.1216944498.git.segher@kernel.crashing.org>
In-Reply-To: <25a77ae6580f7ea388ccae2f190b1b3f7415a928.1216944498.git.segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> My previous patch to fix compilation with binutils-2.17 causes
> a "file truncated" build error from ld with binutils 2.15 (and
> possibly older), and a warning with 2.16 and 2.17.
>
> This fixes it.
>
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/vmlinux.lds.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index a914411..4a8ce62 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -85,7 +85,7 @@ SECTIONS
>
>  	/* The dummy segment contents for the bug workaround mentioned above
>  	   near PHDRS.  */
> -	.dummy : {
> +	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
>  		LONG(0xf177)
>  	} :kernel :dummy
>   

This fixed the file truncated error for me.  Also the kernel booted fine.

Jon

~/src/linus/linux-2.6>make vmlinux
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
<stdin>:1397:2: warning: #warning syscall signalfd4 not implemented
<stdin>:1401:2: warning: #warning syscall eventfd2 not implemented
<stdin>:1405:2: warning: #warning syscall epoll_create1 not implemented
<stdin>:1409:2: warning: #warning syscall dup3 not implemented
<stdin>:1413:2: warning: #warning syscall pipe2 not implemented
<stdin>:1417:2: warning: #warning syscall inotify_init1 not implemented
  CHK     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  CALL    arch/powerpc/kernel/systbl_chk.sh
  CALL    arch/powerpc/kernel/prom_init_check.sh
  LDS     arch/powerpc/kernel/vmlinux.lds
  CC      kernel/module.o
  CC      kernel/kexec.o
  LD      kernel/built-in.o
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: modpost: Found 6 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
