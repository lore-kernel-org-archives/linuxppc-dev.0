Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-da0-f44.google.com (mail-da0-f44.google.com
 [209.85.210.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB3C32C02C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2013 05:37:40 +1100 (EST)
Received: by mail-da0-f44.google.com with SMTP id z20so181850dae.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Feb 2013 10:37:38 -0800 (PST)
Date: Tue, 5 Feb 2013 10:39:48 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device hotplug
 framework
Message-ID: <20130205183948.GA19026@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <7003418.onqVlaaHJS@vostro.rjw.lan>
 <20130205000447.GA21782@kroah.com>
 <4225828.6MQHJn7Yzr@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4225828.6MQHJn7Yzr@vostro.rjw.lan>
Cc: linux-s390@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 yinghai@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com,
 guohanjun@huawei.com, bhelgaas@google.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 05, 2013 at 12:11:17PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 04, 2013 04:04:47 PM Greg KH wrote:
> > On Tue, Feb 05, 2013 at 12:52:30AM +0100, Rafael J. Wysocki wrote:
> > > You'd probably never try to hot-remove a disk before unmounting filesystems
> > > mounted from it or failing it as a RAID component and nobody sane wants the
> > > kernel to do things like that automatically when the user presses the eject
> > > button.  In my opinion we should treat memory eject, or CPU package eject, or
> > > PCI host bridge eject in exactly the same way: Don't eject if it is not
> > > prepared for ejecting in the first place.
> > 
> > Bad example, we have disks hot-removed all the time without any
> > filesystems being unmounted, and have supported this since the 2.2 days
> > (although we didn't get it "right" until 2.6.)
> 
> I actually don't think it is really bad, because it exposes the problem nicely.
> 
> Namely, there are two arguments that can be made here.  The first one is the
> usability argument: Users should always be allowed to do what they want,
> because it is [explicit content] annoying if software pretends to know better
> what to do than the user (it is a convenience argument too, because usually
> it's *easier* to allow users to do what they want).  The second one is the
> data integrity argument: Operations that may lead to data loss should never
> be carried out, because it is [explicit content] disappointing to lose valuable
> stuff by a stupid mistake if software allows that mistake to be made (that also
> may be costly in terms of real money).
> 
> You seem to believe that we should always follow the usability argument, while
> Toshi seems to be thinking that (at least in the case of the "system" devices),
> the data integrity argument is more important.  They are both valid arguments,
> however, and they are in conflict, so this is a matter of balance.
> 
> You're saying that in the case of disks we always follow the usability argument
> entirely.  I'm fine with that, although I suspect that some people may not be
> considering this as the right balance.
> 
> Toshi seems to be thinking that for the hotplug of memory/CPUs/host bridges we
> should always follow the data integrity argument entirely, because the users of
> that feature value their data so much that they pretty much don't care about
> usability.  That very well may be the case, so I'm fine with that too, although
> I'm sure there are people who'll argue that this is not the right balance
> either.
> 
> Now, the point is that we *can* do what Toshi is arguing for and that doesn't
> seem to be overly complicated, so my question is: Why don't we do that, at
> least to start with?  If it turns out eventually that the users care about
> usability too, after all, we can add a switch to adjust things more to their
> liking.  Still, we can very well do that later.

Ok, I'd much rather deal with reviewing actual implementations than
talking about theory at this point in time, so let's see what you all
can come up with next and I'll be glad to review it.

thanks,

greg k-h
