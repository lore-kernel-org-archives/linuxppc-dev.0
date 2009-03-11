Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id E4BEEDE1B7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 03:35:31 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so52782yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:35:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090311162623.GE21831@suse.de>
References: <20090306160818.404.92700.stgit@localhost.localdomain>
	<20090311162623.GE21831@suse.de>
Date: Wed, 11 Mar 2009 10:35:29 -0600
Message-ID: <fa686aa40903110935g155fbf7m83f4aead71d72488@mail.gmail.com>
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

On Wed, Mar 11, 2009 at 10:26 AM, Greg KH <gregkh@suse.de> wrote:
> On Fri, Mar 06, 2009 at 09:10:19AM -0700, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> bus_register_notifier_alldev() is a variation on bus_register_notifier()
>> which also triggers the notifier callback for devices already on the bus
>> and already bound to drivers.
>>
>> This function is useful for the case where a driver needs to get a
>> reference to a struct device other than the one it is bound to and
>> it is not known if the device will be bound before or after this
>> function is called. =A0For example, an Ethernet device connected to
>> a PHY that is probed separately.
>
> Can't you just walk the list of all devices already on the bus to get
> "notified" of them, and then register your notifier handler as well (or
> register it first, and then walk the list, which is pretty much what
> your patch does)?

Yes, and I originally did, but it looks to me like a useful common
pattern that is less error prone than open coding it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
