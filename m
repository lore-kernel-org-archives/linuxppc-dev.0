Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 0F240DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 09:14:25 +1100 (EST)
Message-ID: <493EEDB4.8070003@harris.com>
Date: Tue, 09 Dec 2008 17:14:12 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
References: <1227628088-10849-1-git-send-email-sr@denx.de>
	<493EE79C.9000405@harris.com>
In-Reply-To: <493EE79C.9000405@harris.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven A. Falco wrote:
> Stefan Roese wrote:
>> This adds a SPI driver for the SPI controller found in the IBM/AMCC
>> 4xx PowerPC's.
>>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
>> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> ---
>
> How is this intended to work?  An example .dts would be greatly
> appreciated.

Answered my own question.  The gpios must be directly under the spi
node rather than elsewhere in the tree.  This works:

			SPI0: spi@ef600900 {
				compatible = "ibm,ppc4xx-spi";
				reg = <ef600900 7>;
				interrupts = <8 4>;
				interrupt-parent = <&UIC0>;

				gpios = <&GPIO1 14 0>;
			};
