Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 61E50B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 08:01:54 +1000 (EST)
Message-ID: <4F8F39BC.5090800@freescale.com>
Date: Wed, 18 Apr 2012 17:01:32 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/mpc85xx: support the MTD for p1022ds flash
References: <1334654129-1044-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <CAOZdJXVBb-CHa=PPa5446aVdQ323aBdv-9UTXx1SbkY2ArT14Q@mail.gmail.com>
 <110EED8CC96DFC488B7E717A2027A27C079D0B@039-SN1MPN1-002.039d.mgd.msft.net>
 <110EED8CC96DFC488B7E717A2027A27C079DD8@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C079DD8@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Huang Changming-R66093 wrote:
> But, I observed the Call Trace, but the partition can be parsed correctly.
> Maybe your patch can fix this Call Trace.

Can you post the call trace?

I think the reason this patch works is because the localbus node is not
already probed by mpc85xx_common_publish_devices().
mpc85xx_common_publish_devices() has this line in it:

	{ .name = "localbus", },

But this does not work any more, because all of our 85xx localbus nodes
are now called "localbus@ffe05000".

I'm beginning to hate mpc85xx_common_publish_devices() now.  Not only
because it's broken for the P1022DS, but also because it's not
set-in-stone like everyone thought.

-- 
Timur Tabi
Linux kernel developer at Freescale
