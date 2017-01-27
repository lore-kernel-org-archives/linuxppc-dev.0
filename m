Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8zBX1Hf8zDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 23:49:23 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id e4so18507111pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 04:49:23 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 27 Jan 2017 18:19:10 +0530
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix RECLAIM_DISTANCE
Message-ID: <20170127124910.GA2668@localhost.localdomain>
References: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170125035744.GB12855@localhost.localdomain>
 <20170125045822.GA10566@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170125045822.GA10566@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2017 at 03:58:22PM +1100, Gavin Shan wrote:
> On Wed, Jan 25, 2017 at 09:27:44AM +0530, Balbir Singh wrote:
> >On Tue, Jan 24, 2017 at 10:32:28AM +1100, Gavin Shan wrote:
> >> When @node_reclaim_mode ("/proc/sys/vm/zone_reclaim_mode") is enabled,
> >> the nodes in the specified distance (< RECLAIM_DISTANCE) to the preferred
> >> one will be checked for page direct reclaim in the fast path, as below
> >> function call chain indicates. Currently, RECLAIM_DISTANCE is set to 10,
> >> equal to LOCAL_DISTANCE. It means no nodes, including the preferred one,
> >> don't match the conditions. So no nodes are checked for direct reclaim
> >> in the fast path.
> >> 
> >>    __alloc_pages_nodemask
> >>    get_page_from_freelist
> >>    zone_allows_reclaim
> >> 
> >> This fixes it by setting RECLAIM_DISTANCE to 30. With it, the preferred
> >> node and its directly adjacent nodes will be checked for page direct
> >> reclaim. The comments explaining RECLAIM_DISTANCE is out of date. This
> >> updates and makes it correct.
> >> 
> >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >> ---
> >
> >I spoke about this at length with Anton and the larger kernel team.
> >We need performance data before we can commit to the change. Do we
> >benchmarks to show that the change does not introduce regression
> >w.r.t runtime cost?
> >
> 
> Thanks for review. I just found the problem when studying the code
> last year. It sounds reasonable not to rely on the slow path for page
> reclaim if the fast path can reclaim enough pages. From this point,
> I believe the performance should be improved. In the meanwhile, the
> page cache/buffer could be released, as part of the output of page
> reclaim. It's going to affect fs's performance for sure. So do you
> have recommended test examples to measure the improved performance
> because of this?
>

Anton suggested that NUMA distances in powerpc mattered and hurted
performance without this setting. We need to validate to see if this
is still true. A simple way to start would be benchmarking

Balbir Singh.
