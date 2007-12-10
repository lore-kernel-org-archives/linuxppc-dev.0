Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 51143DDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 10:25:42 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so1348214nfd
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 15:25:40 -0800 (PST)
Date: Tue, 11 Dec 2007 02:16:38 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH RFC 7/7] [POWERPC] MPC8360E-RDK: add support for NAND
	on UPM
Message-ID: <20071210231638.GA1198@zarina>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204951.GG32278@localhost.localdomain>
	<20071210230321.GA5495@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071210230321.GA5495@localhost.localdomain>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2007 at 10:03:21AM +1100, David Gibson wrote:
> On Mon, Dec 10, 2007 at 11:49:51PM +0300, Anton Vorontsov wrote:
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  arch/powerpc/boot/dts/mpc836x_rdk.dts     |   24 +++++++++++++++++++++++-
> >  arch/powerpc/platforms/83xx/Kconfig       |    2 ++
> >  arch/powerpc/platforms/83xx/mpc836x_rdk.c |    1 +
> >  3 files changed, 26 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
> > index a1b2da6..f57ba53 100644
> > --- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
> > +++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
> > @@ -115,7 +115,7 @@
> >  			device_type = "ipic";
> >  		};
> >  
> > -		par_io@1400 {
> > +		qe_pio: par_io@1400 {
> >  			reg = <0x1400 0x100>;
> >  			num-ports = <7>;
> >  		};
> > @@ -229,4 +229,26 @@
> >  			interrupt-parent = <&ipic>;
> >  		};
> >  	};
> > +
> > +	localbus@e0005000 {
> > +		#address-cells = <2>;
> > +		#size-cells = <1>;
> > +		compatible = "fsl,mpc8360erdk-localbus",
> > +			     "fsl,mpc8360e-localbus",
> > +			     "fsl,pq2pro-localbus";
> > +		reg = <0xe0005000 0xd8>;
> > +		ranges = <1 0 0x60000000 1>;
> 
> The bridge translates a range one byte wide?  I don't think so...

Nope, 4KB min, IIRC.

> > +
> > +		nand-flash@1,0 {
> > +			compatible = "STMicro,NAND512W3A2BN6E", "fsl,upm-nand";
> > +			reg = <1 0 1>;
> 
> The device has a register window *one byte* wide?  That seems
> improbable...

Here, actually yes. The device just 8 bits wide. Reading next 8 bits
will return the same value, obviously. ;-)

But points taken. I should not derivate chip width from the
ranges/reg. This looks unusual indeed, will implement chip-width
property.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
