Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id AD6DEDE1CE
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 06:06:59 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so339513yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 13:06:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090520.122453.169463011.davem@davemloft.net>
References: <1242788490.16901.133.camel@pasglop>
	<20090519.225118.58497608.davem@davemloft.net>
	<1242802267.16901.187.camel@pasglop>
	<20090520.122453.169463011.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 20 May 2009 14:06:38 -0600
Message-ID: <fa686aa40905201306j4ef96cafl8ac02736dbdf7e5@mail.gmail.com>
Subject: Re: Musings on PCI busses
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: thunderbird2k@gmail.com, John.Linn@xilinx.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 20, 2009 at 1:24 PM, David Miller <davem@davemloft.net> wrote:
>> What do you mean by fully resolve ? IE. The issue above is specific to
>> IO space, which you can resolve both as MMIO, or as "IO" which in linux
>> means going through the special mapping for IO which allows the use of
>> the inX/outX instructions...
>
> I mean that all OF devices have fully resolved MMIO resources. =A0So
> very early serial devices that sit in I/O space on sparc64 end
> up being OF device drivers. =A0See for example, drivers/net/sunsu.c
> which is simply a 8250 chip that sits behind Sun's I/O space bus
> that sits on PCI and provides things normally found via ISA on
> x86 machines. =A0Another example is drivers/serial/sunsab.c

Unfortunately in the embedded powerpc case we don't actually have real
OF.  We've only got the flattened device tree which usually doesn't
itemize the devices behind the PCI bus.  Instead we rely on the kernel
probing for them.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
