Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53CE1DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 01:30:09 +1100 (EST)
Date: Mon, 13 Oct 2008 15:29:51 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH RFC] pata_platform: add 8 bit data io support
Message-ID: <20081013152951.53e548ee@lxorguk.ukuu.org.uk>
In-Reply-To: <48F2F5EE.6060201@gmail.com>
References: <20081011180014.GA4908@debian>
	<48F2F5EE.6060201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Wang Jian <lark@linux.net.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Oct 2008 16:17:02 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Hello,
> 
> Wang Jian wrote:
> > +static void pata_platform_postreset(struct ata_link *link, unsigned int *classes)
> > +{
> > +	struct ata_port *ap = link->ap;
> > +	struct ata_device *dev;
> > +	u8 select = ATA_DEVICE_OBS;
> > +
> > +	/* Call default callback first */
> > +	ata_sff_postreset(link, classes);
> > +
> > +	if (!(ap->flags & ATA_FLAG_8BIT_DATA))
> > +		return;
> > +
> > +	/* Set 8-bit mode. We know we can do that */

Not really - the 8bit transfer command is CFA specific not ATA or ATAPI,
in addition it is not needed with most hardware that is running in 8bit
modes. 
