Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 62E25DDF55
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 03:28:33 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: <200903241639.56637.sr@denx.de>
References: <200903231151.10373.sr@denx.de> <200903241007.51321.sr@denx.de>
	<fa686aa40903240757n569f2b04t1309e817fd30728d@mail.gmail.com>
	<200903241639.56637.sr@denx.de>
Date: Tue, 24 Mar 2009 10:28:31 -0600
Message-ID: <fa686aa40903240928t2a3fcccdrb4508e34c7079aef@mail.gmail.com>
Subject: Re: physmap_of and partitions (mtd concat support)
From: Grant Likely <grant.likely@secretlab.ca>
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2009 at 9:39 AM, Stefan Roese <sr@denx.de> wrote:
> On Tuesday 24 March 2009, Grant Likely wrote:
>> >> Sounds to me like a physmap_of driver bug. =A0I don't think there is =
any
>> >> advantage in changing the partition syntax since concatenated flash
>> >> will always be used as a single device. =A0It doesn't make any sense =
to
>> >> try and span partitions over two nodes.
>> >
>> > Yes, I would really love to make this possible with only one flash nod=
e.
>> > But just think about the following system configuration:
>> >
>> > One Intel Strataflash (compatible =3D "cfi-flash") and one non-cfi
>> > compatible flash (e.g. compatible =3D "jedec-flash"). And the user wan=
ts to
>> > define a partition that spans over both flash chips. How could this be
>> > described in one flash node?
>> >
>> >> Do additional properties need to be added to describe the concat layo=
ut?
>> >
>> > Not sure. If we have multiple identical devices they can currently be
>> > described in one flash node. So with some changes to the physmap_of
>> > driver this configuration will work with concat as well. But more comp=
lex
>> > is a system configuration as described above. Meaning two or more
>> > non-identical chips. I don't see how this could be described in a sane
>> > way in one flash node.
>>
>> Are there any such platforms?
>
> Yes, I know some. Even though they are currently not used with a partitio=
n
> spanning over those multiple chips (jedec and cfi).

OK

>> Is there much likelihood that such a
>> platform will be created? =A0Would it even be a good idea to span
>> partitions across such an arrangement given that different devices
>> will behave differently?
>
> OK, in the example above such a spanning partition is not so likely. But =
think
> about my original example, the Intel P30 with two different cfi compatibl=
e
> chips on one die. Here a partition spanning over both devices is very lik=
ely.

I agree.  Same thing when two or more flash chips are put on a board
in consecutive addresses.  I've worked on plenty of these arrangements
myself.

This case really does sound like a driver bug and that the existing
cfi-flash binding is sufficient to describe the hardware.  IIUC, when
all the flash chips are of the same type the physmap_of driver should
be smart enough to detect each of the flash chips within the reg
range.

If I'm wrong and it cannot do this, then it would be a simple matter
of adding an additional tuple to reg for each discrete chip.  A
simple, backwards compatible extension which doesn't require a new
binding.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
