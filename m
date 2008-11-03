Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from SG2EHSOBE002.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 75246DDDE0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 06:03:22 +1100 (EST)
Message-ID: <490F4AF1.4060902@am.sony.com>
Date: Mon, 3 Nov 2008 11:03:13 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] ps3: ps3-lpm.c compile fix
References: <20081102172650.GA7219@x200.localdomain>	<Pine.LNX.4.64.0811030920170.11062@vixen.sonytel.be>
	<20081103134829.GA3432@x200.localdomain>
In-Reply-To: <20081103134829.GA3432@x200.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexey Dobriyan wrote:
> On Mon, Nov 03, 2008 at 09:20:28AM +0100, Geert Uytterhoeven wrote:
>> On Sun, 2 Nov 2008, Alexey Dobriyan wrote:
>> > drivers/ps3/ps3-lpm.c:838: error: implicit declaration of function 'get_hard_smp_processor_id'
>> > 
>> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>


Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>


>> > --- a/drivers/ps3/ps3-lpm.c
>> > +++ b/drivers/ps3/ps3-lpm.c
>> > @@ -22,6 +22,7 @@
>> >  #include <linux/module.h>
>> >  #include <linux/interrupt.h>
>> >  #include <linux/uaccess.h>
>> > +#include <asm/smp.h>
>> 
>> #include <linux/smp.h>?
> 
> Nope, everybody else uses asm/smp.h.

That doesn't quite seem like enough reason for me.

Looking at the source, I see linux/smp.h only includes
asm/smp.h when CONFIG_SMP=y, so we at least need to
include asm/smp.h to get the get_hard_smp_processor_id
def when CONFIG_SMP=n.

-Geoff
