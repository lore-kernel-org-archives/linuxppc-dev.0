Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP30m17gZzDwK5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 00:22:32 +1100 (AEDT)
Received: by mail-wm0-f67.google.com with SMTP id m203so1984309wma.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 05:22:31 -0800 (PST)
Date: Wed, 23 Nov 2016 14:22:27 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [mm v2 0/3] Support memory cgroup hotplug
Message-ID: <20161123132226.GL2864@dhcp22.suse.cz>
References: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
 <20161123072543.GD2864@dhcp22.suse.cz>
 <342ebcca-b54c-4bc6-906b-653042caae06@gmail.com>
 <20161123080744.GG2864@dhcp22.suse.cz>
 <61dc32fd-2802-6deb-24cf-fa11b5b31532@gmail.com>
 <20161123092830.GH2864@dhcp22.suse.cz>
 <962ac541-55c4-de09-59a3-4947c394eee6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <962ac541-55c4-de09-59a3-4947c394eee6@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 24-11-16 00:05:12, Balbir Singh wrote:
> 
> 
> On 23/11/16 20:28, Michal Hocko wrote:
[...]
> > I am more worried about synchronization with the hotplug which tends to
> > be a PITA in places were we were simply safe by definition until now. We
> > do not have all that many users of memcg->nodeinfo[nid] from what I can see
> > but are all of them safe to never race with the hotplug. A lack of
> > highlevel design description is less than encouraging.
> 
> As in explanation? The design is dictated by the notifier and the actions
> to take when the node comes online/offline.

Sure but how all the users of lruvec (for example) which is stored in
the nodeinfo AFAIR, are supposed to synchronize with the notifier.
Really if you are doing something dynamic then the first thing to
explain is the sychronization. There might be really good reasons why we
do not have to care about explicit synchr. for most code paths but my
past experience with many subtle hotplug related bugs just make me a bit
suspicious. So in other words, please make sure to document as much as
possible. This will make the review so much easier.

>  So please try to
> > spend some time describing how do we use nodeinfo currently and how is
> > the synchronization with the hotplug supposed to work and what
> > guarantees that no stale nodinfos can be ever used. This is just too
> > easy to get wrong...
> > 
> 
> OK.. I'll add that in the next cover letter

Thanks!

-- 
Michal Hocko
SUSE Labs
