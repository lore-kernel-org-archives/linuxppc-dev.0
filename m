Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C860@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Adding monochrome support for 823e
Date: Thu, 29 Aug 2002 17:43:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've completed the kernel work for using the 832e in monochrome mode. It
requires changes to drivers/video/fbcmap.c. You need to add a palette for
it's monochrome mode that looks like:
832mono_red[16]={0};
832mono_green[16]={0};
832mono_blue[16]={0x0000, 0x1000, 0x2000, 0x3000, 0x4000, 0x5000, 0x6000,
0x7000, 0x8000, 0x9000, 0xa000, 0xb000, 0xc000, 0xd000, 0xe000, 0xf000}; //
not really blue, but it lines up

then make a new cmap struct
struct fb_cmap default_832mono { 0, 16, 832mono_red, 832mono_green,
832mono_blue, NULL};

then modify fb_default_cmap()
if (len<=2)
   return &default_832mono;

Then you have to do some work in arch/ppc/8xx_io/lcd832.c where indicated.
Without the work above, you may get garbage. I don't think you'd ever get
right output.

I just wanted to get this out there so it goes in the archives.
-Jason

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
