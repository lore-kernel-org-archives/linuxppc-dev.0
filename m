Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id D9DD2DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 09:30:46 +1000 (EST)
Date: Wed, 7 May 2008 00:30:37 +0100
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for Analogue & Micro ASP837E board
Message-ID: <20080507003037.2bec5820@neuromancer.mindspace>
In-Reply-To: <8D90346B-3E16-4B77-BFF0-35F1FAA1B2B8@kernel.crashing.org>
References: <20080506032813.19e2d07a@neuromancer.mindspace>
	<8D90346B-3E16-4B77-BFF0-35F1FAA1B2B8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 6 May 2008 08:37:16 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

/;
> > +
> > +/ {
> > +	model = "ASP8347E";
> > +	compatible = "ASP8347E";
> 
> "analogue-and-micro, ASP8347E";

Fair enough.

> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x8000000>;	// 128MB at 0
> 
> is memory really fixed on this board or does the bootloader set this  
> if, dynamic make it <0 0>

It's fixed as far as I know.


> > +	soc8349@ff000000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		device_type = "soc";
> > +		ranges = <0x0 0xff000000 0xff100000>;
> 
> this is wrong, size should be like 0x100000

Agreed - typo !

> > +		enet0: ethernet@24000 {
> > +			cell-index = <0>;
> > +			device_type = "network";
> > +			model = "TSEC";
> > +			compatible = "gianfar";
> > +			reg = <0x24000 0x1000>;
> > +			local-mac-address = [ 00 08 e5 11 32 33 ];
> > +			interrupts = <32 0x8 33 0x8 34 0x8>;
> > +			interrupt-parent = <&ipic>;
> > +			phy-handle = <&phy0>;
> > +			linux,network-index = <0>;
> 
> you shouldn't need this anymore. we should be using the aliases.


Aliases sound good to me. Don't know too much about how this should be defined
in a dts though, do you have an example I could use as a base for reference ?

Cheers.
