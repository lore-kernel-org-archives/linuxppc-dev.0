To: khendricks@ivey.uwo.ca
Cc: brad@turbolinux.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128fb does not work in newer sawtooth machines
In-Reply-To: Your message of "Sat, 11 Mar 2000 12:22:50 -0500"
	<00031112260400.11535@localhost.localdomain>
References: <00031112260400.11535@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000313014927K.roikawa@rr.iij4u.or.jp>
Date: Mon, 13 Mar 2000 01:49:27 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Hi,
>
> Well from the of-device tree I have found out that my graphics card device id
> is 0x5046 which equates to a Rage 128 Pro PF card.
>
> Luckily the r128 driver in XFree 4.0 knows about this card and it is not
> significantly different from the Rage128 RE card I have in my B+W G3.
>
> I think the whole thing comes down to the default timing info being okay for
> Rage128RE but not okay for RAGE128PF
 PLL Timing probe is one of TODO things accordinig to the notes by Anthony, IIRC.
So it is normal that display FIFO isn't optimally set up other than the card of
ref.clock=29.5MHz, vram bus width/clock=128bit/75MHz and the same type of SGRAM,
that can cause screen split, snowing, blank screen, etc. to the high clock cards
and especially to the 64bit vram bus card(ex. iMacDV).

>  >  > I looked in aty128fb.c in the kernel
> and they hav hardwired defaults which I > can easily change but I need to know
> about timing info that Mac OS uses. >  > Do you know of any probe code or
> anything at all that can determine timing info > from the MacOS side of things.
>
> I will keep looking.
>
> I am going to add this card to the Xpmac source so that it tries to use its
> acceleration code simply on the straight OF frame buffer.  If that works, then
> I should be able to use Xpmac to get some of timing info.
 Yes, Xpmac should run by simply adding 'PF' to the probe list, but you don't
need to run Xpmac since MacOS(and OF?) adds clock timing field to device-tree
like as,

/proc/device-tree/pci/ATY,Rage128y:
name             "ATY,Rage128y"
vendor-id        00001002 (4098)
device-id        00005245 (21061)
...............................
RF,XCLK          00001d4d (7501)
RF,MCLK          00001d4d (7501)
RF,VCLK          000059a6 (22950)
RF,REF           00000b86 (2950)
...............................

You can put your own values to aty128fb, or more simply, try to read DDA_CONFIG/
DDA_ON_OF registers when offb is running and directly write these values when
aty128fb is running, if it works or not.
 Also, I guess XFree86 3.9 or 4.0 should run without aty128fb as far as PLL/SGRAM
timings are set up correctly, but I don't have time to try...


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

PS. Please don't forget to build the (a)-(c) for Robert.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
