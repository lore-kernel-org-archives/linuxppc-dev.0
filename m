Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 9C61ADF643
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 08:22:44 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1558567yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 14:22:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090311170057.GA24113@suse.de>
References: <20090306160818.404.92700.stgit@localhost.localdomain>
	<20090311162623.GE21831@suse.de>
	<fa686aa40903110935g155fbf7m83f4aead71d72488@mail.gmail.com>
	<20090311170057.GA24113@suse.de>
Date: Mon, 16 Mar 2009 15:22:42 -0600
Message-ID: <fa686aa40903161422n77b425d0i92993cf0e473548d@mail.gmail.com>
Subject: Re: [RFC] drivers/base: Add bus_register_notifier_alldev() variant
From: Grant Likely <grant.likely@secretlab.ca>
To: Greg KH <gregkh@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 11:00 AM, Greg KH <gregkh@suse.de> wrote:
> On Wed, Mar 11, 2009 at 10:35:29AM -0600, Grant Likely wrote:
>> On Wed, Mar 11, 2009 at 10:26 AM, Greg KH <gregkh@suse.de> wrote:
>> > On Fri, Mar 06, 2009 at 09:10:19AM -0700, Grant Likely wrote:
>> >> From: Grant Likely <grant.likely@secretlab.ca>
>> >>
>> >> bus_register_notifier_alldev() is a variation on bus_register_notifie=
r()
>> >> which also triggers the notifier callback for devices already on the =
bus
>> >> and already bound to drivers.
>> >>
>> >> This function is useful for the case where a driver needs to get a
>> >> reference to a struct device other than the one it is bound to and
>> >> it is not known if the device will be bound before or after this
>> >> function is called. =A0For example, an Ethernet device connected to
>> >> a PHY that is probed separately.
>> >
>> > Can't you just walk the list of all devices already on the bus to get
>> > "notified" of them, and then register your notifier handler as well (o=
r
>> > register it first, and then walk the list, which is pretty much what
>> > your patch does)?
>>
>> Yes, and I originally did, but it looks to me like a useful common
>> pattern that is less error prone than open coding it.
>
> How about we wait, and if someone else does the same thing, we then add
> it to the core like this?

I'm okay with that.  Actually, I had two drivers that were using this,
but that need has gone away because I've learned that I can defer
locating the other device to open() time.  I still think that it may
be useful, but I agree that simply theoretical usage is not a good
reason to add the API.

> Actually, wouldn't it make more sense to just change the default
> "bus_register_notifier" to do this? =A0Is there some reason that the
> caller would not want this kind of thing to happen?

It doesn't look like there are many users of this facility, and from
looking at them it appears that adding the reporting of already
registered & bound devices would make sense.  However, to do this my
patch would need to be fixed to eliminate the race condition where an
add or bind event could get reported more than once on a single
device.  It looks like the existing users expect never to be called
more than once for each device.  Unfortunately, I don't know how to
fix the race.  I need to research more.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
