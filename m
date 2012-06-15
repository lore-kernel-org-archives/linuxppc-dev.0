Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64076B7073
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 02:50:47 +1000 (EST)
Message-ID: <4FDB67BE.9040000@freescale.com>
Date: Fri, 15 Jun 2012 11:50:06 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
References: <20120614234101.GB17147@tyr.buserror.net>
 <1339722302.9220.175.camel@pasglop>
In-Reply-To: <1339722302.9220.175.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2012 08:05 PM, Benjamin Herrenschmidt wrote:
>>  - It has threads, but no "tlbsrx." -- so we need a spinlock and
>>    a normal "tlbsx".  Because we need this lock, hardware tablewalk
>>    is mandatory on e6500 unless we want to add spinlock+tlbsx to
>>    the normal bolted TLB miss handler.
> 
> Isn't this a violation of the architecture ? (Isn't tlbsrx. mandatory ?
> in 2.06 MAV2 ?).

I don't think so -- not only does it have a category name, there's a
MAV2-specific bit in MMUCSR indicating whether the category is present.

I still don't understand why Freescale omitted it from a chip that has
threads, though.

-Scott
