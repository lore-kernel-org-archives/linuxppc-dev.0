Message-ID: <3B4DCAAD.72D18C80@vnet.ibm.com>
Date: Thu, 12 Jul 2001 16:05:01 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: leigh@solinno.co.uk
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Booting 43P-140
References: <38851.193.133.92.239.994925353.squirrel@lbbrown.homeip.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Leigh Brown wrote:
>
> Hi all,
>
> I forward ported Todd Inglett's 43P-140 patches to 2.4.7pre4 and tried to
> boot - no joy.  I then found a 43P-140 image on SuSE's web site and tried
> that - no joy.  Here are the steps I took:

Hi Leigh,

  First questions, what do you have in the machine cardwise? What video card in
particular the GXT110P, GXT120P and GXT130P adapters should all work. If you
have 2.4.7prex from ppc.bitkeeper.com as your base sources then the GXT300P and
GXT2000P should also work.

  Do you have the latest firmware update on your machine? (It's like TIG99
something)

> 1. I dd'd the image onto a floppy (get some result with both images)

  Don't dd. Copy the zimage to an msdos floppy and name the file zimage.

  Hit f8 when you see the icons on your screen. This will put you at the OF
prompt.

  If you don't get to the OF prompt, that means you don't have the firmware
update.

  If you do get to the prompt, then type

0>  setenv real-base c00000
0>  setenv load-base 200000
0>  boot floppy:,\zimage root=/dev/fd0 load_ramdisk=1 ramdisk_size=128000

  SuSE uses a large ramdisk for their install ... if you don't have gobs of
memory you can throttle that back a bit but do so at your own risk.

  That should be it.

> 2. I set the bootlist in AIX to floppy followed by hdisk0.
> 3. I set up the machine to boot from tty0 (using my trusty Psion 5).
> 4. I boot the machine, it displays the "Loading Software" screen on
>    the terminal and reads about the right amount of data from the floppy.
> 5. I get no messages, just a newline emitted at the end - the LED gets
>    stuck on F05 (I think, I didn't write it down).
>
> Pointers to what to do next would be gratefully received - I am very keen
> on getting Linux going on this box (I couldn't afford a bigger one :-) and
> will be able to help with testing kernels and so on once its up and running.
>
> Cheers,
>
> Leigh.

Regards,

Tom

--
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
