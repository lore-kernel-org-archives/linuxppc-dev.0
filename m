Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C39DFDDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 08:29:29 +1000 (EST)
Subject: Re: device trees.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
In-Reply-To: <4A089AC8.9080704@dlasys.net>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
	<4A089AC8.9080704@dlasys.net>
Content-Type: text/plain
Date: Tue, 12 May 2009 08:29:22 +1000
Message-Id: <1242080962.304.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-05-11 at 17:38 -0400, David H. Lynch Jr. wrote:
> Not only is the device tree expected to pass static hardware
> configuration information, but it is the sole means of passing
> anything.
> As an example Command lines are to be in the device tree.
> Everything is supposed to be in the device tree, whether that
> information is static or dynamic, whether it is hardware information,
> or user choices.
> 
>     That means that whether you are in a Sun or Apple Desktop or a
> system with the no flash and barely enough resources to run Linux,
> you still may have to manipulate the device tree.

To some extend, but the user choice information is well isolated, it's
all in /chosen, so it's really only that node that needs to be modified
or created from scratch by the bootloader.

Thus, your bootloader can pick the right static dtb for a given bitfile,
and then just use libfdt to generate the right /chosen node with other
informations.

Ben.
