From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
Date: Mon, 2 Oct 2000 22:48:23 +0200
Message-Id: <19340827142007.16524@192.168.1.10>
In-Reply-To: 
 <Pine.LNX.4.10.10010022201500.18032-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10010022201500.18032-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Does atyfb only register console drivers up to 8 bit when booted in 8 bit
>mode? Is the engine configuration different with regard to video memory
>setup between 8 and 24 bit?
>
>Another atyfb issue: if I cold boot the Lombard with external monitor
>attached, the video RAM layout is apparenty set up by OF to match the last
>geometry used by MacOS on that screen (I tried 1152x870) but atyfb draws a
>framebuffer according to the vmode passed to the kernel (1024x768 in this
>case). I need to set the resolution to 1024x768 in MacOS to get a
>decent image on the external monitor in Linux. Seems atyfb doesn't
>properly init the whole engine here. Any idea where to fix that?
>I've noticed the values of MEM_CNTL, EXT_MEM_CNTL and CRT_GEN_CNTL vary
>when booting with the different resolutions or booting directly from OF
>but so far it doesn't look conclusive.
>
>I'm trying to get a handle on using both LCD and external monitor in
>Linux, that's why I started playing with it.

You have to choices. Either enable both outputs on the same CRTC (works
with old "LG" chips found in some wallstreet's), or program both CRTCs
(Rage LT Pro only). In the later case, you can use a different setup for
the LCD, do real dual-head, have a higher refresh rate for the CRT, etc....

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
