Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C304C1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:48:17 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 15:48:17 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 53B632BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:48:16 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B5m8q939256226
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:48:16 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B5lgKH015208
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:47:42 +1100
Date: Wed, 11 Mar 2015 13:47:26 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] powerpc/eeh: fix powernv_eeh_wait_state delay logic
Message-ID: <20150311054726.GA5826@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1425871052-13118-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1425871052-13118-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150311051346.GC6906@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150311051346.GC6906@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2015 at 04:13:46PM +1100, Gavin Shan wrote:
>On Mon, Mar 09, 2015 at 11:17:31AM +0800, Wei Yang wrote:
>>As the comment indicates, powernv_eeh_get_state() will inform EEH core to
>>delay 1 second. This means the delay doesn't happen when
>>powernv_eeh_get_state() returns.
>>
>>This patch moves the delay subtraction just before msleep(), which is the
>>same logic in pseries_eeh_wait_state().
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
>The patch would conflict with the patches to remove EEH chip layer done
>in https://patchwork.ozlabs.org/patch/439956/. Could you please repost
>with corrected function names in commit log when the dependent patches
>show up in Michael's next branch?
>
>Except that, the changes look ok to me:
>
>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks, I will repost it accordingly.

>
>Thanks,
>Gavin
>
>>---
>> arch/powerpc/platforms/powernv/eeh-powernv.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>index 5abb4c2..af1be8f 100644
>>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>@@ -334,13 +334,13 @@ static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
>> 		if (ret != EEH_STATE_UNAVAILABLE)
>> 			return ret;
>>
>>-		max_wait -= mwait;
>> 		if (max_wait <= 0) {
>> 			pr_warn("%s: Timeout getting PE#%x's state (%d)\n",
>> 				__func__, pe->addr, max_wait);
>> 			return EEH_STATE_NOT_SUPPORT;
>> 		}
>>
>>+		max_wait -= mwait;
>> 		msleep(mwait);
>> 	}
>>
>>-- 
>>1.7.9.5
>>

-- 
Richard Yang
Help you, Help me
