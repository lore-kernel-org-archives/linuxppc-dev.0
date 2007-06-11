Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 84A3CDDEB9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 01:39:28 +1000 (EST)
Message-ID: <466D6CA7.3020709@am.sony.com>
Date: Mon, 11 Jun 2007 08:39:19 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 09/18] PS3: System-bus rework
References: <c52d99b0071ef223a51612ce7d0cddea@bga.com>
In-Reply-To: <c52d99b0071ef223a51612ce7d0cddea@bga.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
>> --- a/arch/powerpc/platforms/ps3/mm.c
>> +++ b/arch/powerpc/platforms/ps3/mm.c
>> -#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
>> +#define DBG(fmt...) do { if (0) printk(fmt);} while (0)
> 
> While there isn't a style guide for one line defines, while you're 
> adding spaces add one more after the ; before the } where a new line 
> would normally appear.


I don't even like the original.  I planned to replace it with the
following, and will do so now.

static inline int __attribute__ ((format (printf, 1, 2))) DBG(
	const char *fmt, ...) {return 0;}


>> +       BUG_ON(!dev->bus_id);
>> +       mutex_lock(&usage_hack.mutex);
>> +
>> +       if(dev->bus_id == 1 && dev->dev_id == 1) {
>> +               usage_hack.sb_11++;
> 
> If you expect to leave this hack in for a while, how about adding a 
> DEVICE_IS(dev, bus, device) macro?

A good idea!

-Geoff
