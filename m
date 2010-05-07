Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D8FEB7D6A
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 18:10:50 +1000 (EST)
Date: Fri, 7 May 2010 09:24:51 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/kexec: Add support for FSL-BookE
Message-ID: <20100507072451.GA28507@Chamillionaire.breakpoint.cc>
References: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
	<1270412343-19334-4-git-send-email-sebastian@breakpoint.cc>
	<42CE8E3E-E536-402C-970B-C4BBC036BEB9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <42CE8E3E-E536-402C-970B-C4BBC036BEB9@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Kumar Gala | 2010-05-07 01:50:29 [-0500]:

>Can you explain this a bit more.  Mostly would like to have a brief description of the sequence of events as part of the commit message.
>
>Something like:
>
>* Running kernel calls machine_kexec()
>* machine_kexec_32()
>* jump to relocate code
>* relocate clears out TLBs and sets up 2g mapping
>...
>
>what I have above might not be quite right.
That is correct:
- kexec -l loads the kernel, dtb, ... in userland. It sets up the kimage
  struct including buffers with the new kernel and a copy list which
  looks like src, dst, bytes.
  KEXEC_*_MEMORY_LIMIT is limiting the memory which it might allocate.
- kexec -e start the kexec, that is
  * syscall reboot - kernel/sys.c
  * kernel_kexec() kernel/kexec.c
  * machine_kexec()  arch/powerpc/kernel/machine_kexec.c
  * default_machine_kexec() arch/powerpc/kernel/machine_kexec_32.c
- copy relocate_new_kernel() into a buffer which was allocated during
  kexec -l. That buffer is somewhere between 0..2GiB and will not be
  overwritten.
- jump there.
  Here we clear the tlbs and setup a 1:1 mapping. Then we copy the
  data from somewhere in 0..2GiB to its final position according to the
  list. Data means new kernel, device tree and purgatory code.
- After that, the code ends in
    mtlr    r5
    blrl
  r5 has the address of purgatory_start(), purgatory/arch/ppc/v2wrap.S
  in kexec userland [0].
- here we setup stack, jump to purgatory(). We have no console and still
  the 2GiB 1:1 mapping
- the code performs a sha256 check to make sure the kernel is correct.
- then we get back from purgatory(), load r3 - r9 and the blr at the
  bottom shoots us finally to new kernel.
- now we boot the kernel.

>- k

[0] git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git

Sebastian
