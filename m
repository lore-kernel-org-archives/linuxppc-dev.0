Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by ozlabs.org (Postfix) with ESMTP id 9B237DDE45
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 16:03:30 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so1199101nzf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 23:03:28 -0700 (PDT)
Message-ID: <fa686aa40707102303k58bae578u7358b932c4721ec0@mail.gmail.com>
Date: Wed, 11 Jul 2007 00:03:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH] i2c-mpc: work around missing-9th-clock-pulse bug
In-Reply-To: <20070711054923.GA4375@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070709071955.GD4186@moe.telargo.com>
	<fa686aa40707090853j6079b0c7rbcff7c449baa15e0@mail.gmail.com>
	<20070710061736.GG4186@moe.telargo.com>
	<fa686aa40707092322v58bbdad0veb0ee2ec00f125b0@mail.gmail.com>
	<20070710144030.3786cbf3@hyperion.delvare>
	<20070711054923.GA4375@moe.telargo.com>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/10/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> On 10/07/07 14:40 +0200, Jean Delvare wrote:
> > Hi Grant, hi Domen,
> >
> > On Tue, 10 Jul 2007 00:22:05 -0600, Grant Likely wrote:
> > > On 7/10/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > > > Work around a problem reported on:
> > > > http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
> > > > Without this patch I2C on mpc5200 becomes unusable after a while.
> > > > Tested on mpc5200 boards by Matthias and me.
> > > >
> > > >
> > > > Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
> > >
> > > Looks good to me,
> > >
> > > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > OK, I will take this patch, but I'd like you to add a comment before
> > mpc_i2c_fixup() explaining what exactly the problem is and how it is
> > worked around. Otherwise it's a bit obscure what is going on.
>
> OK.
>
> >
> > I guess you want this patch in 2.6.23-rc1?
>
> Yes.
>
> So... v3:
> <----------- cut ------------->
>
> Work around a problem reported on:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
> Without this patch I2C on mpc5200 becomes unusable after a while.
> Tested on mpc5200 boards by Matthias Fechner and me.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>
> ---
>  drivers/i2c/busses/i2c-mpc.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> Index: work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> ===================================================================
> --- work-powerpc.git.orig/drivers/i2c/busses/i2c-mpc.c
> +++ work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> @@ -74,6 +74,24 @@ static irqreturn_t mpc_i2c_isr(int irq,
>         return IRQ_HANDLED;
>  }
>
> +/* Sometimes 9th clock pulse isn't generated, so slave doesn't release
> + * the bus.  Documented and suggested workaround on
> + * http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
> + */

I don't think it's a great idea to use a link;  You should copy the
important parts into the .c file.  Archives may not be forever, and
links cannot be read when offline.  If the text is too long for the
middle of the C file; then put the documentation at the top right
after the header block.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
