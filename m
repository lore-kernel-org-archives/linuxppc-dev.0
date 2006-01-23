Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 001/001 Updated] PMAC HD runtime blinking control
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
In-Reply-To: <20060124073133.5cab0e93.cedric.pradalier@inrialpes.fr>
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
	<1137898193.12998.83.camel@localhost.localdomain>
	<20060123233823.3f0dbad5.cedric.pradalier@inrialpes.fr>
	<1138024037.4907.24.camel@localhost.localdomain>
	<20060124073133.5cab0e93.cedric.pradalier@inrialpes.fr>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 10:10:26 +1100
Message-Id: <1138057827.4907.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-01-24 at 07:31 +1000, Cedric Pradalier wrote:
> According to Benjamin Herrenschmidt, on Tue, 24 Jan 2006
> 00:47:16 +1100, 
> >> The key I could not understand was that hwif->gendev is
> >> only initialised in the probe. So I had to move the
> >> device creation after that.
> >> 
> >> Currently, it is blinking by default. Should it be that
> >> way? I guess so, since it is activated by a kernel config
> >> option. It is easy to change if required.
> >
> >Yes. In fact, by enabled default for ATA disks and by disabled for ATAPI
> >would make sense...
> 
> How do I tell the difference?. There is a 'kind' in pmif,
> and also a atapi_dma flag in hwif. Which is more sensible?

You need to check drive->media ... Which is a bit annoying since it mans
it's per drive, not per-HWIF... you may want to move your sysfs entry
down one more level :) (Each HWIF has an array of 2 drives, though check
drive->present before expecting a useful struct device there)

> >Also, we should think a bit about the file name... "blinking_led" isn't
> >terrific for something that will end up in a non-ppc specific location.
> >Or maybe on the contrary it's good ... what about "activity_led"
> >rather ?
> >
> 
> I'm open to any suggestion. I'll wait a bit to see if
> someone else has a comment, then I'll change to
> "activity_led". 
> 
> --
> Cedric
