Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 640912C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 10:41:27 +1000 (EST)
Message-ID: <4FFCCBAD.40504@freescale.com>
Date: Tue, 10 Jul 2012 19:41:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/booke: Eliminate rfi from exception entry path.
References: <20120711003454.GA22757@tyr.buserror.net>
 <1341967010.18850.19.camel@pasglop>
In-Reply-To: <1341967010.18850.19.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2012 07:36 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-07-10 at 19:34 -0500, Scott Wood wrote:
>> Unlike classic, we don't really need the MSR change to be atomic with the
>> branch.  This eliminates a trap as a KVM guest (in the absence of
>> hardware hypervisor extensions), where mtmsr is paravirtualized but rfi
>> is not.  For a virtualized guest without any paravirtualization, this
>> eliminates an additional two traps (SRR0/1).
> 
> In fact, I wonder, what do we write into the MSR at this point that
> wasn't already in it in BookE ? RI ? I wonder if we could get away
> without the mtmsr alltogether...

Doesn't EE get set there for some exceptions?

-Scott
