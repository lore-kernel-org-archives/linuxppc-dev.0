Date: Mon, 28 Jun 2004 06:13:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash? 
In-Reply-To: <20040628070916.706A6C109F@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0406280600140.3259@localhost.localdomain>
References: <20040628070916.706A6C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(sorry, i realize that this isn't directly related to PPC issues.)

as a first followup question, now that i've just created a 4M
partition on an 8M flash chip, and formatted it as JFFS2, if i put a
copy of the root FS on that filesystem, i can of course boot and use
that as my root filesystem.  but, at the moment, since i'm booting
with what is essentially a zImage.initrd, the kernel is first loaded,
and then the uncompressed root filesystem is copied into RAM of
course.

i suspect that leaving my root filesystem in flash would cause
noticeable performance problems (even if i managed to structure it so
that it could be read-only).  how hard would it be to automatically
have that root FS copied from JFFS2 to RAM and mounted from there?
can that be done as a kernel option i haven't seen?  or do i have to
do that manually, involving something like "pivot_root"?  or is it
worth the trouble?

On Mon, 28 Jun 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0406271836300.10210@localhost.localdomain> you wrote:
>>
>>    with this configuration, it's obviously not possible to update files
>> or directories in the bootable image individually -- it's just one big
>> zImage.initrd image.
>
> What makes you think that this is not  possible?  If  there  is  (for
> example)  a  writable JFFS2 partition available, you can use this for
> an overlay filesystem to store the updates.
>
> See for example the "mini_fo" overlay filesystem on  our  FTP  server
> and the paper about it:
> http://www.denx.de/PDF/Diplomarbeit-MK-1.0-net.pdf

ah, now this looks interesting.  from a quick glance, is this just a
theoretical concept, or has it been implemented?  we have *some* JFFS2
space available, but not a guaranteed amount.  if this requires a
completely separate JFFS2 partition, we might not be able to handle
that.

>>    but is it feasible to redefine the layout of that flash chip and
>> take, say, 4M of it and create a JFFS2 filesystem, then put the root
>> filesystem in there uncompressed?  (assuming, of course, that the
>
> Standard JFFS2 code will always compress.

sorry, i'm not sure what you're saying here.  are you saying that i
can create a compressed JFFS2 image of my root filesystem on my build
host, just as i do when i create my zImage.initrd?  or just compress
the individual files in the filesystem?  and have this filesystem
automatically loaded into, and mounted from, RAM?  can you clarify
this?

> This is a pretty standard setup. Although I don't really recommend to
> use JFFS2 for root filesystem (for example, because with a  big  root
> filesystem  the boot time may deteriorate).

that was one of my concerns -- not just the boot time but the run
time, even if i could structure it as read-only.

> Instead, we usually split the stuff in a read-only partition (for
> example cramfs), a volatile part (tmpfs), and a persistent storage
> partition (JFFS2).

that's awfully close to what we're doing now.  we've got the tmpfs, we
have a completely separate flash for persistent apps and data, it's
just the root filesystem that i would *dearly* love to be able to
patch on the fly on a running system.  i'll look a lot more closely
into the above.  thanks.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
