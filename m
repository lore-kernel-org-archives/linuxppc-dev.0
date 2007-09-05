Return-Path: <dan@embeddedalley.com>
Received: from smtp109.biz.mail.mud.yahoo.com (smtp109.biz.mail.mud.yahoo.com
	[68.142.201.178]) by ozlabs.org (Postfix) with SMTP id 61670DDFC9
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 06:43:19 +1000 (EST)
In-Reply-To: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
References: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4F58F233-56E5-4910-9D33-28A44FCB393C@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 1/9] 8xx: Fix CONFIG_PIN_TLB.
Date: Wed, 5 Sep 2007 13:36:43 -0700
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 5, 2007, at 12:27 PM, Scott Wood wrote:

> 1. Only map 512K of the IMMR, rather than 8M, to avoid conflicting  
> with
> the default ioremap region.

The original reason to map 8M was so ioremap()
could use the same wired TLB rather than allocate
page table entries.  It should also cover all addresses
mapped to the flash as well.  This was intentional,
not a mistake.


	-- Dan
