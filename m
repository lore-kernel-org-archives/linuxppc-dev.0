Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8E6DCDDFEF
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 09:08:41 +1000 (EST)
Date: Fri, 15 Jun 2007 16:08:58 -0700 (PDT)
Message-Id: <20070615.160858.26276547.davem@davemloft.net>
To: James.Bottomley@SteelEye.com
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1181947242.3600.8.camel@mulgrave.il.steeleye.com>
References: <20070615171545.316dfac7@the-village.bc.nu>
	<20070615.141917.85409547.davem@davemloft.net>
	<1181947242.3600.8.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: axboe@kernel.dk, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Geert.Uytterhoeven@sonycom.com, dwmw2@infradead.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Fri, 15 Jun 2007 15:40:42 -0700

> On Fri, 2007-06-15 at 14:19 -0700, David Miller wrote:
> > Another quirk I have to deal with is that under LDOMs you
> > can export full disks and also just slices.  So I'll have
> > to get down into the partition machinery to support that
> > somehow.
> 
> For this, it sounds like you might find nbd a more enticing
> proposition ... it already is partition independent and is basically a
> block to net socket exporter.

That's not gonna work, it's a totally different model.

I have a predefined protocol over hypervisor provided "channels" and
page flipping also done by the hypervisor for the bulk data transfer.
For the client side I cannot change the hypervisor nor the server
speaking on the other end.  And when I do write a server I do want
it to be able to speak to all of the existing clients.

There's SCSI command pass through as well, as I keep mentioning as
it's an important reason I don't want to go with any of the non-SCSI
solutions (other than perhaps ATA) being suggested.
