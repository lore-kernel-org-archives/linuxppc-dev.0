Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4591D1007D4
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2011 04:23:46 +1100 (EST)
Message-ID: <4EEA2A61.8050302@freescale.com>
Date: Thu, 15 Dec 2011 11:12:01 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] phylib: update mdiobus_alloc() to allocate extra private
 space
References: <1323967895-5205-1-git-send-email-timur@freescale.com>
 <8ABCAC4C-1D11-41AD-AE46-96EB9D40588D@freescale.com>
In-Reply-To: <8ABCAC4C-1D11-41AD-AE46-96EB9D40588D@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: netdev@vger.kernel.org, davem@davemloft.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andy Fleming wrote:
> Why? Doesn't this just obfuscate things a little, while providing no immediate benefit?

I see code like this frequently:

	bus = mdiobus_alloc();
	if (bus == NULL)
		return -ENOMEM;
	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
	if (priv == NULL) {
		err = -ENOMEM;
		goto out_free;
	}
	bus->priv = priv;

This can be replaced with:

	bus = mdiobus_alloc(sizeof(*priv));
	if (bus == NULL)
		return -ENOMEM;

So the benefit is in simplifying memory management.  Now you have only one allocation to manage, instead of two.

fbdev does the same thing, which is where I got the idea from.  See framebuffer_alloc().

-- 
Timur Tabi
Linux kernel developer at Freescale
