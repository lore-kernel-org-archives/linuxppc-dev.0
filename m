Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZ5cZ1Z73zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 20:50:38 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Mar 2016 19:50:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 151702BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 20:50:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2T9oNli66584738
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 20:50:31 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2T9nx1Y003034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 20:49:59 +1100
Date: Tue, 29 Mar 2016 20:49:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 2/2] pseries/eeh: Handle RTAS delay requests in
 configure_bridge
Message-ID: <20160329094936.GB10585@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
 <1459219911-14110-2-git-send-email-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459219911-14110-2-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 29, 2016 at 12:51:51PM +1000, Russell Currey wrote:
>In the configure_pe and configure_bridge RTAS calls, the spec states
>that values of 9900-9905 can be returned, indicating that software
>should delay for 10^x (where x is the last digit, i.e. 990x)
>milliseconds and attempt the call again. Currently, the kernel doesn't
>know about this, and respecting it fixes some PCI failures when the
>hypervisor is busy.
>
>The delay is capped at 0.2 seconds.
>

When talking about RTAS calls, it might be better to have their full
names defined in PAPR spec. So I guess it'd better to replace configure_pe
and configure_bridge with their corresponding full RTAS call names:
"ibm,configure-pe" and "ibm,configure-bridge".

>Cc: <stable@vger.kernel.org> # 3.10-

I think it would be #3.10+.

>Signed-off-by: Russell Currey <ruscur@russell.cc>
>---
>V2: Use rtas_busy_delay and the new ibm_configure_pe token, refactoring
>---
> arch/powerpc/platforms/pseries/eeh_pseries.c | 35 +++++++++++++++++++++++-----
> 1 file changed, 29 insertions(+), 6 deletions(-)
>
>diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>index 231b1df..c442b11 100644
>--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>@@ -619,20 +619,43 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
> {
> 	int config_addr;
> 	int ret;
>+	/* Waiting 0.2s maximum before skipping configuration */
>+	int max_wait = 200;
>+	int mwait;
> 
> 	/* Figure out the PE address */
> 	config_addr = pe->config_addr;
> 	if (pe->addr)
> 		config_addr = pe->addr;
> 
>-	ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
>-			config_addr, BUID_HI(pe->phb->buid),
>-			BUID_LO(pe->phb->buid));
>+	while (max_wait > 0) {
>+		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
>+				config_addr, BUID_HI(pe->phb->buid),
>+				BUID_LO(pe->phb->buid));
> 
>-	if (ret)
>-		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
>-			__func__, pe->phb->global_number, pe->addr, ret);
>+		/*
>+		 * RTAS can return a delay value of up to 10^5 milliseconds
>+		 * (RTAS_EXTENDED_DELAY_MAX), which is too long.  Only respect
>+		 * the delay if it's 100ms or less.
>+		 */
> 

The PAPR spec states that the delay can be up to 10^5ms. The spec also suggests
the maximal delay is 10^2. I guess it's worthy to mention it in the above comments
if you like.

>+		switch (ret) {
>+		case 0:
>+			return ret;
>+		case RTAS_EXTENDED_DELAY_MIN:
>+		case RTAS_EXTENDED_DELAY_MIN+1:
>+		case RTAS_EXTENDED_DELAY_MIN+2:
>+			mwait = rtas_busy_delay(ret);
>+			break;
>+		default:
>+			goto err;
>+		}
>+
>+		max_wait -= mwait;

If you like, the block can be simplified to as below. In that case,
tag #err isn't needed.

                if (!ret)
                        return ret;

                max_wait -= rtas_busy_delay(ret);

>+	}
>+err:
>+	pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
>+		__func__, pe->phb->global_number, pe->addr, ret);
> 	return ret;
> }
> 

Thanks,
Gavin
