Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B70DD1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 12:52:12 +1100 (EST)
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
	PowerMac/PowerBook IDE controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4B15BDCF.5020000@kernel.org>
References: <20091202003630.29919100851@ozlabs.org>
	<4B15BDCF.5020000@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Dec 2009 12:51:18 +1100
Message-ID: <1259718678.2076.1057.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-02 at 10:07 +0900, Tejun Heo wrote:
> On 12/02/2009 09:36 AM, Benjamin Herrenschmidt wrote:
> > This is a libata driver for the "macio" IDE controller used on most Apple
> > PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
> > 
> > It supports all the features of its predecessor, including mediabay hotplug
> > and suspend/resume. It should also support module load/unload.
> > 
> > The timing calculations have been simplified to use pre-calculated tables
> > compared to drivers/ide/pmac.c and it uses the new mediabay interface
> > provided by a previous patch.
> 
> Other than the media bay locking thing I mentioned before, it looks
> good to me and the media bay thing can be dealth with further patches,
> so...
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

I'm not sure what media bay locking problem you mentioned tho...

The way the driver does the locking now is that I block the media-bay
thread (lock/unlock_media_bay calls) around initial registration and
driver removal which blocks the callback event. At any other time, the
callback event will just schedule EH so things should be fine.

I've left the debouncing in the mediabay code as well for both insertion
and removal so there should be no issue here with glitches.

Cheers,
Ben.
