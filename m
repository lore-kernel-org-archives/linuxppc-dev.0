Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C67D367CB8
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 19:41:30 +1100 (EST)
In-Reply-To: <20061206212051.756e0634@localhost.localdomain>
References: <11654526463043-git-send-email-ntl@pobox.com>
	<20061206212051.756e0634@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4433B63C-144F-46B6-A124-4D08F9878F9C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] maple: match "pcie" name for CPC945
Date: Thu, 7 Dec 2006 09:41:17 +0100
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Some firmwares have "pcie" for the "name" property of the CPC945 PCI
>> Express host bridge.  Check for "pcie" in addition to "pci" so we
>> don't miss it.
>
> 1275 (draft) supplement for PCI Express use 'pciex'. 'Some firmware'
> should be changed instead, if possible.

Nah, the draft should be changed, "pciex" is an absolutely
horrible name :-)  The draft contains a few serious bugs
btw, I hope no one implements this as-is :-)

> See http://playground.sun.com/1275/bindings/pci/pci-express.txt
>
> That's also what pseries and rtas_pci uses.

Apple uses plain "pci".  Using the "device_type" and the
"compatible" property works fine everywhere -- *except*
for implementations following this broken draft spec (the
draft doesn't even define a value for "device_type"; also
it prohibits declaring in the "compatible" property that
a device is backward compatible to some plain old PCI
device).


Segher
