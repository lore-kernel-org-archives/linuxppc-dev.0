Return-Path: <roland@redhat.com>
Received: from QMTA03.westchester.pa.mail.comcast.net
	(qmta03.westchester.pa.mail.comcast.net [76.96.62.32])
	by ozlabs.org (Postfix) with ESMTP id 34BABDDE26
	for <linuxppc-dev@ozlabs.org>; Sun, 11 May 2008 10:40:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: patch to install unstripped vDSO on disk breaks powerpc kernel
	build
In-Reply-To: Chris Friesen's message of  Friday,
	9 May 2008 22:43:31 -0600 <482527F3.60405@nortel.com>
References: <482486F7.3090805@nortel.com>
	<20080509194427.3BDB126FA85@magilla.localdomain>
	<482527F3.60405@nortel.com>
Message-Id: <20080511004047.2B6E226FA86@magilla.localdomain>
Date: Sat, 10 May 2008 17:40:47 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok.  That looks like a bug in the older binutils (objcopy) you are using.
It is confused by the empty .rela.dyn section right next to the .dynamic
section.  Current binutils don't seem to have a problem with this.

I haven't tried to get an old binutils running to reproduce this.
I suspect the following change will work around the problem.
It should not cause any problem with newer or older binutils.


Thanks,
Roland

---
[PATCH] powerpc vdso64 linker script tweak

This should work around bugs in older binutils' objcopy.
The placement of these sections does not really matter,
but it confused the buggy old BFD libraries.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/vdso64/vdso64.lds.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index 932b3fd..7d6585f 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -43,15 +43,15 @@ SECTIONS
 	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
 	.rodata1	: { *(.rodata1) }
 
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 	.gcc_except_table : { *(.gcc_except_table) }
+	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
 
 	.opd ALIGN(8)	: { KEEP (*(.opd)) }
 	.got ALIGN(8)	: { *(.got .toc) }
-	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
-
-	.dynamic	: { *(.dynamic) }		:text	:dynamic
 
 	_end = .;
 	PROVIDE(end = .);
