Message-ID: <3917E2A7.6EEDDD93@vas-gmbh.de>
Date: Tue, 09 May 2000 12:04:23 +0200
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Getting the image section of the ELF file to load w/ VxWorks boot
 ROM
References: <m12mgPF-001SyZC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I had similar problems when loading kernel images with gdb over BDM into
an MPC.
I have no solution (which would be a patch to the Makefile in
/usr/src/linux/arch/ppc/mbxboot) but I try to handle the symptons:
  powerpc-linux-objcopy \
    --set-section-flags=image=contents,alloc,load,readonly,data \
    --adjust-section-vma=image=$(powerpc-linux-objdump -h
$kernel/zvmlinux | grep .bss | awk '{print "0x"$4}') \
    $kernel/zvmlinux \
    $kernel/zvmlinux2

The first command to objcopy is to set the 'load' flag for the image
section. Without this, gdb won't load this section.
The second is to patch the load address of that section to be the same
as the .bss section. I'm a little bit unsecure about the last, but it
seems to work. I think this is what the loader expects and I hope
someone can verify this?

hth
	Frank

--
===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097
Hamburg,GERMANY,TEL:+49-40-238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at
http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
