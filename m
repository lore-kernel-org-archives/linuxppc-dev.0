Message-ID: <395B9D13.B6C8C23F@mvista.com>
Date: Thu, 29 Jun 2000 12:01:39 -0700
From: Scott Anderson <sanders@mvista.com>
MIME-Version: 1.0
To: Stefan Roese <stefan.roese@esd-electronics.com>
CC: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IBM405GP startup-code
References: <EFEAIMDCOOOHIEPHDNFJKECMCFAA.stefan.roese@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Roese wrote:
> we are currently developing a cpci board with the ibm 405gp ppc. We would
> like to run linux on this board. Now i have to write the startup-code for
> this board (init of cpu, sdram-controller, etc.). Has anybody allready
> written some startup-code for the 405gp? Would you share this code with us
> to speed up our developement?

We've GNUified the IBM 405GP boot code.  If you want to check it out,
grab these three files:

    ftp://ftp.mvista.com/pub/unsupported/ppc-405gp-boot/405gp_183_beta.tgz
    ftp://ftp.mvista.com/pub/unsupported/ppc-405gp-boot/405gp_fixup
    ftp://ftp.mvista.com/pub/unsupported/ppc-405gp-boot/405gp_myfiles.tgz

The first file is the virgin sources as obtained from the IBM Board
Support Package for the 405GP reference kit.  The second file is a shell
script that does the GNUification.  The third file is a tarball that
contains the files needed by the script.  Throw all three of these files
down in one place and then run the fixup script passing it the name of
the subdirectory that should be created to hold the GNUified stuff.  For
example:

    ./405gp_fixup 405gp_183_beta

It'll sit there for a long time (a couple of minutes) and then finally,
give you a prompt back.  Now that you've done that, cd down into the
directory that contains the "good" stuff:

    cd 405gp_183_beta/osopen/m405_evb/openbios

You can now kick off a make:

    make

It will create a 128k file named openbios.bin that is a binary image.
If you have a IBM Walnut board, you can simply burn this image into the
upper 128k of the Walnut's 512k FLASH (i.e. at 0x60000-0x7FFFF).

I should note that I use the tools from our CDK version 1.0 on an x86
targeting the PowerPC.  In other words, it is going to try to run
powerpc-linux-gcc, powerpc-linux-ar and powerpc-linux-ld.  If you don't
have these tools, they can also be downloaded.  You might want to check
out:

   http://www.mvista.com/products/download.html

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               490 Potrero Ave.
    http://www.mvista.com       Sunnyvale, CA  94086

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
