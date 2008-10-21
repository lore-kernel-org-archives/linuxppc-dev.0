Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EA78DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 02:33:02 +1100 (EST)
Message-ID: <48FDF611.5080703@freescale.com>
Date: Tue, 21 Oct 2008 10:32:33 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
	<Pine.LNX.4.64.0810192147030.21665@axis700.grange>
	<9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
	<Pine.LNX.4.64.0810192347250.21665@axis700.grange>
	<9e4733910810191505u3ec1db0dl25e87bf3b78c740d@mail.gmail.com>
	<Pine.LNX.4.64.0810200022040.21665@axis700.grange>
	<20081021151648.GA20757@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.64.0810211723520.5867@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0810211723520.5867@axis700.grange>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: =?UTF-8?B?Um9nw6lyaW8gQnJpdG8=?= <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
> static __initdata struct of_device_id storcenter_of_bus[] = {
>         { .name = "soc", },
>         {},
> };

Add .compatible = "simple-bus" to the list.

> static int __init storcenter_device_probe(void)
> {
>         of_platform_bus_probe(NULL, storcenter_of_bus, NULL);
>         return 0;
> }
> machine_device_initcall(storcenter, storcenter_device_probe);
> 
> ? No, linkstation doesn't do that. Somehow, as this API has been 
> introduced, linkstation has been left aside:-(

This is almost as much of a FAQ as interrupt mapping...  I'm wondering 
if we should have stuck with a default list, and added a call to 
of_platform_bus_probe by common code that could be overridden by some 
board flag if really necessary, rather than have a bunch of 
duplication-with-mutation in the platform files.

-Scott
