Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 21 Jul 2004 08:23:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: can the 8xx patch configuration be made more comprehensible?
Message-ID: <Pine.LNX.4.60.0407210807460.4518@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   i imagine it's just me, but i find the configuration process of
selecting possible patches for 8xx a bit confusing under the 2.6
kernel.

   under "MPC8xx CPM Options", there's a single option for patches:

 	[ ] I2C/SPI Microcode Patch

seems simple enough, although the help screen muddies the waters
somewhat:

CONFIG_UCODE_PATCH:

Motorola releases microcode updates for their 8xx CPM modules.  The
microcode update file has updates for IIC, SMC and USB.  Currently
only the USB update is available by default, if the MPC8xx USB option
is enabled.  If in doubt, say 'N' here.

   so, suddenly, a patch labelled as for I2C and SPI is described as
also affecting SMC and USB (but only if you selected USB in the first
place.  and where went SPI?)

   and if you look inside micropatch.c, you notice that the only way to
get the SMC patch (whatever that does) is not to have selected it at
config time, but to manually edit this file and define USE_SMC_PATCH
(which requires you to apparently edit the uart driver as well).

   does it really have to be this painful?  a number of simple
questions:

* how many patches are there?
* which ones can be selected independently from the others?  and can
   they be made separate selections in the config menu?  (does it even
   make sense to select only some of the possible patches?)
* and can they be documented so the builder knows what the purpose of
   the patch is?
* and can the SMC patch be moved out of the source file and made a
   config-time selection along with the others (might be difficult
   given the necessity of editing the uart driver file).

anyway, you get the idea.

rday

p.s.  i notice in micropatch.c the preprocessor test:

#ifdef USE_IIC_PATCH
#define PATCH_DEFINED
         /* IIC/SPI */
uint patch_2000[] = {
         0x7FFFEFD9,
 	...

i have no idea where the macro USE_IIC_PATCH is defined, if anywhere.
and, trust me, i've looked.  is this dead code?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
