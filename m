Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0556CDEE4D
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:50:41 +1000 (EST)
Message-ID: <48480B3C.9080101@freescale.com>
Date: Thu, 05 Jun 2008 10:50:20 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	<20080604220555.658ab13e@vader.jdub.homelinux.org>	<20080604231641.786bb2dd@lappy.seanm.ca>	<200806050822.00797.sr@denx.de>
	<4848036D.5060004@freescale.com> <484809D1.2070300@scram.de>
In-Reply-To: <484809D1.2070300@scram.de>
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

Jochen Friedrich wrote:
> Hi Timur,
> 
>> In situations where it doesn't matter which I2C bus is #1 and which one is #2,
>> then I think the code should just initialize idx based on the order the nodes
>> are found in the tree.
>>
>> In situations where it does matter, then we should use cell-index.
> 
> that's what I did in i2c-cpm, as well. However, here I use the property
> "linux,i2c-index" instead (see http://patchwork.ozlabs.org/linuxppc/patch?id=18603).

Well, I just don't see the point of having two different properties that say the
same thing.  I'm not an IEE 1275 purist, so I don't think we should be hampered
by old node definitions.  I especially don't like having a property specifically
for indexing I2C nodes that can't be used to enumerate other nodes.

The DMA and SSI controllers on Freescale parts use cell-index to enumerate them.
 It just seems dumb to invent a new property.

Will there ever be a situation where a node will contain "cell-index" and
"linux,i2c-index"?

-- 
Timur Tabi
Linux kernel developer at Freescale
