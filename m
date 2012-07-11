Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CFBD2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 10:47:53 +1000 (EST)
Message-ID: <4FFCCD2D.20407@freescale.com>
Date: Tue, 10 Jul 2012 19:47:41 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc/booke: Eliminate rfi from exception entry path.
References: <20120711003454.GA22757@tyr.buserror.net>
 <E139BF8E-A72C-4977-8FB9-6EED5803AB9A@suse.de>
In-Reply-To: <E139BF8E-A72C-4977-8FB9-6EED5803AB9A@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2012 07:44 PM, Alexander Graf wrote:
> 
> On 11.07.2012, at 02:34, Scott Wood wrote:
>> +#ifdef CONFIG_BOOKE
>> +	/*
>> +	 * We're not changing address space on Book E, and the extra rfi
>> +	 * can hurt when virtualized without hardware support -- whereas
>> +	 * mtmsr can be paravirtualized.
> 
> We can always paravirtualize RFI as well if it makes sense.

I'm not sure that's possible.  We thought about it a while back, but
IIRC the difficulty was not leaving a register clobbered.

-Scott
