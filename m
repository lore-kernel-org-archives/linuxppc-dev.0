Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 0714EDE1A7
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 08:28:40 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so376868ywt.39
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 15:28:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1242856782.16901.203.camel@pasglop>
References: <1242788490.16901.133.camel@pasglop>
	<20090519.225118.58497608.davem@davemloft.net>
	<1242802267.16901.187.camel@pasglop>
	<20090520.122453.169463011.davem@davemloft.net>
	<fa686aa40905201306j4ef96cafl8ac02736dbdf7e5@mail.gmail.com>
	<1242856782.16901.203.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 20 May 2009 16:28:18 -0600
Message-ID: <fa686aa40905201528u65fc611fr64e9ebd296278835@mail.gmail.com>
Subject: Re: Musings on PCI busses
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com,
	David Miller <davem@davemloft.net>, John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 20, 2009 at 3:59 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2009-05-20 at 14:06 -0600, Grant Likely wrote:
>> On Wed, May 20, 2009 at 1:24 PM, David Miller <davem@davemloft.net> wrot=
e:
>> >> What do you mean by fully resolve ? IE. The issue above is specific t=
o
>> >> IO space, which you can resolve both as MMIO, or as "IO" which in lin=
ux
>> >> means going through the special mapping for IO which allows the use o=
f
>> >> the inX/outX instructions...
>> >
>> > I mean that all OF devices have fully resolved MMIO resources. =A0So
>> > very early serial devices that sit in I/O space on sparc64 end
>> > up being OF device drivers. =A0See for example, drivers/net/sunsu.c
>> > which is simply a 8250 chip that sits behind Sun's I/O space bus
>> > that sits on PCI and provides things normally found via ISA on
>> > x86 machines. =A0Another example is drivers/serial/sunsab.c
>>
>> Unfortunately in the embedded powerpc case we don't actually have real
>> OF. =A0We've only got the flattened device tree which usually doesn't
>> itemize the devices behind the PCI bus. =A0Instead we rely on the kernel
>> probing for them.
>
> We -can- itemize the PCI bus, it's up to you.

Yes, we could.  But I don't think it makes any sense to for the FDT
case.  The firmware infrastructure is not in place to fill out the
device tree with the PCI bus layout for the off board devices.

>
> That leads to another interesting discussion...
>
> On ppc64, we have code that can "create" the pci_bus & pci_dev hierarchy
> from the OF tree (avoiding the config space probing entirely). This is
> very efficient and has some advantages such as avoiding touching the
> BARs for sizing (which mean avoiding to temporarily disable access to
> devices behind them, which can be useful when it's your serial port or
> system controller there) etc...
>
> It also have the advantage of avoiding a double PCI probe pass when the
> FW already did it and since most FW do ...
>
> I'm tempted to extract that code and stick it in a
> drivers/pci/probe_of.c or something like that for more generic usage. We
> also have a per-bus hook that allows to switch to "real" config space
> probing at any point of the hierarchy (for example, you can setup things
> so that only on-board devices are in OF and probed that away and
> anything on your slot gets probed by linux using config space, that sort
> of thing).

That would be interesting.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
