Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CA3D1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:14:47 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 15:14:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 37ED52BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:14:44 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B5EZnN30933212
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:14:44 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B5EAED030271
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:14:10 +1100
Date: Wed, 11 Mar 2015 16:13:46 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] powerpc/eeh: fix powernv_eeh_wait_state delay logic
Message-ID: <20150311051346.GC6906@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1425871052-13118-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1425871052-13118-4-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425871052-13118-4-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 09, 2015 at 11:17:31AM +0800, Wei Yang wrote:
>As the comment indicates, powernv_eeh_get_state() will inform EEH core to
>delay 1 second. This means the delay doesn't happen when
>powernv_eeh_get_state() returns.
>
>This patch moves the delay subtraction just before msleep(), which is the
>same logic in pseries_eeh_wait_state().
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

The patch would conflict with the patches to remove EEH chip layer done
in https://patchwork.ozlabs.org/patch/439956/. Could you please repost
with corrected function names in commit log when the dependent patches
show up in Michael's next branch?

Except that, the changes look ok to me:

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/platforms/powernv/eeh-powernv.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>index 5abb4c2..af1be8f 100644
>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>@@ -334,13 +334,13 @@ static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
> 		if (ret != EEH_STATE_UNAVAILABLE)
> 			return ret;
>
>-		max_wait -= mwait;
> 		if (max_wait <= 0) {
> 			pr_warn("%s: Timeout getting PE#%x's state (%d)\n",
> 				__func__, pe->addr, max_wait);
> 			return EEH_STATE_NOT_SUPPORT;
> 		}
>
>+		max_wait -= mwait;
> 		msleep(mwait);
> 	}
>
>-- 
>1.7.9.5
>
