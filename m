Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50D181A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:18:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 15:18:40 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ACBA82CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:18:39 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B5IVNT47907020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:18:39 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B5I6eW003452
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 16:18:06 +1100
Date: Wed, 11 Mar 2015 16:17:42 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] powerpc/eeh: fix comment for wait_state()
Message-ID: <20150311051742.GA10336@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1425871052-13118-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1425871052-13118-3-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425871052-13118-3-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 09, 2015 at 11:17:30AM +0800, Wei Yang wrote:
>To retrieve the PCI slot state, EEH driver would set a timeout for that.
>While current comment is not aligned to what the code does.
>
>This patch fixes those comments according to the code.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Please repost after https://patchwork.ozlabs.org/patch/439956/ shows up
in PPC next branch. The changes look good to me:

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/kernel/eeh_driver.c             |    2 +-
> arch/powerpc/platforms/powernv/eeh-powernv.c |    2 +-
> arch/powerpc/platforms/pseries/eeh_pseries.c |    2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>index d099540..cc8d1db 100644
>--- a/arch/powerpc/kernel/eeh_driver.c
>+++ b/arch/powerpc/kernel/eeh_driver.c
>@@ -682,7 +682,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
> 	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
>
> 	/* Get the current PCI slot state. This can take a long time,
>-	 * sometimes over 3 seconds for certain systems.
>+	 * sometimes over 300 seconds for certain systems.
> 	 */
> 	rc = eeh_ops->wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
> 	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>index 7a5021b..5abb4c2 100644
>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>@@ -313,7 +313,7 @@ static int powernv_eeh_reset(struct eeh_pe *pe, int option)
> /**
>  * powernv_eeh_wait_state - Wait for PE state
>  * @pe: EEH PE
>- * @max_wait: maximal period in microsecond
>+ * @max_wait: maximal period in millisecond
>  *
>  * Wait for the state of associated PE. It might take some time
>  * to retrieve the PE's state.
>diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>index a6c7e19..9de46c5 100644
>--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>@@ -538,7 +538,7 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
> /**
>  * pseries_eeh_wait_state - Wait for PE state
>  * @pe: EEH PE
>- * @max_wait: maximal period in microsecond
>+ * @max_wait: maximal period in millisecond
>  *
>  * Wait for the state of associated PE. It might take some time
>  * to retrieve the PE's state.
>-- 
>1.7.9.5
>
