Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8494DB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 04:24:14 +1100 (EST)
Received: from mail6-ch1 (localhost.localdomain [127.0.0.1])	by
	mail6-ch1-R.bigfish.com (Postfix) with ESMTP id 2A8031B7813E	for
	<linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2011 17:24:08 +0000 (UTC)
Message-ID: <4E89EFB2.6060704@freescale.com>
Date: Mon, 3 Oct 2011 12:24:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <smitha.vanga@wipro.com>
Subject: Re: Request_irq fails for IRQ2
References: <40631E9A2581F14BA60888C87A76A1FE0145F8@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE0145F8@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/2011 09:27 AM, smitha.vanga@wipro.com wrote:
> I just don't know what I should pass for host , also when I pass NULL
> for host . I see the default host is NULL..
> Could you please help me. My project delivery is near , I need  help soon.

Ideally you should just use the device tree to describe this device,
then you wouldn't have to deal with finding the pointer to the controller.

Otherwise, modify the cpm2_pic driver to either call
irq_set_default_host() (in which case NULL should work) or to make
cpm2_pic_host non-static (in which case you should pass that).

-Scott
