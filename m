In-Reply-To: <Pine.GSO.4.58.0404011035190.12755@waterleaf.sonytel.be>
References: <20040331230620.ACC3BC10A4@atlas.denx.de> <812363C6-8371-11D8-9FF0-000A95A07384@sands-edge.com> <Pine.GSO.4.58.0404011035190.12755@waterleaf.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/mixed; boundary=Apple-Mail-31--530208078
Message-Id: <8A34C28B-8426-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Wolfgang Denk <wd@denx.de>
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Proposed Kconfig update patch for help text 
Date: Thu, 1 Apr 2004 16:50:06 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-31--530208078
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Here's the latest Kconfig help-text patch for your consideration.  I
considered enumerating each chip supported, but that will be a
maintenance headache, and I'm not even sure I could list them all.  I'm
fairly sure that the 8250 is supported, but it isn't listed in
arch/ppc/kernel/cputable.c, so I'm guessing its PVR is covered by the
8260 entry.  I don't want to figure out which ones are supported but
not explicitly covered, so I went with the "##xx" method.

Let me know what you think...

John


--Apple-Mail-31--530208078
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0600;
	name="Kconfig.patch"
Content-Disposition: attachment;
	filename=Kconfig.patch

--- linuxppc-2.6.5-rc2.orig/arch/ppc/Kconfig	2004-04-01 14:23:12.000000000 -0500
+++ linuxppc-2.6.5-rc2/arch/ppc/Kconfig	2004-04-01 16:46:11.000000000 -0500
@@ -44,33 +44,77 @@
 	default 6xx

 config 6xx
-	bool "6xx/7xx/74xx/8260"
+	bool "6xx/7xx/74xx/82xx"
 	help
 	  There are four types of PowerPC chips supported.  The more common
-	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
-	  versions (821, 823, 850, 855, 860, 8260), the IBM embedded versions
-	  (403 and 405) and the high end 64 bit Power processors (POWER 3,
-	  POWER4, and IBM 970 also known as G5)
+	  types (6xx, 7xx, 74xx), the Motorola embedded versions (8xx, 82xx), the
+	  IBM embedded versions (4xx) and the high end 64 bit Power processors
+	  (POWER 3, POWER4, and IBM 970 also known as G5).
+
+	  Choose this option if you are building a kernel for a platform with a
+	  Motorola or IBM 6xx, 7xx, 74xx, or 82xx processor.
+
 	  Unless you are building a kernel for one of the embedded processor
 	  systems, 64 bit IBM RS/6000 or an Apple G5, choose 6xx.
+
 	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
 	  Also note that because the 82xx family has a 603e core, specific
 	  support for that chipset is asked later on.

 config 40x
 	bool "40x"
+	help
+	  There are four types of PowerPC chips supported.  The more common
+	  types (6xx, 7xx, 74xx), the Motorola embedded versions (8xx, 82xx), the
+	  IBM embedded versions (4xx) and the high end 64 bit Power processors
+	  (POWER 3, POWER4, and IBM 970 also known as G5).
+
+	  Choose this option if you are building a kernel for a platform with an
+	  IBM 403 or 405 processor.

 config 44x
 	bool "44x"
+	help
+	  There are four types of PowerPC chips supported.  The more common
+	  types (6xx, 7xx, 74xx), the Motorola embedded versions (8xx, 82xx), the
+	  IBM embedded versions (4xx) and the high end 64 bit Power processors
+	  (POWER 3, POWER4, and IBM 970 also known as G5).
+
+	  Choose this option if you are building a kernel for a platform with an
+	  IBM 440 processor.

 config POWER3
 	bool "POWER3"
+	help
+	  There are four types of PowerPC chips supported.  The more common
+	  types (6xx, 7xx, 74xx), the Motorola embedded versions (8xx, 82xx), the
+	  IBM embedded versions (4xx) and the high end 64 bit Power processors
+	  (POWER 3, POWER4, and IBM 970 also known as G5).
+
+	  Choose this option if you are building a kernel for a platform with an
+	  IBM POWER3 processor.

 config POWER4
 	bool "POWER4 and 970 (G5)"
+	help
+	  There are four types of PowerPC chips supported.  The more common
+	  types (6xx, 7xx, 74xx), the Motorola embedded versions (8xx, 82xx), the
+	  IBM embedded versions (4xx) and the high end 64 bit Power processors
+	  (POWER 3, POWER4, and IBM 970 also known as G5).
+
+	  Choose this option if you are building a kernel for a platform with an
+	  IBM POWER4 or 970 (G5) processor.

 config 8xx
 	bool "8xx"
+	help
+	  There are four types of PowerPC chips supported.  The more common
+	  types (6xx, 7xx, 74xx), the Motorola embedded versions (8xx, 82xx), the
+	  IBM embedded versions (4xx) and the high end 64 bit Power processors
+	  (POWER 3, POWER4, and IBM 970 also known as G5).
+
+	  Choose this option if you are building a kernel for a platform with a
+	  Motorola 8xx embedded processor.

 endchoice


--Apple-Mail-31--530208078--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
