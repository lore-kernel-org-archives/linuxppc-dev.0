Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: EST8260 - build/boot?
Date: Wed, 29 May 2002 20:45:00 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFAENBDHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to upgrade our kernel to the latest development version. Our
original implementation was made using HHL 2.0, based on the EST8260
platform. Some of the 860/8260 implementations allow the BIOS to pass a
bd_info structure but this appears to be broken in the latest source.

1. Our original source had a head_8260.S, the current implementation uses
simple/head.S
  a. boot/prep/head.S is similar to the original source
2. head.S and embed_config.c contain conditional compiles for handling the
bd_info structure. It appears that this code only works if you have an
860/MBX board.

Proposed solution:
if [ "$CONFIG_MBX" = "y" -o "$CONFIG_RPX6" = "y" ]; then
  define_bool CONFIG_BOOT_BDINFO y
fi
if [ "$CONFIG_EMBEDDEDBOOT" = "y" ]; then
  bool 'BIOS passes bd_info structure' CONFIG_BOOT_BDINFO
fi

Modify the appropriate source files or course.....

Comments?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
