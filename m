Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id ED076B7BFA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Mar 2010 07:20:54 +1100 (EST)
Received: by gyd10 with SMTP id 10so5921561gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Mar 2010 13:20:51 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201003292304.39657.temerkhanov@yandex.ru>
References: <201003172118.41559.temerkhanov@cifronik.ru>
	<1269877373.6173.27.camel@iscandar.digidescorp.com>
	<fa686aa41003290856t24a248a5j5dfda623ed2805c0@mail.gmail.com>
	<201003292304.39657.temerkhanov@yandex.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 29 Mar 2010 14:20:31 -0600
Message-ID: <fa686aa41003291320o76b88ca3vd98bdef5ff592277@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Xilinx MPMC SDMA subsystem
To: Sergey Temerkhanov <temerkhanov@yandex.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: microblaze-uclinux@itee.uq.edu.au,
	Sergey Temerkhanov <temerkhanov@cifronik.ru>,
	linuxppc-dev@lists.ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	steve@digidescorp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 29, 2010 at 1:04 PM, Sergey Temerkhanov
<temerkhanov@yandex.ru> wrote:
> On Monday 29 March 2010 19:56:15 Grant Likely wrote:
>> On Mon, Mar 29, 2010 at 9:42 AM, Steven J. Magnani
>>
>> <steve@digidescorp.com> wrote:
>> > On Fri, 2010-03-26 at 17:53 -0600, Grant Likely wrote:
>> >> I've not got time to review this patch right now, but Sergey and
>> >> Steven, you both posted MPMC drivers on the same day; Steven on the
>> >> microblaze list and Sergey on the powerpc list. =9ACan you two please
>> >> coordinate and figure out how to mork toward a single driver that wil=
l
>> >> meet both your needs? =9AI don't want to have 2 drivers (3 if you cou=
nt
>> >> the ll_temac driver) in mainline for the same hardware interface.
>> >
>> > I don't think we'll end up with a single driver. A MPMC DMA Engine
>> > driver is useful only on "loopback" SDMA ports. Sergey's code looks li=
ke
>> > a nice generic interface to Xilinx SDMA HW that could be used by the
>> > xlldma and ll_temac drivers, for instance. Both of those will get
>> > smaller, but won't go away.
>
> Yes, it's like having IBM EMAC driver and MAL layer or something
>
>> >
>> > For this to be useful to me, it would need to be located somewhere mor=
e
>> > accessible than arch/powerpc and it would need to have initialization
>> > methods that don't depend on OF. In my build I would have platform cod=
e
>> > that binds to the xlldma platform attachment, which would call Sergey'=
s
>> > SDMA code to assign it the proper resources.
>>
>> That should be fine.
>
> Well, I'll look at my old code for the platform interface bindings. I rem=
ember
> it worked well on arch/ppc with my other drivers.

Don't get too caught up in this aspect.  of_platform_bus_type is being
merged with platform_bus_type.  One driver can be written to handle
both use cases.  However, it may not make any sense for the DMA
library layer to have a bus binding since it is mostly a set of shared
routines.  I'm fine if the bindings are only at the SDMA driver and
ll_temac driver level.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
