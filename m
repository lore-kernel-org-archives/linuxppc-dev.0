Date: Wed, 15 Sep 1999 16:48:28 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Ethan Benson <erbenson@alaska.net>
cc: Peter Bierman <bierman@apple.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: New booter
In-Reply-To: <v04210106b405d3d533a4@[192.168.0.1]>
Message-ID: <Pine.LNX.4.10.9909151639120.31363-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 15 Sep 1999, Ethan Benson wrote:

> On 15/9/99 Peter Bierman wrote:
> 
> >The bootblock on a Macintosh is specified as a structure in an HFS filesystem.
> 
> therein lies the problem....

That's not a problem, that's helpful.  As Kevyn pointed out (maybe just on
IRC) is if you nuke the NVRAM on a SPARC, yer dead.  If you do that on a
Mac, you're fine.  Lots of other archs have the same problem.  re-write
your bootblock, you're dead on x86.  Macs have the "Can't shoot my foot
off" feature.   This isn't bad.

> >So I'm not sure what you mean then by the "bootblock of the disk".
> 
> on intel machines disks are typically use the very first 512 bytes on 
> a disk as a bootblock and partition table, the bootblock portion of 
> this is something like 446 bytes long, the BIOS when booting the 
> machine has a boot device specified all it does it load that 446 
> bytes into memory and execute it that code could be the NT loader the 
> old DOS/win95 loader or it could be LILO, that code then can do 
> whatever it need to do.  in lilos case it loads its second stage 
> loader from the root filesystem and that takes care of loading the 
> kernel, if you replace ext2fs with xfs all that needs updating is 
> possibly the second stage LILO.  no specific partition or filesystem 
> is needed and the BIOS does not care what filesystem you use.

But a good loader knows how to deal w/ FSes.  The FreeBSD loader is
wonderful, and can boot any kernel on the disk, unlike lilo.

> > >requiring a dedicated partition for the BOOTSTRAP is ridiculous.
> > >and so is chaining oneself to a single filesystem (HFS)
> >
> >NewWorld machines have flashable firmware, and OF can then be updated to
> >understand different filesystems.
> 
> filesystem code does not belong in the firmware.  its not needed 
> either if the boot process is done like it is on intel machines, 
> which works pretty darn well if you ask me.

See above.

> >But I still have to support the ability to boot *before* OF gets updated.
> >So for UFS systems on NewWorld machines, we have an HFS volume that
> >contains all of the OF patches we need, and the booter to find and launch
> >the kernel from the UFS volume.
> 
> fine maybe you need this on older machines, but the newer machines 
> should fix this deficiency, and sport a filesystem INDEPENDANT boot 
> process, this way linux and BSD folks don't have to go though such a 
> large pain to get their OSes to boot.

Why do you need a filesystem independant boot process?  That limits us to
something tiny, rather useless and ugly.

> >HFS systems on NewWorld machines will just boot directly from the root volume.
> 
> if the root volume is HFS, I don't want to use HFS, I like UFS just 
> fine, and what if I add xfs or someother filesystem support to darwin 
> how do it boot it now? I have to go back to this messy bootstrap 
> partition junk.

Thats the price to pay for something nice and elegant.

> can you see why relying on HFS or any specific filesystem is inconvenient???

Not really.

> if you cannot get around the partition hack on older machnes fine use 
> it there, but for the newworld flashable macs and all future please 
> make a filesystem agnostic boot process.  that is really all I am 
> asking of apple.

Why?  Why would apple spend all sorts of time and money on something that
gains them nothing.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
