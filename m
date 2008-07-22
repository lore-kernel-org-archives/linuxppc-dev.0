Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2BA21DE243
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 00:56:05 +1000 (EST)
Message-ID: <4885F500.4020908@freescale.com>
Date: Tue, 22 Jul 2008 09:56:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: Mikrotik RouterBoard 333
References: <20080708042631.GB7328@yookeroo.seuss>
	<20080709040925.GA13810@secretlab.ca> <487AA17E.6000808@gmail.com>
	<20080721211344.GA13268@loki.buserror.net>
	<48854C02.7000307@gmail.com>
In-Reply-To: <48854C02.7000307@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:
> Scott Wood wrote:
>> On Sun, Jul 13, 2008 at 08:44:46PM -0400, Jerry Van Baren wrote:
>>> I'm a half-ack.  ;-)  I'm partial to u-boot's implementation rather 
>>> than  using a bootwrapper for obvious reasons.  The u-boot 
>>> implementation  takes the blob as a boot parameter and passes it 
>>> along to the kernel  after doing appropriate (optional) fixups.
>>
>> And if those fixups expect a malformed device tree?
> 
> Oops, very bad choice of terms on my part.  :-(  The fixups I referred 
> to are mostly "fill in the blank" things like setting the various 
> clocks, MAC information, PCI information, etc. to the correct values 
> based on hardware probing or a priori knowledge.  U-boot does not 
> (should not / will not!) fix broken device trees.  A broken tree w/ the 
> u-boot methodology is fixed by loading a corrected one, not requiring a 
> full rebuild and reload of the firmware.

No, I understand what you meant -- I mean cases where u-boot expects the 
"blanks" to be somewhere other than where they are.  This has happened 
in the past, with mac-address v. local-mac-address, finding the SOC 
node, duplicate /chosen nodes, etc.

> If all else fails, u-boot is GPLed and the user is able to get the 
> source and fix it (well, at least for 3 years after purchasing the 
> hardware).

Regardless of that, if all else fails, one can ignore the firmware's 
tree and use a bootwrapper-provided tree.

> There are advantages and disadvantages to u-boot and boot-wrapper 
> methods.  There are nothing but disadvantages to having the blob 
> physically a part of the firmware (with a double whammy if the firmware 
> source is not readily available).

The advantage is that the firmware will be kept in sync with the tree 
it's trying to patch.

-Scott
