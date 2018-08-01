Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gW7x5QmNzF18f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 21:20:44 +1000 (AEST)
Date: Wed, 1 Aug 2018 13:20:39 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: John Allen <jallen@linux.ibm.com>, n-horiguchi@ah.jp.nec.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kamezawa.hiroyu@jp.fujitsu.com, mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
Message-ID: <20180801112039.GJ16767@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
 <87r2jifimk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2jifimk.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 01-08-18 21:09:39, Michael Ellerman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> > On Wed 25-07-18 13:11:15, John Allen wrote:
> > [...]
> >> Does a failure in do_migrate_range indicate that the range is unmigratable
> >> and the loop in __offline_pages should terminate and goto failed_removal? Or
> >> should we allow a certain number of retrys before we
> >> give up on migrating the range?
> >
> > Unfortunatelly not. Migration code doesn't tell a difference between
> > ephemeral and permanent failures.
> 
> What's to stop an ephemeral failure happening repeatedly?

If there is a short term pin on the page that prevents the migration
then the holder of the pin should realease it and the next retry will
succeed the migration. If the page gets freed on the way then it will
not be reallocated because they are isolated already. I can only see
complete OOM to be the reason to fail allocation of the target place
as the migration failure and that is highly unlikely and sooner or later
trigger the oom killer and release some memory.

The biggest problem here is that we cannot tell ephemeral and long term
pins...
-- 
Michal Hocko
SUSE Labs
