To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Booting Linux from an already running linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Jan 2003 10:05:50 +0100."
             <8CD0F4AF-23B1-11D7-98E2-0003931C2BFA@control.lth.se>
Date: Thu, 09 Jan 2003 10:18:15 +0100
Message-Id: <20030109091820.6A667C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <8CD0F4AF-23B1-11D7-98E2-0003931C2BFA@control.lth.se> you wrote:
>
> Now that I have a Linux running with networking on a PrPMC800 running as
> NON-MONARCH, I wonder if anybody knows about a program that can start a
> fresh linux kernel from the filesystem. The reason I need this, is that the

That's Magnus Damm's "relf" (Reload ELF file) package.

> In theory it should be simple (given that we have enough RAM):
>
>    1. Load the new image into RAM (userspace)
>    2. Disable interrupts
>    3. Copy image from userspace RAM to contiguous (physical) memory
>    4. Jump to code in the contiguos (physical) memory
>
> Does anybody know of such a program?

Freom the relf README:


    A driver to load and start a new elf file from within Linux.
    Released under the terms of GPL, see COPYING.
    Right now is only mpc8xx supported, patches are welcome.
    I've started vxWorks(tm), pSOS(tm) and Linux(tm) with it.

    This driver implements two character devices:
    /dev/relf	  c 242 0
    /dev/relf_cmdline c 242 1

    Usage:
    Simply write the elf-file to /dev/relf (cat, dd or whatever).
    When /dev/relf is closed the zImage will be started.

    Optionally you can first write an argument string to /dev/relf_cmdline.
    You can read back the current argument string from /dev/relf_cmdline
    at any time. Opening /dev/relf_cmdline for writing will clear the
    argument string (use echo -n >/dev/relf_cmdline to remove a previously
    written argument string).

    x86 Notes:

    The driver works with arch/i386/boot/compressed/bvmlinux.out kernel
    image, rather than arch/i386/boot/bzImage.
    So, arch/i386/boot/compressed/bvmlinux.out is the file that is to be
    copied to the /dev/relf node.
    Also, there is no support for ramdisk images (yet).


    Credits:

    Magnus Damm <damm@opensource.se> - maintainer
    Marcus Sundberg <marcus@cendio.se> - command line support
    DENX <wd@denx.de> - x86 support


Sorry, I don't know a URL for download. Ask Magnus for  help;  if  he
does  not  reply  I  can  help with a copy, too (but probably not the
latest version).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When the ax entered the forest, the trees said, "The handle is one of
us!"                                               -- Turkish proverb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
