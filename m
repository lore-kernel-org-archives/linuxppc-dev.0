Message-ID: <3936077A.7075C045@nsw.bigpond.net.au>
Date: Thu, 01 Jun 2000 16:49:30 +1000
From: Duncan Palmer <dunk@nsw.bigpond.net.au>
Reply-To: dunk@zip.com.au
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, DBrown03@harris.com
Subject: Re: Questions about 8xxrom 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> "Brown, David (dbrown03)" wrote:
>
> > .....  But 8xxrom was
> > intended to work with disk in addition to flash, so I started exploring why
> > ELF-loading didn't work.

Dan Malek wrote:
>
>
> The zImage is simple.  It is not an ELF image.  Strip the 64k header
> from the image.  Load the bits at or above 0x00200000.  Jump to the
> first instruction.
>
> If you are loading from a disk, which I presume has a file system, you
> know the size of the file.  Just load it.  I know originally the loader
> knew it had to load at or above 0x00200000.......It also knew it was
> loading a zImage, and if the ELF header was found knew what it could
> believe or not and how to start a zImage.  I don't know what the code
> looks like today, as I am still using the old stuff from years ago.

I posted a couple of patches to Raphael Bossek (the guy who maintains
8xxrom now) a couple of months back which are really worth applying
(they add support for RPX classic boards, clean some things up
considerably, and make it cleaner to add support for new boards). These
live on raphaels site at www.s4l.de, or mine at www.zip.com.au/~dunk

These patches include little chunks of code to load images from flash
(safely ignoring all elf headers ;)). From memory, the code which loads
elf images from disk expects what is in the elf header to be correct
(which is obviously a broken assumption a lot of the time).

Dunk

PS. Please cc: any replies to me as I'm on holidays at the moment, and
so am not subscribed to the list.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
