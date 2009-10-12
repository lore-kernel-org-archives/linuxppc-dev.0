Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9D2A3B7B80
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 09:44:12 +1100 (EST)
Date: Tue, 13 Oct 2009 02:44:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of/platform: Implement support for dev_pm_ops
Message-ID: <20091012224410.GA18923@oksana.dev.rtsoft.ru>
References: <20091012155041.GA1071@oksana.dev.rtsoft.ru>
	<fa686aa40910121509n1b7dba87nbe9ddf34f0b4d7c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40910121509n1b7dba87nbe9ddf34f0b4d7c@mail.gmail.com>
Cc: linux-pm@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 12, 2009 at 03:09:53PM -0700, Grant Likely wrote:
> On Mon, Oct 12, 2009 at 8:50 AM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > Linux power management subsystem supports vast amount of new PM
> > callbacks that are crucial for proper suspend and hibernation support
> > in drivers.
> >
> > This patch implements support for dev_pm_ops, preserving support
> > for legacy callbacks.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Hmmm...  I'm not very familiar with the PM callbacks, but change
> doesn't look right to me.  In particular, a lot of these new hooks
> don't do anything remotely of_platform bus specific.  For example,
> of_platform_pm_prepare() checks if there is drv, drv->pm, and
> drv->pm->prepare.  If all are true, then it calls drv->pm->prepare().
> I see that the platform bus platform_pm_prepare() function is
> absolutely identical.  I haven't looked, but I wouldn't be surprised
> if other busses do the same.
> 
> I think these simple pm ops should be made library functions that
> platform, of_platform and other simple busses can just populate their
> pm ops structure with.

Some hooks can be made as library functions, but some can't (for
example that do of_plaform_driver->suspend(), as opposite to
of_platform_driver->driver.suspend(), i.e. the legacy hooks).
Also, if you look into PCI bus hooks, you'll see that these hooks
aren't pure proxies for drivers, they do real work, so they won't
like to reuse or share anything.

For OF platfrom bus, we can share these functions with platform:

of_platform_pm_suspend_noirq
of_platform_pm_resume_noirq
of_platform_pm_freeze_noirq
of_platform_pm_thaw_noirq
of_platform_pm_poweroff_noirq
of_platform_pm_restore_noirq

These we cannot share:

of_platform_pm_suspend
of_platform_pm_resume
of_platform_pm_freeze
of_platform_pm_thaw
of_platform_pm_poweroff
of_platform_pm_restore

I agree that there is some room for improvements in general (e.g.
merging platform and of_platform devices/drivers), but it's not as
easy as you would like to think. Let's make it in a separate step
that don't stop real features from being implemented (e.g.
hibernate).

For the six functions that we can reuse I can prepare a cleanup
patch that we can merge via -mm, or it can just sit and collect
needed acks and can be merged via any tree. But please, no
cross-tree dependencies for the cruicial features.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
