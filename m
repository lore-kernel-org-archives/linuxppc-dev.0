In-Reply-To: <199911172134.WAA00322@piglet.grunz.lu>
Date: Fri, 19 Nov 1999 11:30:16 +0100
To: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: OF boot and kernel devices
Message-Id: <19991119113016.007097@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 17, 1999, Michel Lanners <mlan@cpu.lu> wrote:

>Is this really needed in the kernel? How about running the bootloader
>_installer_ in order to configure OF? Once you get to the bootloader
>itself from OF, and if you include filesystem code in it, there's no
>need to configure anything else than a simple loader config file (à la
>quik).

I would prefer avoiding filesystem writes from the bootloader. I'm not
100% sure they work fine in OF (I learned not to rely on OF
functionalities that Apple doesn't use) and, in some cases, the
bootloader will have only readonly fs support (iso, maybe others). 

>Yeah, that would make the HFS booter partition acceptable. I guess it
>will always be a major pain to get to an HFS partition from Linux, so
>make whatever needs to be there as static as possible (no kernels, no
>config files).

As Ethan suggested, we can have to booter config file in /boot, and have
a simple script based on the hfsutils that will copy this to the
bootstrap partition. Not very much different from re-launching quik or
lilo when you change your config anyway.

>If I remeber correctly, OF 1.05 in the first PC Macs is unable to load
>from a specific partition, but rather loads from the first bootable
>partition on the specified disk. Therefore, I think that partition
>browsing is a must for the bootloader, or you're limited to as much
>boot partitions as you have disks.... Which doesn't make booting
>various installs easier (think R4/R5, LinuxPPC/YellowDog, maybe
>MkLinux...)

At first, I'm limiting myself to OF 3.x (newworld machines). Then, I'll
look into back-porting to previous OF versions.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
