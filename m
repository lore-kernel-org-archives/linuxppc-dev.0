Date: Wed, 15 Sep 1999 17:23:58 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Ethan Benson <erbenson@alaska.net>, Peter Bierman <bierman@apple.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: New booter
In-Reply-To: <Pine.LNX.4.10.9909151639120.31363-100000@opus.bloom.county>
Message-ID: <Pine.LNX.3.96.990915171236.32318R-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 15 Sep 1999, Tom Rini wrote:

> > >So I'm not sure what you mean then by the "bootblock of the disk".
> > 
> > on intel machines disks are typically use the very first 512 bytes on 
> > a disk as a bootblock and partition table, the bootblock portion of 
> > this is something like 446 bytes long, the BIOS when booting the 
> > machine has a boot device specified all it does it load that 446 
> > bytes into memory and execute it that code could be the NT loader the 
> > old DOS/win95 loader or it could be LILO, that code then can do 
> > whatever it need to do.  in lilos case it loads its second stage 
> > loader from the root filesystem and that takes care of loading the 
> > kernel, if you replace ext2fs with xfs all that needs updating is 
> > possibly the second stage LILO.  no specific partition or filesystem 
> > is needed and the BIOS does not care what filesystem you use.
> 
> But a good loader knows how to deal w/ FSes.  The FreeBSD loader is
> wonderful, and can boot any kernel on the disk, unlike lilo.

Agreed.  In fact, I'd go so far as to say that lilo on PCs is a kludge. 
After all, it's a program that has to fit into a little 512 byte chunk of
tightly coded assembly that has a number of bugs that are, as a result,
hard as heck to fix.  Further, it requires you to have a running linux
system to configure lilo to be able to boot.  What?  You don't have a
running linux system?  Your lilo.conf stuff got hosed?  Go fetch a rescue
disk.

Any booter that doesn't understand filesystems and has to have a list of
blocks is a serious kludge.  For instance, who is to say that you want to
boot off a block device at all?  And what if I wanted to replace a kernel
from within another OS?  Can you say pain in the...

As for the contention that lilo works for 90% of the cases, in only a few
weeks working with x86 machines, I've already run across a case where it
couldn't be installed.  Perhaps a fluke that I'd run across it that
quickly, but a _good_ boot mechanism works 100% of the time.  Depending on
a particular block to be always unused is more than a kludge, it's
downright dangerous.  What if two architectures share a drive?  What if
they happen to pick the same critical boot block?  Baaaad idea.  At least
if it's a filesystem at a particular location, you can read it and say
"hey, that's not a valid fs" or "hey, that partition table is bogus".
With a boot block, there are no second chances.  You just crash.


Later,
David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
