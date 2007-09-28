Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by ozlabs.org (Postfix) with ESMTP id 36C86DDF03
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:42:34 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2057876nzh
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 13:42:34 -0700 (PDT)
Message-ID: <fa686aa40709281342h4f8ff3fdv265e8098d2da6f52@mail.gmail.com>
Date: Fri, 28 Sep 2007 14:42:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 06/18] [POWERPC] Fix UARTLITE reg io for little-endian
	architectures (ie. microblaze)
In-Reply-To: <20070928203104.GC23749@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181704.18608.40317.stgit@trillian.cg.shawcable.net>
	<20070928203104.GC23749@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/28/07, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Sep 28, 2007 at 12:17:13PM -0600, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > Acked-by: John Williams <jwilliams@itee.uq.edu.au>
> > ---
> >
> >  arch/ppc/syslib/virtex_devices.c |    2 +-
> >  drivers/serial/uartlite.c        |   32 ++++++++++++++++----------------
> >  2 files changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
> > index ace4ec0..270ad3a 100644
> > --- a/arch/ppc/syslib/virtex_devices.c
> > +++ b/arch/ppc/syslib/virtex_devices.c
> > @@ -28,7 +28,7 @@
> >       .num_resources = 2, \
> >       .resource = (struct resource[]) { \
> >               { \
> > -                     .start = XPAR_UARTLITE_##num##_BASEADDR + 3, \
> > +                     .start = XPAR_UARTLITE_##num##_BASEADDR, \
> >                       .end = XPAR_UARTLITE_##num##_HIGHADDR, \
> >                       .flags = IORESOURCE_MEM, \
> >               }, \
> > diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
> > index f5051cf..59b674a 100644
> > --- a/drivers/serial/uartlite.c
> > +++ b/drivers/serial/uartlite.c
> > @@ -61,7 +61,7 @@ static int ulite_receive(struct uart_port *port, int stat)
> >       /* stats */
> >       if (stat & ULITE_STATUS_RXVALID) {
> >               port->icount.rx++;
> > -             ch = readb(port->membase + ULITE_RX);
> > +             ch = in_be32((void*)port->membase + ULITE_RX);
>
> Hmm, I see the start changed, and you're now reading/writing a full
> 32-bit word instead of individual bytes. Still, looks a little fishy to
> me. Wouldn't it be more appropriate to change the ULITE_RX offset to be
> 3 higher and still read/write bytes?
>
> Or are the registers defined as 32-bit ones? (I don't remember, it was
> so long since I touched uartlite myself. :-)

All the registers are defined as 32 bit ones.  I think it makes more
sense to access the registers as they are documented, and it
eliminates the 'magic' +3 needed to make it work now.

>
> (Same for the other functions below, but the general principle applies.)
>
> Also, I'm not sure you need to cast port->membase to void*, do you? The
> math will still be right since it's declared as char *.

membase is now defined as u32*, so the cast is needed.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
