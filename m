From: jcarr@mail.linuxppc.org
Date: Thu, 9 Nov 2000 11:12:09 -0600 (CST)
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Example miboot on new world rom problem
In-Reply-To: <19341004092456.12247@192.168.1.2>
Message-ID: <Pine.LNX.4.21.0011091043510.1824-100000@jcarr.linuxppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Some new ibook I think. I get the same behavior on the iMac DV. Startup
> >disk doesn't change the boot-device value on there. Instead, it loads the
> >first TBXI file from the first HFS partition it finds. Then the MacOS ROM
> >finds out that "LinuxPPC Boot" is the name of the partition to boot and
> >then continues...
> >
> >Thus miboot is loaded on a new world rom machine.
> >
> >This is the reason I think either:
> >
> >1) yaboot needs the code from pmac_support.c (aka SetPRAMBoot )
> >
> >2) We'll have to write a new startup disk control panel( like system disk)
>
> Whatever you do with SetPRAMBoot won't help since miBoot won't boot reliably
> the new machines. The problem is to have MacOS Startup Disk properly set boot
> to the yaboot image... I beleive you checked that you have the proper
> <COMPATIBLE> entries for those new machines in the OF boot script ?
> (tbxi should be a script that in turns load yaboot, look at ybin scripts).

Yes I need to look at the ybin script again. However, this doesn't fix the
problem of miBoot running on New World ROM machines and also does not
provide a solution to the problem either. The problem that the guy was
having with his ibook and I have with the iMac DV. The only way that this
guy is left to boot yaboot is to go into OF and do:

boot hd:9,\\:tbxi

The functionality of SetPRAMBoot(by that I mean the ability to do what
startup disk does) needs to be added to yaboot not for the reasons I
stated earlier. So I was wrong about the reasons I stated in the last
email. Sorry about that... this all can be rather convoluted! This
functionality needs to be there if yaboot is to ever allow users to select
thier MacOS boot partitions.

In the other case, miBoot needs to have the ability to change the
boot-device if it detects that it is running on a New World ROM
machine. Maybe Harry Eaton or Mike Tesch are still around and can help
grok bootvars code to add to miboot?

Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
