Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMr1F3NM6zDvjG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 01:03:45 +1100 (AEDT)
Received: by mail-wm0-f67.google.com with SMTP id g23so2295303wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 06:03:45 -0800 (PST)
Date: Mon, 21 Nov 2016 15:03:41 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND][v1 0/3] Support memory cgroup hotplug
Message-ID: <20161121140340.GC18112@dhcp22.suse.cz>
References: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 16-11-16 10:44:58, Balbir Singh wrote:
> In the absence of hotplug we use extra memory proportional to
> (possible_nodes - online_nodes) * number_of_cgroups. PPC64 has a patch
> to disable large consumption with large number of cgroups. This patch
> adds hotplug support to memory cgroups and reverts the commit that
> limited possible nodes to online nodes.

I didn't get to read patches yet (I am currently swamped by emails after
longer vacation so bear with me) but this doesn't tell us _why_ we want
this and how much we can actaully save. In general being dynamic is more
complex and most systems tend to have possible_nodes close to
online_nodes in my experience (well at least on most reasonable
architectures). I would also appreciate some highlevel description of
the implications. E.g. how to we synchronize with the hotplug operations
when iterating node specific data structures.

Thanks!

-- 
Michal Hocko
SUSE Labs
