Date: Thu, 26 Aug 1999 10:52:33 +0200
To: "David A. Gatwood" <dgatwood@mvista.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Performa 5200
Message-Id: <19990826105233.028977@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 25, 1999, David A. Gatwood <dgatwood@mvista.com> wrote:

>It's a bad idea to have any of these three in the same class.  They don't
>act a thing alike.  The NuBus PowerBooks and Performas are KIND of close,
>in that neither has DMA, but their IDE works with different offsets
>between registers, their interrupt handling is almost completely
>different, the video is different... it's substantial enough to make it
>far better to define them as separate classes.  Otherwise, all those
>pieces of code will be riddled with switch statements for a huge list of
>gestalts (16 different numbers for the PDMs alone).
>
>If you want to maintain some sense of naming consistency with MkLinux
>(which is a good idea), we use:
>
>POWERMAC_CLASS_PCI       - almost everything
>POWERMAC_CLASS_PDM       - 6/7/81xx, AWS 6/7/81xx
>POWERMAC_CLASS_POWERBOOK - NuBus PowerBooks
>POWERMAC_CLASS_PERFORMA  - NuBus Performas
>POWERMAC_CLASS_LEGACY    - 68k PowerMacs w/ upgrade cards

BootX already provides this classification (and the huge list of machine
IDs), It only lacks POWERMAC_CLASS_LEGACY for now. (BTW. what about
switching MkLinux to use BootX too instead of the current closed source
booter ?).

We can have all those in the same "Nubus" class in a sense that support
for all those machine can be compiled at the same time (eventually having
optional compiled-in subclasses for the different classes, except PCI).
I'm still wondering if we can have this support without killing the PCI
support (if they must be exclusive). They are not with mklinux but I
don't want to pollute the PCI version of linux/ppc with things like the
eieio/sync hack needed for some NuBus machines, and the memory management
cludges needed for PDM.

>Note that the last two are not quite working yet.  We were close on the
>performas, and the 68k PowerMacs aren't quite as close, but at least some
>of them start booting now with the right config.

I must have a PPC ugrade card and the Quadra 800 that goes with it
somewhere, I'll try to find it, I think it's still in Strasbourg (500Km
away from where I live now).

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
