In-Reply-To: <38F5C457.C46F04B2@execpc.com>
Date: Thu, 13 Apr 2000 15:59:06 +0200
To: Joseph Garcia <jpgarcia@execpc.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3
Message-Id: <20000413155906.012320@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 13, 2000, Joseph Garcia <jpgarcia@execpc.com> wrote:

>Could this be related to the IDE issues that have been discovered with
my hard
>drive?  This would mean that there could be a bug in the way DMA is
>implemented
>in hardware on the wallstreet motherboard.  It has been mentioned its
>possible.
>(small flashback: corruption on occation when playing sound, often ro
programs
>when executed (vi got hit; would run, but would error. few flipped bits
>probably), mentioned in SoundJam's readme.  'Contact Apple')

Note that the controller used on the wallstreet is the same used on the
Beige G3 and is very close to the one used in iMacs and B&W G3s.

>Since MacOS doesn't seem to have any of these problems, there is a solution.
>
>my hard drive from dmesg:
>hda: IBM-DYLA-28100, ATA DISK drive
>hda: IBM-DYLA-28100, 7815MB w/459kB Cache, CHS=15880/16/63, (U)DMA
>
>Since my brother's lombard has a Toshiba HD, could this all be funkyness with
>IBM drives, God forbid? (as opposed to just the BMAC+ doesnt have the hw bug)
>
>Before we start being suspicious, anyone with a non-IBM drive having this
>problem?

Well, there is no mention I've seen of such a bug in the Darwin driver.
However, there are a few things worth noting:

 - Darwin enables a bit in the host bridge that allows retrying of some
DMA transactions. Look like this bit is necessary (don't ask me why) and
is not set by the firmware. I have added code to set it in my recent
kernels. However, since Wallstreet's are usually booted via BootX, MacOS
should have set it before entering the kernel. (I don't have the details
under the hand, but you can look in my rsync tree, it's in pmac_pci.c).

 - Older Darwin source contains a comment about a bug in Ohare and Grand
Central DBDMA controller known to clobber datas around memory buffers
when they are not 16-byte aligned. Well, to my knowledge, the IDE always
transfers aligned pages, and the controller in the wallstreet is not an
ohare, but it's worth noting (and should be fixed in other drivers).

 - I have to check what's exactly happening when an odd byte count is
transferred (this happens regulary with ATAPI). The controller itself
always transfer even quantities. Darwin has special provisions for that
by adding a special command at the end of the DBDMA transfer to copy this
remaining byte to a bit bucket. We don't.

 - Before starting a DBDMA command, it would be nice to issue at least a
sync to make sure that the write of the last DBDMA commands to memory has
left the CPU write buffer and will be hanlded by the cache coherency
before the DBDMA controller actually starts. I don't know if there's room
for trouble or not, but this would do no harm. Actually, I'm wondering if
it may be better to store DBDMA command lists in non-cachable memory.

 - There may be something wrong in the MDMA timing calculations. The code
we use should be equivalent to darwin. but...


That's all I have in mind for now. Of course, there's still the
possibility of a bug in the IDE layer that would cause this corruption...
(or a bug in the sound driver that would cause the sound DBDMA channel to
overflow it's allocated buffers but I don't think so).

Note finally that a generic kernel ext2 bug was recently found that could
cause corruptions under certain conditions, especially OOM. (see the
kernel mailing list).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
