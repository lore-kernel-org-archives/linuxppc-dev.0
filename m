Return-Path: <rjw@sisk.pl>
Received: from hydra.sisk.pl (hydra.sisk.pl [212.160.235.94])
 by ozlabs.org (Postfix) with ESMTP id 238652C02B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 06:42:29 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device hotplug
 framework
Date: Mon, 04 Feb 2013 20:48:46 +0100
Message-ID: <1890597.vDojv7So7R@vostro.rjw.lan>
In-Reply-To: <1359993766.23410.105.camel@misato.fc.hp.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <5192355.CsKHU8mj3W@vostro.rjw.lan>
 <1359993766.23410.105.camel@misato.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-s390@vger.kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com,
 linux-acpi@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, yinghai@kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com, guohanjun@huawei.com, bhelgaas@google.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, February 04, 2013 09:02:46 AM Toshi Kani wrote:
> On Mon, 2013-02-04 at 14:41 +0100, Rafael J. Wysocki wrote:
> > On Sunday, February 03, 2013 07:23:49 PM Greg KH wrote:
> > > On Sat, Feb 02, 2013 at 09:15:37PM +0100, Rafael J. Wysocki wrote:
> > > > On Saturday, February 02, 2013 03:58:01 PM Greg KH wrote:
>   :
> > > > Yes, but those are just remove events and we can only see how destructive they
> > > > were after the removal.  The point is to be able to figure out whether or not
> > > > we *want* to do the removal in the first place.
> > > 
> > > Yes, but, you will always race if you try to test to see if you can shut
> > > down a device and then trying to do it.  So walking the bus ahead of
> > > time isn't a good idea.
> > >
> > > And, we really don't have a viable way to recover if disconnect() fails,
> > > do we.  What do we do in that situation, restore the other devices we
> > > disconnected successfully?  How do we remember/know what they were?
> > > 
> > > PCI hotplug almost had this same problem until the designers finally
> > > realized that they just had to accept the fact that removing a PCI
> > > device could either happen by:
> > > 	- a user yanking out the device, at which time the OS better
> > > 	  clean up properly no matter what happens
> > > 	- the user asked nicely to remove a device, and the OS can take
> > > 	  as long as it wants to complete that action, including
> > > 	  stalling for noticable amounts of time before eventually,
> > > 	  always letting the action succeed.
> > > 
> > > I think the second thing is what you have to do here.  If a user tells
> > > the OS it wants to remove these devices, you better do it.  If you
> > > can't, because memory is being used by someone else, either move them
> > > off, or just hope that nothing bad happens, before the user gets
> > > frustrated and yanks out the CPU/memory module themselves physically :)
> > 
> > Well, that we can't help, but sometimes users really *want* the OS to tell them
> > if it is safe to unplug something at this particualr time (think about the
> > Windows' "safe remove" feature for USB sticks, for example; that came out of
> > users' demand AFAIR).
> > 
> > So in my opinion it would be good to give them an option to do "safe eject" or
> > "forcible eject", whichever they prefer.
> 
> For system device hot-plug, it always needs to be "safe eject".  This
> feature will be implemented on mission critical servers, which are
> managed by professional IT folks.  Crashing a server causes serious
> money to the business.

Well, "always" is a bit too strong a word as far as human behavior is concerned
in my opinion.

That said I would be perfectly fine with not supporting the "forcible eject" to
start with and waiting for the first request to add support for it.  I also
would be fine with taking bets on how much time it's going to take for such a
request to appear. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
