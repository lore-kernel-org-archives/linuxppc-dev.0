Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25C3F1A1D90
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 07:50:58 +1000 (AEST)
Message-ID: <1440021013.2737.14.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/hvsi: Fix endianness issues in the HVSI driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, David Laight
 <David.Laight@ACULAB.COM>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.cz>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Thu, 20 Aug 2015 07:50:13 +1000
In-Reply-To: <55D4F702.4020503@linux.vnet.ibm.com>
References: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB71D3E@AcuExch.aculab.com>
 <55D4F702.4020503@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-19 at 23:37 +0200, Laurent Dufour wrote:
> On 03/08/2015 13:00, David Laight wrote:
From: Laurent Dufour
> > > Sent: 31 July 2015 10:30
> > > This patch fixes several endianness issues detected when running
> > > the HVSI
> > > driver in little endian mode.
> > > 
> > > These issues are raised in little endian mode because the data
> > > exchanged in
> > > memory between the kernel and the hypervisor has to be in big
> > > endian
> > > format.
> > ...
> > > diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
> > > index 41901997c0d6..a75146f600cb 100644
> > > --- a/drivers/tty/hvc/hvsi.c
> > > +++ b/drivers/tty/hvc/hvsi.c
> > > @@ -240,9 +240,9 @@ static void hvsi_recv_control(struct
> > > hvsi_struct *hp, uint8_t *packet,
> > >  {
> > >  	struct hvsi_control *header = (struct hvsi_control
> > > *)packet;
> > > 
> > > -	switch (header->verb) {
> > > +	switch (be16_to_cpu(header->verb)) {
> > >  		case VSV_MODEM_CTL_UPDATE:
> > > -			if ((header->word & HVSI_TSCD) == 0) {
> > > +			if ((be32_to_cpu(header->word) &
> > > HVSI_TSCD) == 0) {
> > 
> > It is generally best to byteswap constants.
> > 
> > 	David
> 
> Thanks David for your review.
> Regarding the byte swapping of the constants, I'm wondering if this 
>  the
> best way here.
> For instance, Benjamin wrote a similar patch to fix another
> endianness
> issue (99fc1d91b8fc) and he doesn't convert the constant neither.
> It think that byte swapping the constant value will impact more code,
> and may not ease code reading.

Right, I disagree with byteswapping the constants at their definition
point, however maybe he meant using cpu_to_be16(CONSTANT) ?

In any case, it's pretty moot as we have the lhbrx instruction which
will do the load and byteswap and for HVSI, even if it was a tad slower
than a normal load, it would not make a noticeable difference.

Ben.
