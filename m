Mime-Version: 1.0
Message-Id: <v04210110b436a08c1576@[192.168.0.1]>
In-Reply-To: <3810680B.51E0FABD@iname.com>
References: <3810680B.51E0FABD@iname.com>
Date: Fri, 22 Oct 1999 15:30:23 -0800
To: Jim Chapman <jim.chapman@xstreamis.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: bypassing MacOS using Open Firmware on Apple pmac G3
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 22/10/99 Jim Chapman wrote:

>I have an Apple PowerMAC G3 and I currently boot Linux via MacOS using
>BootX. I am trying to configure the Open Firmware (OF) NVRAM settings
>such that Linux is booted by default, but I can't make it work Can
>anyone help?

this is a blue G3 isn't it?  (i recognize the BF version number)

>I have 2 IDE disks. ide0 is used by MacOS and ide1 is for Linux. The
>root partition is on ide1 (hdb5).
>
>I followed instructions in the LinuxPPC Installation Guide but when I
>try to boot, OF displays
>
>boot MAC-PARTS: LOAD (interposed) not supported load-size=0 adler32=1
>
>What is this message telling me? Is the machine still trying to boot
>MacOS?

its telling you that OpenFirmware is complete junk^U its telling you 
that its ignoring the bootblocks on your disk (which contain the 
first stage quik loader) its not necessarily trying to boot macos it 
just won't boot off a disk like that, it insists that you point it at 
a file directly on the filesystem (say the second stage quik loader 
or a linux kernel) the problem is 1) those are on ext2 filesystems 
which OF don't understand, and even if it did the linux kernel 
(unlike *bsd) is unbootable by OF because it lacks the correct OF 
note section in the executable, quik second stage in elf format is 
unusable still since it is clueless on what it is supposed to do.

I have tinkered a tremendous amount hacking trying to figure a way to 
get OF to boot a bootblock off the disk and have not yet found a way, 
Cort tells me he thought someone had done it but has not got back to 
me yet.  (are you out there Cort??)

the next solution I have come up with (for true MacOS freedom) is to 
partition the disk with fdisk using a regular PC DOS partition table 
and make an extra 800K DOS formatted partition then put the quik 
second stage loader on that, this will work and you can get OF to 
boot the quik loader (which right now does not do much other then say 
quik 2.0 and fail) so first we need to teach the elf version of quik 
to presumably parse a configuration file and then to load a kernel 
image off the specified partition.

I would prefer to use DOS partitions since they can be created in a 
GNU/Linux only environment mac partition tables are only bootable if 
there is HFS filesystems on them and you cannot create HFS 
filesystems with GNU/Linux (and may not even be able to mount them 
under 2.4 kernel unless someone picks up the orphaned HFS code)

in short this used to work on older G3s and apple just crippled it on 
the new ones to make their own life difficult along with ours.

>I set the following variables using the OF "setenv" command:-
>
>boot-device    ide1/disk@0:5
>boot-file    ide1/disk@0:5/boot/vmlinux root=/dev/hdb5 hda=noautotune
>hdb=noautotune
>boot-command    dev ide1 cr set-timeout 0 cr boot
>load-base    0x100000 (and 0x4000, 0x60000, 0x10000...)
>
>I guessed that ide1, partition 5 would be represented as ide1/disk@0:5.
>What does that @0 represent?
>Perhaps I need to set other variables?

your settings are fine, just useless because of the crippled 
BrokenFirmware on these machines.

>OF displays its versions as PowerMAC1, 1 1.1f1, Open Firmware 3.1.1.

BlueG3 BrokenFirmware

>I also noticed that the LinuxPPC "nvsetenv" command doesn't display that
>variable values as listed above. Effectively, any changes to boot
>variables I make with "nvsetenv" seem to be localised to the Linux
>environment; they are remembered between reboots, but the values are
>different to those displayed by the OF "printenv" command. It's as if
>the OF "setenv" command and linux "nvsetenv" command modify different
>copies of the parameters in NVRAM!!!! Is anyone else seeing this?

I don't think that utility works right on blue G3s...



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
