Return-Path: <linasvepstas@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CB82AB7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:16:40 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id CA746DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 00:16:39 +1000 (EST)
Received: by yxe37 with SMTP id 37so1600541yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 07:16:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1247790973.16836.11.camel@concordia>
References: <4A5E4D68.6070909@us.ibm.com> <1247708506.9851.8.camel@concordia>
	<4A5F5675.6040104@us.ibm.com> <1247790973.16836.11.camel@concordia>
Date: Thu, 23 Jul 2009 09:16:33 -0500
Message-ID: <3ae3aa420907230716s6d945ffax37e429caf6b03343@mail.gmail.com>
Subject: Re: [PATCH] Hold reference to device_node during EEH event handling
From: Linas Vepstas <linasvepstas@gmail.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/7/16 Michael Ellerman <michael@ellerman.id.au>:
> On Thu, 2009-07-16 at 09:33 -0700, Mike Mason wrote:
>> Michael Ellerman wrote:
>> > On Wed, 2009-07-15 at 14:43 -0700, Mike Mason wrote:
>> >> This patch increments the device_node reference counter when an EEH
>> >> error occurs and decrements the counter when the event has been
>> >> handled. =C2=A0This is to prevent the device_node from being released=
 until
>> >> eeh_event_handler() has had a chance to deal with the event. =C2=A0We=
've
>> >> seen cases where the device_node is released too soon when an EEH
>> >> event occurs during a dlpar remove, causing the event handler to
>> >> attempt to access bad memory locations.
>> >>
>> >> Please review and let me know of any concerns.
>> >
>> > Taking a reference sounds sane, but ...
>> >
>> >> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
>> >>
>> >> --- a/arch/powerpc/platforms/pseries/eeh_event.c =C2=A0 2008-10-09 15=
:13:53.000000000 -0700
>> >> +++ b/arch/powerpc/platforms/pseries/eeh_event.c =C2=A0 2009-07-14 14=
:14:00.000000000 -0700
>> >> @@ -75,6 +75,14 @@ static int eeh_event_handler(void * dumm
>> >> =C2=A0 =C2=A0if (event =3D=3D NULL)
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> >>
>> >> + =C2=A0/* EEH holds a reference to the device_node, so if it
>> >> + =C2=A0 * equals 1 it's no longer valid and the event should
>> >> + =C2=A0 * be ignored */
>> >> + =C2=A0if (atomic_read(&event->dn->kref.refcount) =3D=3D 1) {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of_node_put(event->dn);
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> >> + =C2=A0}
>> >
>> > That's really gross :)
>>
>> Agreed. =C2=A0I'll look for another way to determine if device is gone a=
nd
>> the event should be ignored. =C2=A0Suggestions are welcome :-)
>
> Benh and I had a quick chat about it, and were wondering whether what
> you really should be doing is taking a reference to the pci device
> (perhaps as well as the device node).
>
> @@ -140,7 +149,7 @@ int eeh_send_failure_event (struct devic
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dev_get(dev);
>
> - =C2=A0 =C2=A0 =C2=A0 event->dn =3D dn;
> + =C2=A0 =C2=A0 =C2=A0 event->dn =3D of_node_get(dn);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0event->dev =3D dev;
>
> pci devs are refcounted too, see pci_dev_get(), so taking a reference
> there would be the "right" thing to do - otherwise there's no guarantee
> it still exists later, unless there's some other trick in the EEH code.

I thought that the eeh code did pci gets and puts in the right locations,
perhaps I (incorrectly) assumed that this meant that the of_dn use count
never dropped to zero ...

I think my logic was:
-- pci device init does of_node_get
-- pci device shutdown does of_node_put
-- pci device shutdown can never run as long as pci use count is > 0

Thus, explicit of_node_get was usually not needed.

So, for example, see above: I was figuring that the pci_dev_get(dev);
was enough to protect the dn too .. although maybe if dev is null,
then things go wrong ...

--linas
