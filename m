Message-Id: <199911172134.WAA00322@piglet.grunz.lu>
Date: Wed, 17 Nov 1999 22:34:44 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: OF boot and kernel devices
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
In-Reply-To: <19991117122715.032511@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

On  17 Nov, this message from Benjamin Herrenschmidt echoed through cyberspace:
> I'm working on an OF bootloader (mostly made from quik and poof code with
> a slice of Darwin's SecondaryLoader) that will do everything we have ever
> wanted from an OF bootloader. (My goal is to be able to definitely get
> rid of BootX for newworld machines so that the kernel can rely on the
> phandle values of the device tree and RTAS).

Great! Speaking of quik, the original quik doesn't run on my
G3-upgraded 7600, because of the way BAT registers are set. Paul, did
you ever get around to checking this out? Maybe using the recent
discussion here between David Edelsohn and others?

> In order for such a bootloader to work as transparently as possible, the
> kernel should be able to correctly configure various OF device path (so
> that, after installation, there's no need to go to OF user interface and
> edit the path by hand which is a real pain).

Is this really needed in the kernel? How about running the bootloader
_installer_ in order to configure OF? Once you get to the bootloader
itself from OF, and if you include filesystem code in it, there's no
need to configure anything else than a simple loader config file (à la
quik).

[snip]
>  - The bootloader will probably have to reside on an HFS partition (at
> least for PowerMacs). This would be a small bootstrap partition,
> invisible to MacOS, like MacOS X/Darwin uses. The kernel, of course, can
> be on an ext2 volume (and I'm also thinking about iso for CD booting).
> I'm thinking about putting also the booter config file there, this would
> probably be more coherent since the booter won't rely on a specific linux
> installation (you can have several roots and choose which one to boot).

Yeah, that would make the HFS booter partition acceptable. I guess it
will always be a major pain to get to an HFS partition from Linux, so
make whatever needs to be there as static as possible (no kernels, no
config files).

> Also, I'm thinking about an algorith similar to the one used by Darwin's
> bootloader that could scan available devices for bootable partitions. I
> still have to experiment a bit with this however.

If I remeber correctly, OF 1.05 in the first PC Macs is unable to load
from a specific partition, but rather loads from the first bootable
partition on the specified disk. Therefore, I think that partition
browsing is a must for the bootloader, or you're limited to as much
boot partitions as you have disks.... Which doesn't make booting
various installs easier (think R4/R5, LinuxPPC/YellowDog, maybe
MkLinux...)

> I'm waiting for your advice, I have done some rought experiments for now,
> I'll start real coding on this by this week end.

Happy coding and good luck then!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
