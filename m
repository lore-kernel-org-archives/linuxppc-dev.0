Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0103.outbound.protection.outlook.com [207.46.100.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 020691A1D39
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 13:39:34 +1000 (AEST)
Message-ID: <1439523559.4099.116.camel@freescale.com>
Subject: Re: [PATCH 3/3] powerpc/e6500: hw tablewalk: order the memory
 access when acquire/release tcd lock
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 13 Aug 2015 22:39:19 -0500
In-Reply-To: <1439466697-18989-3-git-send-email-haokexin@gmail.com>
References: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
 <1439466697-18989-3-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-13 at 19:51 +0800, Kevin Hao wrote:
> I didn't find anything unusual. But I think we do need to order the
> load/store of esel_next when acquire/release tcd lock. For acquire,
> add a data dependency to order the loads of lock and esel_next.
> For release, even there already have a "isync" here, but it doesn't
> guarantee any memory access order. So we still need "lwsync" for
> the two stores for lock and esel_next.

I was going to say that esel_next is just a hint and it doesn't really matter 
if we occasionally get the wrong value, unless it happens often enough to 
cause more performance degradation than the lwsync causes.  However, with the 
A-008139 workaround we do need to read the same value from esel_next both 
times.  It might be less costly to save/restore an additional register 
instead of lwsync, though.

-Scott
