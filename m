MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15984.39762.858447.704784@gargle.gargle.HOWL>
Date: Thu, 13 Mar 2003 15:53:06 +0100
From: mikpe@csd.uu.se
To: linuxppc-dev@lists.linuxppc.org
Cc: olh@suse.de
Subject: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


vmlinux.coff built from 2.4.20-ben8 fails immediately at boot
on my old-world PowerMac 4400 (OF 2.0.2) with a CLAIM error:

0> boot fd:vmlinux.coff root=/dev/hda8 loading XCOFF
tsize=5E40 dsize=C500C bsize=215DC entry=500000
SECTIONS:
.text	00500000 00500000 00005E40 000000D4
.data	00506000 00506000 000C500C 00005F14
.bss	005CB000 005CB000 000215DC 00000000
loading .text, done..
loading .data, done..
clearing .bssCLAIM failed

Olaf Hering wrote that it was a known bug and suggested the
patch below, but it didn't make any difference.

This is a regression from 2.2.24, which works fine on this
machine (with one patch to disable a prom quiesce call).

Any other patches I should try? I don't want to be stuck at 2.2.24...

/Mikael
(. please cc: me on any replies;
   I've tried twice now to subscribe, without success .)

--- linux-2.4.20-pre11/arch/ppc/boot/ld.script  Sun Oct 27 19:21:01 2002
+++ linux-2.4.20-pre11..7200/arch/ppc/boot/ld.script    Sun Oct 27 18:13:02 2002
@@ -39,7 +39,7 @@ SECTIONS
   PROVIDE (etext = .);

   /* Read-write section, merged into data segment: */
-  . = ALIGN(8);
+  . = ALIGN(0x1000);
   .data    :
   {
     *(.data)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
