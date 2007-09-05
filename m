Return-Path: <dan@embeddedalley.com>
Received: from smtp110.biz.mail.mud.yahoo.com (smtp110.biz.mail.mud.yahoo.com
	[68.142.201.179]) by ozlabs.org (Postfix) with SMTP id 15E11DE053
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 08:27:28 +1000 (EST)
In-Reply-To: <20070905205951.GA1047@ld0162-tx32.am.freescale.net>
References: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
	<4F58F233-56E5-4910-9D33-28A44FCB393C@embeddedalley.com>
	<20070905205301.GA807@ld0162-tx32.am.freescale.net>
	<20070905205951.GA1047@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <63F66EED-7808-40A3-B63D-AA53664CB1A0@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 1/9] 8xx: Fix CONFIG_PIN_TLB.
Date: Wed, 5 Sep 2007 15:27:31 -0700
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


On Sep 5, 2007, at 1:59 PM, Scott Wood wrote:

> BTW, it seems I misremembered what the conflict was -- it's not with
> ioremap space, but with the default location of the consistent memory
> pool (at 0xff100000).

Change the configuration option to move this somewhere
else, outside of the wired mapping.

As I said in the last message, these lower end processors
are very resource challenged, and we need to clever
about the memory mapping and use of the TLBs.  This
isn't a place to be creating fancy memory maps and
algorithms to manage them.  Use maximum mappings
whenever possible, configure the memory controller
to pack as much stuff into this single TLB mapping
as possible.  Something configurable like this memory
pool should not be a reason to give up these performance
enhancements.

Thanks.

	-- Dan
