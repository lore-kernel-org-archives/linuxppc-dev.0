Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D722B2C0088
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2012 07:48:58 +1000 (EST)
Message-ID: <502AC7C3.9030902@freescale.com>
Date: Tue, 14 Aug 2012 16:48:51 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/85xx: add Fman MDIO muxing support to the
 P4080DS
References: <1344637896-14267-1-git-send-email-timur@freescale.com>
 <1344637896-14267-2-git-send-email-timur@freescale.com>
 <5F0028FE-C555-47DE-B69A-888E7322A6E1@kernel.crashing.org>
In-Reply-To: <5F0028FE-C555-47DE-B69A-888E7322A6E1@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Andy Fleming <afleming@freescale.com>, ddaney.cavm@gmail.com,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> > +	{
>> > +		/*
>> > +		 * Warning: this entry might need to be located before those
>> > +		 * for the Fman Ethernet nodes.
>> > +		 */
>> > +		.compatible	= "mdio-mux",
>> > +	},
>> > 	{}
>> > };
> Under what condition would that be the case?

We had this discussion already.  In my tests, I had to locate this entry
before these entries:

	{
		.compatible	= "fsl,dpaa"
	},
	{
		.compatible	= "fsl,srio",
	},

otherwise, the mdio-mux code would not prepare the mdio mus in time, and
there would be initialization failures.  Now maybe this goes away with
-EPROBE_DEFER, or maybe it doesn't.  But until we push the DPAA drivers
upstream, we won't know.

-- 
Timur Tabi
Linux kernel developer at Freescale
