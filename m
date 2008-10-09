Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id F388EDDF35
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 18:07:34 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so4177830rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 00:07:32 -0700 (PDT)
Message-ID: <fa686aa40810090007u27908fd6p1234acff06c75761@mail.gmail.com>
Date: Thu, 9 Oct 2008 01:07:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Remi Machet" <rmachet@slac.stanford.edu>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] powerpc: Make the 64-bit kernel as a
	position-independent executable
In-Reply-To: <1222474260.19465.24.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18616.42451.914835.305138@cargo.ozlabs.ibm.com>
	<1222474260.19465.24.camel@pcds-ts102.slac.stanford.edu>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 26, 2008 at 6:10 PM, Remi Machet <rmachet@slac.stanford.edu> wrote:
> Hi Paul,
>
> This patch breaks my build with the following error:
>
> /u1/rmachet/projects/c2k/linux-powerpc-git $ make cuImage.c2k modules ARCH=powerpc V=1
> ...
>  powerpc-linux-gnu-ld -m elf32ppc  -Bstatic  -o .tmp_vmlinux1 -T arch/powerpc/kernel/vmlinux.lds arch/powerpc/kernel/head_32.o arch/powerpc/kernel/fpu.o  init/built-in.o --start-group  usr/built-in.o  arch/powerpc/kernel/built-in.o  arch/powerpc/mm/built-in.o  arch/powerpc/lib/built-in.o  arch/powerpc/sysdev/built-in.o  arch/powerpc/platforms/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  block/built-in.o  lib/lib.a  lib/built-in.o  drivers/built-in.o  sound/built-in.o  firmware/built-in.o  net/built-in.o --end-group
> powerpc-linux-gnu-ld: BFD 2.16.1 internal error, aborting at /u1/rmachet/project/crosstool/crosstool-0.43/build/powerpc-linux-gnu/gcc-4.1.1-glibc-2.3.6/binutils-2.16.1/bfd/elflink.c line 6419 in elf_link_output_extsym
>
> powerpc-linux-gnu-ld: Please report this bug.

I can confirm this problem.  This patch breaks builds using binutils
2.16.1.  It definitely looks like a binutils bug.  It builds fine with
2.17.

>
> I isolated the problem to line 202 in arch/powerpc/kernel/vmlinux.lds.S: If I remove that
> line then the kernel builds and run fine on my board (a PowerPC 32bits c2k).
> For reference the line is:
>
>        .rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
>        {
> 202->           __rela_dyn_start = .;
>                *(.rela*)
>        }

There are still a lot of embedded developers using 2.16.1 binutils in
their toolchains so I think that this needs to be worked around.
Otherwise we'll see lots of complaints when this gets merged into
mainline.  However, I haven't figured out a workaround yet.  Looking
at the binutils sourcecode doesn't reveal anything obvious, but it's
too late for my brain to work properly.  Anyone else have any ideas?

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
