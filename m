Return-Path: <dan@embeddedalley.com>
Received: from smtp109.biz.mail.mud.yahoo.com (smtp109.biz.mail.mud.yahoo.com
	[68.142.201.178]) by ozlabs.org (Postfix) with SMTP id 8B3DADE019
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 08:42:00 +1000 (EST)
In-Reply-To: <20070905222310.GA11433@ld0162-tx32.am.freescale.net>
References: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
	<4F58F233-56E5-4910-9D33-28A44FCB393C@embeddedalley.com>
	<20070905205301.GA807@ld0162-tx32.am.freescale.net>
	<CF1B6B97-44FA-4002-9030-3C1A20F2F2F4@embeddedalley.com>
	<20070905222310.GA11433@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <04819433-30F0-4789-864D-57B474485E32@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 1/9] 8xx: Fix CONFIG_PIN_TLB.
Date: Wed, 5 Sep 2007 15:42:03 -0700
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


On Sep 5, 2007, at 3:23 PM, Scott Wood wrote:

> The IMMRs I've seen from the bootloader are ff000000 (Freescale  
> boards)
> and fa200000 (Embedded Planet).  AFAICT, the number of fixed TLB  
> entries
> is fixed at 4 on these chips, so using the fourth for flash  
> wouldn't take
> away any general-purpose TLB entries.

On these same boards, the memory controllers are usually
configured to put the flash somewhere in that space as well.
This is useful for flash file system performance.  If you don't
need that, you can allocate the space differently.  The point is
cover as much as you can with the IMMR entry and beyond.
Some people like to map external devices out there.

The 8xx variants have different TLB configurations.
You can't assume anything here.  Some parts don't have
enough TLBs to make pinning useful, some allow hardware
wiring of only 2.  When using hardware wiring, it's always
the upper entries that are wired.  Since the number of
entries varies, you can't assume which TLB index
will be wired.

> I certainly agree that it would be nice to check -- my immediate  
> goal is
> to get things working, though.

It's more than nice.  If you want this to work correctly
and also get the performance enhancement, it needs
to be done.

Thanks.

	-- Dan
