Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4ECC2DDF49
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:03:10 +1000 (EST)
Message-ID: <469F7D1C.9040803@freescale.com>
Date: Thu, 19 Jul 2007 10:02:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 37/61] cpm2: Rework 8272ads initialization, and eliminate
	init_fcc_ioports().
References: <20070718013548.GI15238@ld0162-tx32.am.freescale.net>
	<200707190204.44825.arnd@arndb.de>
In-Reply-To: <200707190204.44825.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 18 July 2007, Scott Wood wrote:
> 
>>+static struct cpm_pin mpc8272ads_pins[] = {
>>+       /* SCC1 */
>>+       {3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
>>+       {3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
>>+
>>+       /* SCC4 */
>>+       {3, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
>>+       {3, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
>>+
>>+       /* FCC1 */
>>+       {0, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
>>+       {0, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
>>+       {0, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
>>+       {0, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
> 
> 
> I guess you considered moving such tables into the device tree at some point,
> which doesn't seem that difficult at all to an ignorant reviewer like me.
> 
> What's the reasoning for putting it into the platform code after all?

Ideally, this would be done by u-boot, and neither the kernel nor the 
device tree would need to care.  However, u-boot's setting up of the 
pins was lacking on all of the boards I tested on, so I had to fix it up 
in the platform code.

I considered putting it in the device tree as the qe code does; if there 
are many boards like these that need the kernel to set up the pins, it 
may be worthwhile.  We just need to come up with a good binding (e.g. no 
using arbitrary enums defined in the kernel).

-Scott
