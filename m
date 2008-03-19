Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4E78DE15D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 04:40:40 +1100 (EST)
Date: Wed, 19 Mar 2008 12:40:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: James Black <jblack547@gmail.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
Message-ID: <20080319174001.GF7962@ld0162-tx32.am.freescale.net>
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2008 at 11:06:02AM -0600, James Black wrote:
> I turned on early kernel debugging in 2.6.24 and it looks like all the
> device tree parsing is working. The boot hangs and or crashes while
> trying to setup the paging. I drilled down the code from init/main.c
> and found that it seems the muram device node is killing the
> allocator.

That's strange... how in particular was it killing it?  Which allocator?

Do you know which particular line of code is crashing?

> I tried to fully describe the segments in muram node and it seems to
> mess things up even worse.

What do you mean?  What changes did you make, and what was the result?

> / {
> 
> model = "cta5000s";
> compatible = "fsl,cta5000s";
> #address-cells = <1>;
> #size-cells = <1>;
> cpus {

It'd be a lot more readable if indentation were kept intact...

> localbus@f0010100 {
> compatible = "fsl,mpc8250-localbus",
> "fsl,pq2-localbus";
> #address-cells = <2>;
> #size-cells = <1>;
> reg = <f0010100 60>;
> ranges = <0 0 fe000000 00200000>;
> flash@fe000000,0 {
> compatible = "amd", "cfi-flash";

"amd" isn't a valid compatible name.

> cpm@119c0 {
> #address-cells = <1>;
> #size-cells = <1>;
> #interrupt-cells = <2>;
> compatible = "fsl,mpc8250-cpm", "fsl,cpm2";
> reg = <119c0 30>;
> ranges;
> 
> muram@0 {
> #address-cells = <1>;
> #size-cells = <1>;
> ranges = <0 0 10000>;
> 
> data@0 {
> compatible = "fsl,cpm-muram-data";
> reg = <0 4000 8000 4000>;
> };
> 
> };

reg for 8250 should be <0 4000>.  Otherwise, the muram node looks fine
(well, the unit address shouldn't be there, but that won't affect
anything).

> serial@11a40 {
> device_type = "serial";
> compatible = "fsl,mpc8250-scc-uart",
> "fsl,cpm2-scc-uart";
> reg = <11a40 20 8200 100>;
> interrupts = <2a 8>;
> interrupt-parent = <&PIC>;
> fsl,cpm-brg = <5>;
> fsl,cpm-command = <11800000>;

cpm-command should be <08c00000>.

> };
> 
> 
> ethernet@11300 {
> device_type = "network";
> compatible = "fsl,mpc8250-fcc-enet",
> "fsl,cpm2-fcc-enet";
> reg = <11300 20 8400 100>;
> interrupts = <20 8>;
> interrupt-parent = <&PIC>;
> linux,network-index = <0>;
> fsl,cpm-command = <14000300>;

cpm-command should be <12000300>.

-Scott
