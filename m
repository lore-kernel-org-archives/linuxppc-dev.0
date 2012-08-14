Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 34EC92C0088
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2012 07:53:31 +1000 (EST)
Message-ID: <502AC8D3.4010602@freescale.com>
Date: Tue, 14 Aug 2012 16:53:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: add Fman MDIO muxing support to the
 P4080DS
References: <1344637896-14267-1-git-send-email-timur@freescale.com>
 <1344637896-14267-2-git-send-email-timur@freescale.com>
 <5F0028FE-C555-47DE-B69A-888E7322A6E1@kernel.crashing.org>
 <502AC7C3.9030902@freescale.com>
In-Reply-To: <502AC7C3.9030902@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <afleming@freescale.com>,
 ddaney.cavm@gmail.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/14/2012 04:48 PM, Timur Tabi wrote:
> Kumar Gala wrote:
>>>> +	{
>>>> +		/*
>>>> +		 * Warning: this entry might need to be located before those
>>>> +		 * for the Fman Ethernet nodes.
>>>> +		 */
>>>> +		.compatible	= "mdio-mux",
>>>> +	},
>>>> 	{}
>>>> };
>> Under what condition would that be the case?
> 
> We had this discussion already.

I think that was internally, and not on this specific comment wording.
I don't think that code comment adequately explains things.

> otherwise, the mdio-mux code would not prepare the mdio mus in time, and
> there would be initialization failures.  Now maybe this goes away with
> -EPROBE_DEFER, or maybe it doesn't.  But until we push the DPAA drivers
> upstream, we won't know.

Do you know if it's theoretically supposed to be fixed and just can't
test it, or are you unsure of whether it's even supposed to work?

I don't think we should be relying on the order of this list to
determine probe order.  For one thing, it won't work if the drivers
register after you create the platform devices (e.g. they're modules).

-Scott
