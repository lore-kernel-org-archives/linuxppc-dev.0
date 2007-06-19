Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1B050DDF1C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 16:03:40 +1000 (EST)
Date: Mon, 18 Jun 2007 23:03:57 -0700 (PDT)
Message-Id: <20070618.230357.08341020.davem@davemloft.net>
To: hch@lst.de
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070619055358.GD18542@lst.de>
References: <20070615171545.316dfac7@the-village.bc.nu>
	<20070615.141917.85409547.davem@davemloft.net>
	<20070619055358.GD18542@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: axboe@kernel.dk, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Geert.Uytterhoeven@sonycom.com,
	dwmw2@infradead.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 19 Jun 2007 07:53:58 +0200

> On Fri, Jun 15, 2007 at 02:19:17PM -0700, David Miller wrote:
> > Another quirk I have to deal with is that under LDOMs you
> > can export full disks and also just slices.  So I'll have
> > to get down into the partition machinery to support that
> > somehow.
> 
> What's the problem with that?  Partition machinery is perfectly
> fine with just getting a raw disk without a partition table,
> and it obviously doesn't care if the raw disk it sees is part
> of a partition on the storage server.

Applications care :-)

One way of managing the partition table is by asking the storage
server for it.  It supports giving back something that looks
like the Sun partition table layout, and also something that's
EFI based.

But the client can ignore that and read/write the partition
table itself.

What I really care about is what will work transparently for existing
userspace.  In particular, distribution installers and existing tools
like fdisk.

When a slice it being exported, it's not being exported like that so
that the client can just spam a disk label into it, it's for exporting
one slice.  So we might want (using the scsi naming as an arbitrary
example case) /dev/sda1 to be created but not /dev/sda

How exactly do you envision this kind of thing working?

Supporting the disk-server-provided partition table management
means providing ioctls() or whatever interface to get/set
the table.  I had one idea to intercept reads/writes to the
first block(s) and translating those into partition management
commands to the disk server, but that is just too ugly to live. :-)
