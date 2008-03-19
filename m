Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] [POWERPC] Add L2 cache node to AMCC Taishan dts file
Date: Wed, 19 Mar 2008 07:24:51 +0100
References: <1205847466-17854-1-git-send-email-sr@denx.de>
	<20080318232418.GA3323@localhost.localdomain>
In-Reply-To: <20080318232418.GA3323@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803190724.51796.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 19 March 2008, David Gibson wrote:
> On Tue, Mar 18, 2008 at 02:37:46PM +0100, Stefan Roese wrote:
> > This patch adds the L2 cache node to the Taishan 440GX dts file.
> >
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
> >  arch/powerpc/boot/dts/taishan.dts     |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/taishan.dts
> > b/arch/powerpc/boot/dts/taishan.dts index 8278068..d0bff33 100644
> > --- a/arch/powerpc/boot/dts/taishan.dts
> > +++ b/arch/powerpc/boot/dts/taishan.dts
> > @@ -104,6 +104,16 @@
> >  		// FIXME: anything else?
> >  	};
> >
> > +	L2C0: l2c@30 {
>
> A node with no reg property shouldn't have a unit address.

OK, I'll remove the unit address.

> > +		compatible = "ibm,l2-cache-440gx", "ibm,l2-cache";
> > +		dcr-reg = <20 8			/* Internal SRAM DCR's */
> > +			   30 8>;		/* L2 cache DCR's */
> > +		cache-line-size = <20>;		/* 32 bytes */
> > +		cache-size = <40000>;		/* L2, 256K */
> > +		interrupt-parent = <&UIC2>;
> > +		interrupts = <17 1>;
> > +	};
>
> Now.. usually cache nodes are given as descendents of the CPU node.
> In this case you have the DCR control registers though, so I guess
> this is representing a control interface rather than the cache
> itself.  Hrm.. not really sure how to do this.

So should I change the location then?

Best regards,
Stefan
