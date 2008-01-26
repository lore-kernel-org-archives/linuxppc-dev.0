Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 001DCDDF77
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 04:24:13 +1100 (EST)
Date: Sat, 26 Jan 2008 11:36:12 -0600
From: Olof Johansson <olof@lixom.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 063/196] kset: convert /sys/devices to use kset_create
Message-ID: <20080126173612.GB29143@lixom.net>
References: <20080125071127.GA4860@kroah.com>
	<1201245134-4876-63-git-send-email-gregkh@suse.de>
	<20080126034055.GA28786@lixom.net> <20080126052454.GA27403@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080126052454.GA27403@suse.de>
Cc: linuxppc-dev@ozlabs.org, Kay Sievers <kay.sievers@vrfy.org>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 09:24:54PM -0800, Greg KH wrote:
> On Fri, Jan 25, 2008 at 09:40:55PM -0600, Olof Johansson wrote:
> > On Thu, Jan 24, 2008 at 11:10:01PM -0800, Greg Kroah-Hartman wrote:
> > > Dynamically create the kset instead of declaring it statically.  We also
> > > rename devices_subsys to devices_kset to catch all users of the
> > > variable.
> > 
> > Guess what, you broke powerpc again!
> 
> I did this ON PURPOSE!!!
> 
> The linux-kernel archives hold the details, and I was told by the PPC64
> IBM people that they would fix this properly for 2.6.25, and not to hold
> back on my changes.  This has been known for many months now.

Yeah, my bad. :( I thought this was new, but it was just not exposed by
my scripts because of the EHEA build errors (they were actual compile
errors, while this was a link error, so it never go this far). That's
why I didn't see it in -rc8-mm1 and thought it was new.

> > -extern struct kset devices_subsys; /* needed for vio_find_name() */
> > +extern struct kset *devices_kset; /* needed for vio_find_name() */
> 
> No, this just papers over the real problem here.  For some reason, the
> vio code thinks it is acceptable to walk the whole device tree and match
> by a name and just assume that they got the correct device.  You call
> this "enterprise grade"?  :)
>
> You need to just put your device on a real bus, and then just walk the
> bus.  That's the ONLY way you can guarantee the proper name will return
> what you want, and you get the pointer that you really think you are
> getting.

Hmm, they are already on a bus. Odd, must be done like this for legacy
reasons.

[...]

> So no, I'm going to leave the build broken for this code, because that
> is what it really is.
> 
> Please fix it correctly.

Alright, I'll leave that to people who care about vio and can test the
proper fix. After a quick glance it looks like it should be easy to use
bus_find_device() for it instead.


-Olof
