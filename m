Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3205FDE2C1
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:18:55 +1000 (EST)
Message-ID: <484811DE.9@freescale.com>
Date: Thu, 05 Jun 2008 11:18:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	
	<20080604220555.658ab13e@vader.jdub.homelinux.org>	
	<20080604231641.786bb2dd@lappy.seanm.ca>	
	<200806050822.00797.sr@denx.de>
	<4848036D.5060004@freescale.com>	 <484809D1.2070300@scram.de>
	<48480B3C.9080101@freescale.com>
	<fa686aa40806050910m2057966csc33b2a671c6265af@mail.gmail.com>
In-Reply-To: <fa686aa40806050910m2057966csc33b2a671c6265af@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>,
	Scott Wood <scottwood@freescale.com>, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> multifunction@0 {
>         #size-cells = <1>;
>         #address-cells = <1>;
>         ranges = <0 0xe00000000 0x1000>;
>         i2c@0 {
>                 cell-index = <0>;
>                 regs = <0 0x100>;
>         }
>         i2c@100 {
>                 cell-index = <1>;
>                 regs = <0x100 0x100>;
>         }
> }
> multifunction@1 {
>         #size-cells = <1>;
>         #address-cells = <1>;
>         ranges = <0 0xe10000000 0x1000>;
>         i2c@0 {
>                 cell-index = <0>;
>                 regs = <0 0x100>;
>         }
>         i2c@100 {
>                 cell-index = <1>;
>                 regs = <0x100 0x100>;
>         }
> }

What resources are being shared in this example?  Each I2C device has its own
address ranges.  I don't see how cell-index provides any useful info here.

> cell-index must *not* be repurposed as a system level index.

It's a little late for that.  I'm okay with coming up with a new property to
provide system-level indexing, but it needs to be the same property name for
each type of device.  I don't want linux,i2c-index and linux,dma-index and
linux,ssi-index, etc.  I also don't understand why we need the linux, prefix,
since device enumeration is not specific to Linux.

-- 
Timur Tabi
Linux kernel developer at Freescale
