Date: Mon, 2 Oct 2000 22:11:51 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <Pine.LNX.4.10.10010021658320.1581-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10010022201500.18032-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Sun, 1 Oct 2000, Olaf Hering wrote:
> > while we are about to improve the atyfb, is it possible to fix the color
> > depth switching?
> > When I boot without a kernel arg I end up with 8 bit at console. I can't
> > increase the color depth afterwards with fbset, and mol crashes when it
> > tries to do that. When I specify atyfb:cmode:24 everythings works fine
> > and I can switch down to 8 and back to 24 and mol starts fine.
>
> Does it also crash when you increase the color depth with fbset?

Does atyfb only register console drivers up to 8 bit when booted in 8 bit
mode? Is the engine configuration different with regard to video memory
setup between 8 and 24 bit?

Another atyfb issue: if I cold boot the Lombard with external monitor
attached, the video RAM layout is apparenty set up by OF to match the last
geometry used by MacOS on that screen (I tried 1152x870) but atyfb draws a
framebuffer according to the vmode passed to the kernel (1024x768 in this
case). I need to set the resolution to 1024x768 in MacOS to get a
decent image on the external monitor in Linux. Seems atyfb doesn't
properly init the whole engine here. Any idea where to fix that?
I've noticed the values of MEM_CNTL, EXT_MEM_CNTL and CRT_GEN_CNTL vary
when booting with the different resolutions or booting directly from OF
but so far it doesn't look conclusive.

I'm trying to get a handle on using both LCD and external monitor in
Linux, that's why I started playing with it.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
