Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195]) by ozlabs.org (Postfix) with ESMTP id 0DC5BB7CF1
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Mar 2010 10:47:27 +1100 (EST)
Received: by ywh33 with SMTP id 33so3184377ywh.11
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Mar 2010 15:47:26 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100305123527.d6d68e56.akpm@linux-foundation.org>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203236.GC1475@oksana.dev.rtsoft.ru>
	<fa686aa41002090913t4c72a3b8o5fda68723bc8d089@mail.gmail.com>
	<20100209191620.GA24539@oksana.dev.rtsoft.ru>
	<20100305120015.a2008f46.akpm@linux-foundation.org>
	<fa686aa41003051228w38579483yd4e95bb8eacf40f7@mail.gmail.com>
	<20100305123527.d6d68e56.akpm@linux-foundation.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 5 Mar 2010 16:47:06 -0700
Message-ID: <fa686aa41003051547u1f499902w1d3efc614a9b20b6@mail.gmail.com>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
To: Andrew Morton <akpm@linux-foundation.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 5, 2010 at 1:35 PM, Andrew Morton <akpm@linux-foundation.org> w=
rote:
> On Fri, 5 Mar 2010 13:28:32 -0700
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> On Fri, Mar 5, 2010 at 1:00 PM, Andrew Morton <akpm@linux-foundation.org=
> wrote:
>> > On Tue, 9 Feb 2010 22:16:20 +0300
>> > Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
>> >
>> >> On Tue, Feb 09, 2010 at 10:13:11AM -0700, Grant Likely wrote:
>> >> [...]
>> >> > > +static int __init of_gpio_notifier_init(void)
>> >> > > +{
>> >> > > + __ __ __ return blocking_notifier_chain_register(&gpio_notifier=
, &of_gpio_nb);
>> >> > > +}
>> >> > > +arch_initcall(of_gpio_notifier_init);
>> >> >
>> >> > Another concern; __if any gpio chips get registered before this
>> >> > arch_initcall (not sure if it is possible or not), then those chips
>> >> > won't get registered with the of gpio infrastructure.
>> >>
>> >> Technically, it is possible, but registering usual GPIO controllers
>> >> in arch_initcall feels not quite right approach in the first place
>> >> (and, btw, it won't work most of the time, because even early drivers
>> >> do not register itself earlier than subsys_initcall).
>> >>
>> >> And arch gpio controllers (like QE GPIO) are usually device-less,
>> >> and they use of_mm_gpiochip_add(), so we fully control them.
>> >>
>> >> Plus I don't see any reason why we couldn't move
>> >> of_gpio_notifier_init() into, say, postcore_initcall, if we ever
>> >> need it.
>> >>
>> >
>> > I'll assume that you're OK with that response.
>>
>> No, not really,
>
> You left me dangling :(

Sorry, got caught up with other things.

>> I'm not really very comfortable with the whole
>> approach being taken. =A0And, while I acked the first patch in the
>> series, that patch isn't needed by anything except patches 2, 3 & 4.
>>
>> Also, the OF stuff is a moving target at the moment with all the
>> rework is being undertaken. =A0I'd rather let this series sit out for
>> another merge cycle so that the underlying OF stuff can settle down.
>
> OK, please take it up on-list?

Okay.  I'm making this reply on list.

Anton, as I've stated before, I'm not thrilled with the approach.
Combine that with the changes being made to drivers/of right now and
the addition device tree to ARM and other architectures, my preference
is to let this patch series lie fallow for one more merge cycle so
that things can settle out in the OF infrastructure code.

g.
