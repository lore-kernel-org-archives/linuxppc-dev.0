Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 47003DDF8A
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 05:14:34 +1100 (EST)
Message-ID: <47B5D698.2050602@freescale.com>
Date: Fri, 15 Feb 2008 12:14:48 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: NOR flash partitions gone
References: <47B5E3CA.5050208@pikatech.com>
In-Reply-To: <47B5E3CA.5050208@pikatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> I did a git pull of Josh's for-2.6.25 tree. Now the NOR partitions are 
> no longer setup.
> 
> 				nor_flash@0,0 {
> 					compatible = "amd,s29gl032a", "cfi-flash";
> 					bank-width = <2>;
> 					reg = <0 0 400000>;
> 					#address-cells = <1>;
> 					#size-cells = <1>;
> 					partition@300000 {
> 						label = "fpga";
> 						reg = <300000 40000>;
> 					};
> 					partition@340000 {
> 						label = "env";
> 						reg = <340000 40000>;
> 					};
> 					partition@380000 {
> 						label = "u-boot";
> 						reg = <380000 80000>;
> 					};
> 				};
> 
> 
> 
> It still detects the chip, it just doesn't configure the partitions. Any 
> ideas?

Try turning off command line partition support -- there's a bug in it 
that was exposed by changes to the OF physmap code (in particular, it 
returns -EINVAL rather than zero when no command line partitions are 
present).

-Scott
