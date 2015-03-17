Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6741E1A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 17:55:02 +1100 (AEDT)
Date: Tue, 17 Mar 2015 07:54:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] perf: Add 'update' parameter to
 perf_event_read_value()
Message-ID: <20150317065453.GM2896@worktop.programming.kicks-ass.net>
References: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1425458108-3341-4-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425458108-3341-4-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: dev@codyps.com, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 04, 2015 at 12:35:07AM -0800, Sukadev Bhattiprolu wrote:

>  extern u64 perf_event_read_value(struct perf_event *event,
> -				 u64 *enabled, u64 *running);
> +				 u64 *enabled, u64 *running, int update);
>  

I think someone recently showed that bool generates better code in some
cases. The advantage of int is that you can stuff more bits in, but then
you need to call it flags or so anyhow.
