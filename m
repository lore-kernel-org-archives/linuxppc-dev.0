Return-Path: <sam@ravnborg.org>
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by ozlabs.org (Postfix) with ESMTP id 95117DDDB6
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 19:38:49 +1100 (EST)
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id D333E8197
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 09:38:46 +0100 (CET)
Date: Tue, 24 Feb 2009 09:40:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH/RFC] powerpc: avoid generating .eh_frame sections with
	gcc-4.4
Message-ID: <20090224084034.GA11847@uranus.ravnborg.org>
References: <20090224065112.GA6690@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090224065112.GA6690@bombadil.infradead.org>
Cc: linuxppc-dev@ozlabs.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
	roland@redhat.com, kyle@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2009 at 01:51:12AM -0500, Kyle McMartin wrote:
> From: Kyle McMartin <kyle@redhat.com>
> 
> On ppc64 (at least) gcc-4.4 is defaulting to generating .eh_frame
> sections, which are, for the kernel, fairly pointless. Additionally, on
> ppc64 this generates a relocation format which the kernel module loader
> does not currently support (R_PPC64_REL32.)
> 
> Alexandre Oliva verifies that -fno-dwarf2-cfi-asm prevents this
> .eh_frame section from being generated.
> 
> These seem to be used for unwinding, but it doesn't look like we
> currently use them anywhere. (In fact, we explicitly dump them in the
> x86_64 linker script.)

A grep for "eh_frame" shows too many hits in the kernel to convince
me this is true.


arch/m32r/kernel/vmlinux.lds.S:     from .altinstructions and .eh_frame */
arch/mn10300/kernel/vmlinux.lds.S:     from .altinstructions and .eh_frame */
arch/parisc/kernel/vmlinux.lds.S:        *  from .altinstructions and .eh_frame
arch/powerpc/kernel/vdso32/sigtramp.S:  .section .eh_frame,"a",@progbits
arch/powerpc/kernel/vdso32/vdso32.lds.S:        .eh_frame_hdr   : { *(.eh_frame_hdr) }   :text    :eh_frame_hdr
arch/powerpc/kernel/vdso32/vdso32.lds.S:        .eh_frame       : { KEEP (*(.eh_frame)) }:text
arch/powerpc/kernel/vdso32/vdso32.lds.S:        eh_frame_hdr    PT_GNU_EH_FRAME;
arch/powerpc/kernel/vdso64/sigtramp.S:  .section .eh_frame,"a",@progbits
arch/powerpc/kernel/vdso64/vdso64.lds.S:        .eh_frame_hdr   : { *(.eh_frame_hdr) }   :text    :eh_frame_hdr
arch/powerpc/kernel/vdso64/vdso64.lds.S:        .eh_frame       : { KEEP (*(.eh_frame)) }:text
arch/powerpc/kernel/vdso64/vdso64.lds.S:        eh_frame_hdr    PT_GNU_EH_FRAME;
arch/s390/kernel/vdso32/vdso32.lds.S:   .eh_frame_hdr   : { *(.eh_frame_hdr) }          :text     :eh_frame_hdr
arch/s390/kernel/vdso32/vdso32.lds.S:   .eh_frame       : { KEEP (*(.eh_frame)) }       :text
arch/s390/kernel/vdso32/vdso32.lds.S:   eh_frame_hdr    PT_GNU_EH_FRAME;
arch/s390/kernel/vdso64/vdso64.lds.S:   .eh_frame_hdr   : { *(.eh_frame_hdr) }          :text     :eh_frame_hdr
arch/s390/kernel/vdso64/vdso64.lds.S:   .eh_frame       : { KEEP (*(.eh_frame)) }       :text
arch/s390/kernel/vdso64/vdso64.lds.S:   eh_frame_hdr    PT_GNU_EH_FRAME;
arch/sh/kernel/vsyscall/vsyscall-sigreturn.S:   .section .eh_frame,"a",@progbits
arch/sh/kernel/vsyscall/vsyscall-trapa.S:        * fill out .eh_frame -- PFM. */
arch/sh/kernel/vsyscall/vsyscall-trapa.S:       .section .eh_frame,"a",@progbits
arch/sh/kernel/vsyscall/vsyscall.lds.S: .eh_frame_hdr   : { *(.eh_frame_hdr ) }         :text     :eh_frame_hdr
arch/sh/kernel/vsyscall/vsyscall.lds.S: .eh_frame       : {
arch/sh/kernel/vsyscall/vsyscall.lds.S:         KEEP (*(.eh_frame))
arch/sh/kernel/vsyscall/vsyscall.lds.S: eh_frame_hdr    PT_GNU_EH_FRAME;
arch/um/include/asm/common.lds.S:     from .altinstructions and .eh_frame */
arch/um/kernel/dyn.lds.S:  .eh_frame       : { KEEP (*(.eh_frame)) }
arch/x86/kernel/vmlinux_32.lds.S:     from .altinstructions and .eh_frame */
arch/x86/kernel/vmlinux_64.lds.S:     from .altinstructions and .eh_frame */
arch/x86/kernel/vmlinux_64.lds.S:       *(.eh_frame)
arch/x86/vdso/vdso-layout.lds.S:        .eh_frame_hdr   : { *(.eh_frame_hdr) }          :text     :eh_frame_hdr
arch/x86/vdso/vdso-layout.lds.S:        .eh_frame       : { KEEP (*(.eh_frame)) }       :text
arch/x86/vdso/vdso-layout.lds.S:        eh_frame_hdr    PT_GNU_EH_FRAME;
arch/x86/vdso/vdso32/int80.S:   .section .eh_frame,"a",@progbits
arch/x86/vdso/vdso32/int80.S:VDSO32_vsyscall_eh_frame_size = 0x40
arch/x86/vdso/vdso32/int80.S:   .space VDSO32_vsyscall_eh_frame_size-(.LENDFDEDLSI-.LSTARTFRAMEDLSI), 0
arch/x86/vdso/vdso32/sigreturn.S:       .section .eh_frame,"a",@progbits
arch/x86/vdso/vdso32/syscall.S: .section .eh_frame,"a",@progbits
arch/x86/vdso/vdso32/syscall.S:VDSO32_vsyscall_eh_frame_size = 0x40
arch/x86/vdso/vdso32/syscall.S: .space VDSO32_vsyscall_eh_frame_size-(.LENDFDE1-.LSTARTFRAME), 0
arch/x86/vdso/vdso32/sysenter.S:        .section .eh_frame,"a",@progbits
arch/x86/vdso/vdso32/sysenter.S:         * Emit a symbol with the size of this .eh_frame data,
arch/x86/vdso/vdso32/sysenter.S:VDSO32_vsyscall_eh_frame_size = (.LENDFDEDLSI-.LSTARTFRAMEDLSI)


x86 has a specific ".section .eh_frame,"a",@progbits" in vdso32/int80.S as one example.

Have you analyzed all these hits?

	Sam
