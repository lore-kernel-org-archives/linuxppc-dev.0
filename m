Date: Sat, 6 Nov 1999 17:22:03 -0500 (EST)
From: "Derrik Walker v2.0" <firebug@apk.net>
To: Jim Hickstein <jxh@mirapoint.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Physical disk size 65536 blocks for an 8G drive
In-Reply-To: <3824A23B.40DE2680@mirapoint.com>
Message-ID: <Pine.LNX.4.10.9911061719150.17987-100000@zzzt.apk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just went though this last night.  I ended up manually formating the
disk with /sbin/mke2fs -i 2048  This will get it formated with 2k inodes.
However, I think I could have used 4096 and been fine.

Hope this helps.

Purhaps there is a page for my Mucking Around With Computers Page.

On Sat, 6 Nov 1999, Jim Hickstein wrote:

> 
> Sorry to post what amounts to a support question on -dev, but it did not
> get an answer on -user.  I'm afraid it's too arcane, so I appeal to you.
> 
> I have a PBG3 Wallstreet and recently bought a new 8GB drive to put in
> it, an IBM DYLA-28100.  MacOS 8.6, update the drivers, so far, so good. 
> I managed to get pdisk to make partitions (after umounting /mnt/cdrom
> from /dev/hda to silence a warning in writing the partition table). 
> MacOS runs fine, with volumes in hda10 (5GB hfs+) and hda11 (600MB hfs),
> _above_ Linux.  But Linux barfs mounting / on /dev/hda7 (and even worse
> for /usr on /hda9), saying that the superblock reports a size of
> so-and-so (~131000 for /) but the _physical size of the disk_ is 65536 blocks.
> 
> Evidently something is reporting a block count of 0xffff, and it's
> getting incremented to tell me the "length".  Yet, the drive probes
> correctly (apparently) and reports a size of 7145MB or so.
> 
> fsck is the one telling me this, for /dev/hda7.  For /dev/hda9, it
> really complains, saying that inode 3 is corrupt, etc.  Part of hda7 is
> below 0xffff blocks, but all of hda9 is above it.
> 
> Any ideas?  This is 2.2.10 off the Q3 distribution.
> 


 -Derrik

mailto:firebug@apk.net
http://junior.apk.net/~firebug
------------------------------
Thinking Different???  Think Linux!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
