Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gVv95smkzF1Hr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 21:09:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal Hocko <mhocko@kernel.org>, John Allen <jallen@linux.ibm.com>
Cc: n-horiguchi@ah.jp.nec.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com, mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
In-Reply-To: <20180725200336.GP28386@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
Date: Wed, 01 Aug 2018 21:09:39 +1000
Message-ID: <87r2jifimk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Hocko <mhocko@kernel.org> writes:
> On Wed 25-07-18 13:11:15, John Allen wrote:
> [...]
>> Does a failure in do_migrate_range indicate that the range is unmigratable
>> and the loop in __offline_pages should terminate and goto failed_removal? Or
>> should we allow a certain number of retrys before we
>> give up on migrating the range?
>
> Unfortunatelly not. Migration code doesn't tell a difference between
> ephemeral and permanent failures.

What's to stop an ephemeral failure happening repeatedly?

cheers
