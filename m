Date: Wed, 12 Mar 2003 19:13:58 +0100
From: Olaf Hering <olh@suse.de>
To: mikpe@csd.uu.se
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.24 boot hang fix for old-world PowerMac 4400
Message-ID: <20030312181358.GA27959@suse.de>
References: <15983.28808.122462.515758@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15983.28808.122462.515758@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Wed, Mar 12, mikpe@csd.uu.se wrote:

> and vmlinux.coff aborts with a CLAIM error at boot) which is

known bug.

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

should work ok with 2.4.12 and older at least.

--
A: No.
Q: Should I include quotations after my reply?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
