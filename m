Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 2504D67BD7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 17:08:36 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GYH9m-0002YN-Vk
	for linuxppc-embedded@ozlabs.org; Fri, 13 Oct 2006 09:08:35 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
Date: Fri, 13 Oct 2006 09:08:34 +0200
In-Reply-To: <609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	(David Bolcsfoldi's message of "Thu, 12 Oct 2006 14:12:24 -0700")
Message-ID: <87ejtcvgjx.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David Bolcsfoldi <dbolcsfoldi@gmail.com> writes:

Hi,

David> No I did not know that unfortunately, it could have saved me
David> some work.  You are of course right and I'd much prefer to make
David> changes to your driver instead of writing another one.

It unfortunately happens all the time - Googling a bit around before
writing code often pays off ;)

David> I've noticed that in the probe function it tries to get some
David> resources from the platform_device structure but it looks like
David> that this operation will always fail unless I add a 'uartlite'
David> platform device or have I completely misunderstood how platform
David> devices work?

Yes, you need a platform device with the info, E.G. something like:


#include <linux/platform_device.h>

static struct resource myuartlite_resources[] = {
       [0] = {
                 .start  = 0xa1000003,
                 .end    = 0xa1000012,
                 .flags  = IORESOURCE_MEM,
              },
       [1] = {
                 .start  = 2,
                 .end    = 2,
                 .flags  = IORESOURCE_IRQ,
       },
};

static struct platform_device my_uartlite = {
       .name                    = "uartlite",
       .id                      = 0,
       .num_resources           = ARRAY_SIZE(myuartlite_resources),
       .resource                = myuartlite_resources,
       .dev.platform_data       = 0,
};

Which you then add to the platform bus (platform_add_devices).

David> But yes, I will try to add support for the things I need to
David> this driver instead, most importantly early console support and
David> move the #defines for register offsets and such into a separate
David> header file per Grants comment.

Great!

-- 
Bye, Peter Korsgaard
