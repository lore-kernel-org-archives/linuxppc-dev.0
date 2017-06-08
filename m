Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkLLW3Lz4zDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 08:53:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Vineet Gupta <vgupta@synopsys.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
 Johan Hovold <johan@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Krzysztof Kozlowski <krzk@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/16] powerpc: vio_cmo: use dev_groups and not dev_attrs
 for bus_type
In-Reply-To: <20170608133923.GA17811@kroah.com>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
 <20170606192221.1617-12-gregkh@linuxfoundation.org>
 <87y3t2d3o5.fsf@concordia.ellerman.id.au> <20170608133923.GA17811@kroah.com>
Date: Fri, 09 Jun 2017 08:53:22 +1000
Message-ID: <87r2yuhz19.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Jun 08, 2017 at 11:12:10PM +1000, Michael Ellerman wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > The dev_attrs field has long been "depreciated" and is finally being
>> > removed, so move the driver to use the "correct" dev_groups field
>> > instead for struct bus_type.
>> >
>> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > Cc: Paul Mackerras <paulus@samba.org>
>> > Cc: Michael Ellerman <mpe@ellerman.id.au>
>> > Cc: Vineet Gupta <vgupta@synopsys.com>
>> > Cc: Bart Van Assche <bart.vanassche@sandisk.com>
>> > Cc: Robin Murphy <robin.murphy@arm.com>
>> > Cc: Joerg Roedel <jroedel@suse.de>
>> > Cc: Johan Hovold <johan@kernel.org>
>> > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> > Cc: <linuxppc-dev@lists.ozlabs.org>
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> >  arch/powerpc/platforms/pseries/vio.c | 37 +++++++++++++++++++++---------------
>> >  1 file changed, 22 insertions(+), 15 deletions(-)
>> 
>> This one needed a bit more work to get building, the incremental diff is
>> below. We need a forward declaration of name, devspec and modalias,
>> which is a bit weird, but that's how the code is currently structured.
>> And there's dev and bus attributes with the same name, so that needed an
>> added "bus".
>> 
>> I booted v2 of patch 10 and this one and everything looks identical to
>> upstream.
>
> Ah, many thanks, this was on my todo list to fix up today.
>
> But you renamed the sysfs files when you added "bus" to the function
> names, are you sure you want to do that?  I don't mind, but if you
> happen to have userspace tools that look at those files, they just broke
> :(

Ugh crap, no that won't work.

I didn't see it when I tested because my machine doesn't have the CMO
feature enabled.

I guess we have to open code some of the BUS_ATTR_RO() etc. so we can
avoid the name clash.

I'll try and get it fixed later today.

cheers
