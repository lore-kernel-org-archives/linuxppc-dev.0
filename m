Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7CB07DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 20:31:50 +1000 (EST)
Date: Thu, 5 Apr 2007 12:32:09 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
Message-ID: <20070405103209.GA15974@aepfle.de>
References: <20070404111635.GA1855@aepfle.de>
	<200704042010.50088.bzolnier@gmail.com>
	<20070404181138.GA6050@aepfle.de>
	<200704042042.15108.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200704042042.15108.bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackeras <paulus@samba.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, Bartlomiej Zolnierkiewicz wrote:

> 
> On Wednesday 04 April 2007, Olaf Hering wrote:
> > On Wed, Apr 04, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > ?
> > 
> > You are right, I did not test the ide driver again. pata_via works with
> > the change. 
> > I will test the ide driver tomorrow.
> 
> Thanks.
> 
> There might be also the another issue here - the chipset claims fully native
> mode (prog-if 8f - taken from your previous mail) so driver takes IRQ value
> from dev->irq (which your patch fixes to be 14 instead of 20 if I'm reading
> it correctly) but in reality chipset seems to be still using legacy IRQs
> (14 for the primary port and 15 for the secondary one).  What IRQ value is
> reported by the libata for the secondary port?  Does the second port work?

The second port does not work. My added printks did not trigger. There
is not enough time to hack on this today.
I found maple_pci_get_legacy_ide_irq, maybe a similar function can be
added for pegasos to remove the ifarch code from the IDE driver.
