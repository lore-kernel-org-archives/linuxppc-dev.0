Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7E66E2C035A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 17:17:27 +1000 (EST)
Message-ID: <1342595820.3669.71.camel@pasglop>
Subject: Re: [PATCH] mm: setup pageblock_order before it's used by sparse
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jiang Liu <jiang.liu@huawei.com>
Date: Wed, 18 Jul 2012 17:17:00 +1000
In-Reply-To: <4FF26726.8010904@huawei.com>
References: <1341047274-5616-1-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQWzfLkeQs8O22MUEmuGUx=jPi5s=wZt2fcpFMcwrzt3uA@mail.gmail.com>
 <4FF100F0.9050501@huawei.com>
 <CAE9FiQXpeGFfWvUHHW_GjgTg+4Op7agsht5coZbcmn2W=f9bqw@mail.gmail.com>
 <4FF25EFA.1080004@huawei.com>
 <CAE9FiQVxY9E3L_xmRj10+9D6NVbKaxaAd2oJ6EFe1D+Gy2971w@mail.gmail.com>
 <4FF26726.8010904@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Keping Chen <chenkeping@huawei.com>, Mel Gorman <mgorman@suse.de>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 David Rientjes <rientjes@google.com>, Xishi Qiu <qiuxishi@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, Yinghai Lu <yinghai@kernel.org>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Jiang Liu <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-07-03 at 11:29 +0800, Jiang Liu wrote:
> OK, waiting response from PPC. If we could find some ways to set
> HPAGE_SIZE
> early on PPC too, we can setup pageblock_order in arch instead of
> page_alloc.c
> as early as possible. 

We could split our hugetlbpage_init() into two, with the bit that sets
HPAGE_SHIFT called earlier if it's really an issue.

Cheers,
Ben.
