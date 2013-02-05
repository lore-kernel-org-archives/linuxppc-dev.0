Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-ia0-x22d.google.com (mail-ia0-x22d.google.com
 [IPv6:2607:f8b0:4001:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B85E32C0307
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 11:02:45 +1100 (EST)
Received: by mail-ia0-f173.google.com with SMTP id h37so4430967iak.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2013 16:02:41 -0800 (PST)
Date: Mon, 4 Feb 2013 16:04:47 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device hotplug
 framework
Message-ID: <20130205000447.GA21782@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <5598823.8hjkkMP1h9@vostro.rjw.lan>
 <1360016009.23410.213.camel@misato.fc.hp.com>
 <7003418.onqVlaaHJS@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7003418.onqVlaaHJS@vostro.rjw.lan>
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

On Tue, Feb 05, 2013 at 12:52:30AM +0100, Rafael J. Wysocki wrote:
> You'd probably never try to hot-remove a disk before unmounting filesystems
> mounted from it or failing it as a RAID component and nobody sane wants the
> kernel to do things like that automatically when the user presses the eject
> button.  In my opinion we should treat memory eject, or CPU package eject, or
> PCI host bridge eject in exactly the same way: Don't eject if it is not
> prepared for ejecting in the first place.

Bad example, we have disks hot-removed all the time without any
filesystems being unmounted, and have supported this since the 2.2 days
(although we didn't get it "right" until 2.6.)

PCI Host bridge eject is the same as PCI eject today, the user asks us
to do it, and we can not fail it from happening.  We also can have them
removed without us being told about it in the first place, and can
properly clean up from it all.

> And if you think about it, that makes things *massively* simpler, because now
> the kernel doesn't heed to worry about all of those "synchronous removal"
> scenarions that very well may involve every single device in the system and
> the whole problem is nicely split into several separate "implement
> offline/online" problems that are subsystem-specific and a single
> "eject if everything relevant is offline" problem which is kind of trivial.
> Plus the one of exposing information to user space, which is separate too.
> 
> Now, each of them can be worked on separately, *tested* separately and
> debugged separately if need be and it is much easier to isolate failures
> and so on.

So you are agreeing with me in that we can not fail hot removing any
device, nice :)

greg k-h
