Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 72F93B7693
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 15:51:29 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 090E8DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 15:51:27 +1000 (EST)
Message-ID: <4A31E74E.6090505@denx.de>
Date: Fri, 12 Jun 2009 07:27:42 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Heiko Schocher <hs@denx.de>, Kumar Gala <galak@kernel.crashing.org>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4] 83xx: add support for the kmeter1 board.
References: <6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
	<20090427180503.GB10292@ld0162-tx32.am.freescale.net>
	<49F68943.3090800@denx.de>
	<20090428163540.GA2193@ld0162-tx32.am.freescale.net>
	<49F7DC0C.3080409@denx.de>
	<C934E2FC-7597-4D10-AA2F-F28884D1DD1B@kernel.crashing.org>
	<4A30A14D.50907@denx.de>
	<0AFEA008-BBF6-448B-844F-6EBE3DE24F7B@kernel.crashing.org>
	<4A3148A1.3030403@denx.de> <20090612011332.GA9084@yookeroo.seuss>
In-Reply-To: <20090612011332.GA9084@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello David,

David Gibson wrote:
> On Thu, Jun 11, 2009 at 08:10:41PM +0200, Heiko Schocher wrote:
>> The following series implements basic board support for
>> the kmeter1 board from keymile, based on a MPC8360.
> 
> [snip]
>> +		par_io@1400 {
>> +			reg = <0x1400 0x100>;
>> +			device_type = "par_io";
> 
> This should have a compatible value instead of a device_type value.

compatible = "fsl,mpc8360-par_io"; ?

> [snip]
> 
>> +			num-ports = <7>;
>> +
>> +			pio_ucc1: ucc_pin@00 {
> 
> Since these nodes have addresses, they should also have reg
> properties.  And the parent should have #address-cells and
> #size-cells.

added "#address-cells" and "#size-cells", but couldn;t find what
I should write in a "reg" entry ... I think something like that:

reg = <0x00 0x01>;

?

> [snip]
>> +		qe@100000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			device_type = "qe";
> 
> This device_type should not be here.

deleted.

>> +			compatible = "fsl,qe";
>> +			ranges = <0x0 0x100000 0x100000>;
>> +			reg = <0x100000 0x480>;
>> +			clock-frequency = <0>;	/* Filled in by U-Boot */
>> +			brg-frequency = <0>;	/* Filled in by U-Boot */
>> +			bus-frequency = <0>;	/* Filled in by U-Boot */

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
