Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7WV90k1WzDqDh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 14:57:53 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y143so13389533pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 19:57:53 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 25 Jan 2017 09:27:44 +0530
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix RECLAIM_DISTANCE
Message-ID: <20170125035744.GB12855@localhost.localdomain>
References: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 24, 2017 at 10:32:28AM +1100, Gavin Shan wrote:
> When @node_reclaim_mode ("/proc/sys/vm/zone_reclaim_mode") is enabled,
> the nodes in the specified distance (< RECLAIM_DISTANCE) to the preferred
> one will be checked for page direct reclaim in the fast path, as below
> function call chain indicates. Currently, RECLAIM_DISTANCE is set to 10,
> equal to LOCAL_DISTANCE. It means no nodes, including the preferred one,
> don't match the conditions. So no nodes are checked for direct reclaim
> in the fast path.
> 
>    __alloc_pages_nodemask
>    get_page_from_freelist
>    zone_allows_reclaim
> 
> This fixes it by setting RECLAIM_DISTANCE to 30. With it, the preferred
> node and its directly adjacent nodes will be checked for page direct
> reclaim. The comments explaining RECLAIM_DISTANCE is out of date. This
> updates and makes it correct.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---

I spoke about this at length with Anton and the larger kernel team.
We need performance data before we can commit to the change. Do we
benchmarks to show that the change does not introduce regression
w.r.t runtime cost?

Balbir Singh.
