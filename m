Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp8.wanadoo.fr (unknown [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id F082E2BF17
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 00:53:33 +1100 (EST)
Date: Mon, 3 Jan 2005 15:01:02 +0100
To: mikemartin@linux.ca
Message-ID: <20050103140102.GA9197@pegasos>
References: <20050101150055.GA15400@pegasos>
	<200501011630.j01GUP1R007603@arbas.nms.ulrich-teichert.org>
	<20050101165758.GA18559@pegasos>
	<855e88d00501011715633922b2@mail.gmail.com>
	<855e88d0050102201540148511@mail.gmail.com>
	<20050103070535.GA1644@pegasos>
	<855e88d0050103053915c385ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <855e88d0050103053915c385ec@mail.gmail.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 03, 2005 at 08:39:43AM -0500, Mike Martin wrote:
> On Mon, 3 Jan 2005 08:05:35 +0100, Sven Luther <sven.luther@wanadoo.fr> wrote:
> 
> [snip]
> > There may be some problems with 2.6 kernels and pci irqs on prep. I will
> > investigate this shortly.
> 
> There is definitely something strange happening. The image I used to
> do the (nearly) complete install will no longer configure the network.
> Very inconsistent. I will try it (same image) again later today and
> see if it "just works" next time - like it did last time.

What exact machine do you have again ? 

> [snip]
> > 
> > Yep. Until partman-prep is ready, you should simply try to add the prep flag
> > to the a small partition. I think the normal scheme is to create /dev/sdb1 as
> > a small (8MB ?) prep partition, /dev/sdb2 as swap, and /dev/sdb3 as /. If
> > partman is not able to do it, jump to console 2, and launch parted directly,
> > and do a set 1 prep on.
> 
> Can't jump to console 2 - I can only comunicate through the serial

Ok, then go to execute a shell then.

> console. However I'll give this a shot through the "execute shell"
> menu item. "set 1 prep on"? Haven't seen that documented anywhere,
> what does it do?

set <minor> <flag> <on|off>

minor is the partition, starting at 1, flag is the flag, (prep in this case)
and on|off is obvious.

It simply sets the prep flag, which is then translated as a 0x41 partition
type. I think this is a deficiency in the parted/libparted API, but well,
there is not much we can do about that unless a major libparted change.

> > Then i suppose that copying the kernel is just a matter of :
> > 
> >   dd if=/boot/vmlinuz-2.6.8-powerpc of=/dev/sdb1
> > 
> > but you have to have a small prep partition as /dev/sdb1, or the above will
> > erase whatever you have on /dev/sdb1.
> > 
> 
> I' have the partition ready ...
> 
> Unfortunately, until the network comes back up, I can't get far enough
> in the install to access the SCSI drives (is there another way? Load
> the modules by hand? Which ones?). Without this, I can't get at the
> image I need to boot in order to get it onto the right partition. I
> also can't get it to another machine to net boot it.

He, understood, we definitively need to investigate the pci irq problems. 

> > > I tried booting up with the installer, going to a shell after the scsi
> > > was active and the installed system was mounted. I used sfdisk from
> > > /target/sbin to create a 10 Meg type 41 partition on the first HD
> > > (/dev/sdb0 eventually). I used dd to copy /target/boot/vmlinux to this
> > > partition. But it still won't boot.
> > 
> > Ah, no sure what is wrong. I don't think /dev/sdb0 exists. Not sure really.
> > 
> 
> Actually /dev/sdbX doesn't exist at all during the install from what I

Yep, d-i uses devfs, still partitions start at 1.

> have seen. The drives are refered to as
> /dev/scsi/host0/etc/.../etc/part1. I have two drives, one is 9 Gig
> with scsi id (0,4,0) (/dev/sda) . This is blank except for a 10 Meg
> boot partition; type 41. The second drive is 20 Gig with scsi id
> (0,5,0)(/dev/sdb) which is where the install is.
> 
> I copied (with dd) the file (the wrong file I suspect) to
> /dev/scsi/...../part1 which should correspond to the first partiton on
> the 9 Gig drive.

Indeed.

> I see how much more time I can buy with this machine. It may need to
> go back into storage this week if I can't make it run. Not fun.

What about donating it to debian or something such ?

Friendly,

Sven Luther
