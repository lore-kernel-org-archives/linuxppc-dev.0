Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgpwM0Z32zDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 18:09:22 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6184HEF039833
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 04:09:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23whjc5r44-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 04:09:20 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 09:09:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C557417D805D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 09:10:36 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6189FQC852390
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 08:09:15 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6189E51025820
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 02:09:15 -0600
Subject: Re: [PATCH v2] cxl: Fix bug where AFU disable operation had no effect
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
 <1467305440-23492-1-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 1 Jul 2016 10:09:12 +0200
MIME-Version: 1.0
In-Reply-To: <1467305440-23492-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57762528.3040104@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It looks good to me. I can live with the extra 'clear' parameter, 
because as you say, the approach I had suggested would require more 
testing, so let's play safe for the time being.
And thanks for clarifying/fixing the deactivate paths.

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred


Le 30/06/2016 18:50, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The AFU disable operation has a bug where it will not clear the enable
> bit and therefore will have no effect. To date this has likely been
> masked by fact that we perform an AFU reset before the disable, which
> also has the effect of clearing the enable bit, making the following
> disable operation effectively a noop on most hardware. This patch
> modifies the afu_control function to take a parameter to clear from the
> AFU control register so that the disable operation can clear the
> appropriate bit.
>
> This bug was uncovered on the Mellanox CX4, which uses an XSL rather
> than a PSL. On the XSL the reset operation will not complete while the
> AFU is enabled, meaning the enable bit was still set at the start of the
> disable and as a result this bug was hit and the disable also timed out.
>
> Because of this difference in behaviour between the PSL and XSL, this
> patch now makes the reset dependent on the card using a PSL to avoid
> waiting for a timeout on the XSL. It is entirely possible that we may be
> able to drop the reset altogether if it turns out we only ever needed it
> due to this bug - however I am not willing to drop it without further
> regression testing and have added comments to the code explaining the
> background.
>
> This also fixes a small issue where the AFU_Cntl register was read
> outside of the lock that protects it.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
> Changes since v1:
> 	- Modified comment to dedicated process disable path to explain
> 	  the architected procedure, and the origin of our more heavy weight
> 	  procedure.
> 	- Modified comment to afu directed disable path with a note that the
> 	  procedure is AFU specific, and explaining the origin of our heavy
> 	  weight prcedure.
> 	- Removed needs_reset_before_disable condition from dedicated process
> 	  disable path. The XSL in the CX4 does not use this mode (AFU directed
> 	  only), and since the reset in this procedure is architected we
> 	  *should* never need to skip it.
>
>   drivers/misc/cxl/cxl.h    |  1 +
>   drivers/misc/cxl/native.c | 58 +++++++++++++++++++++++++++++++++++++++++------
>   drivers/misc/cxl/pci.c    |  1 +
>   3 files changed, 53 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index ce2b9d5..bab8dfd 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -544,6 +544,7 @@ struct cxl_service_layer_ops {
>   	void (*write_timebase_ctrl)(struct cxl *adapter);
>   	u64 (*timebase_read)(struct cxl *adapter);
>   	int capi_mode;
> +	bool needs_reset_before_disable;
>   };
>
>   struct cxl_native {
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 120c468..e774505 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -21,10 +21,10 @@
>   #include "cxl.h"
>   #include "trace.h"
>
> -static int afu_control(struct cxl_afu *afu, u64 command,
> +static int afu_control(struct cxl_afu *afu, u64 command, u64 clear,
>   		       u64 result, u64 mask, bool enabled)
>   {
> -	u64 AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> +	u64 AFU_Cntl;
>   	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
>   	int rc = 0;
>
> @@ -33,7 +33,8 @@ static int afu_control(struct cxl_afu *afu, u64 command,
>
>   	trace_cxl_afu_ctrl(afu, command);
>
> -	cxl_p2n_write(afu, CXL_AFU_Cntl_An, AFU_Cntl | command);
> +	AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> +	cxl_p2n_write(afu, CXL_AFU_Cntl_An, (AFU_Cntl & ~clear) | command);
>
>   	AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
>   	while ((AFU_Cntl & mask) != result) {
> @@ -67,7 +68,7 @@ static int afu_enable(struct cxl_afu *afu)
>   {
>   	pr_devel("AFU enable request\n");
>
> -	return afu_control(afu, CXL_AFU_Cntl_An_E,
> +	return afu_control(afu, CXL_AFU_Cntl_An_E, 0,
>   			   CXL_AFU_Cntl_An_ES_Enabled,
>   			   CXL_AFU_Cntl_An_ES_MASK, true);
>   }
> @@ -76,7 +77,8 @@ int cxl_afu_disable(struct cxl_afu *afu)
>   {
>   	pr_devel("AFU disable request\n");
>
> -	return afu_control(afu, 0, CXL_AFU_Cntl_An_ES_Disabled,
> +	return afu_control(afu, 0, CXL_AFU_Cntl_An_E,
> +			   CXL_AFU_Cntl_An_ES_Disabled,
>   			   CXL_AFU_Cntl_An_ES_MASK, false);
>   }
>
> @@ -85,7 +87,7 @@ static int native_afu_reset(struct cxl_afu *afu)
>   {
>   	pr_devel("AFU reset request\n");
>
> -	return afu_control(afu, CXL_AFU_Cntl_An_RA,
> +	return afu_control(afu, CXL_AFU_Cntl_An_RA, 0,
>   			   CXL_AFU_Cntl_An_RS_Complete | CXL_AFU_Cntl_An_ES_Disabled,
>   			   CXL_AFU_Cntl_An_RS_MASK | CXL_AFU_Cntl_An_ES_MASK,
>   			   false);
> @@ -595,7 +597,33 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
>   	cxl_sysfs_afu_m_remove(afu);
>   	cxl_chardev_afu_remove(afu);
>
> -	cxl_ops->afu_reset(afu);
> +	/*
> +	 * The CAIA section 2.2.1 indicates that the procedure for starting and
> +	 * stopping an AFU in AFU directed mode is AFU specific, which is not
> +	 * ideal since this code is generic and with one exception has no
> +	 * knowledge of the AFU. This is in contrast to the procedure for
> +	 * disabling a dedicated process AFU, which is documented to just
> +	 * require a reset. The architecture does indicate that both an AFU
> +	 * reset and an AFU disable should result in the AFU being disabled and
> +	 * we do both followed by a PSL purge for safety.
> +	 *
> +	 * Notably we used to have some issues with the disable sequence on PSL
> +	 * cards, which is why we ended up using this heavy weight procedure in
> +	 * the first place, however a bug was discovered that had rendered the
> +	 * disable operation ineffective, so it is conceivable that was the
> +	 * sole explanation for those difficulties. Careful regression testing
> +	 * is recommended if anyone attempts to remove or reorder these
> +	 * operations.
> +	 *
> +	 * The XSL on the Mellanox CX4 behaves a little differently from the
> +	 * PSL based cards and will time out an AFU reset if the AFU is still
> +	 * enabled. That card is special in that we do have a means to identify
> +	 * it from this code, so in that case we skip the reset and just use a
> +	 * disable/purge to avoid the timeout and corresponding noise in the
> +	 * kernel log.
> +	 */
> +	if (afu->adapter->native->sl_ops->needs_reset_before_disable)
> +		cxl_ops->afu_reset(afu);
>   	cxl_afu_disable(afu);
>   	cxl_psl_purge(afu);
>
> @@ -735,6 +763,22 @@ static int native_attach_process(struct cxl_context *ctx, bool kernel,
>
>   static inline int detach_process_native_dedicated(struct cxl_context *ctx)
>   {
> +	/*
> +	 * The CAIA section 2.1.1 indicates that we need to do an AFU reset to
> +	 * stop the AFU in dedicated mode (we therefore do not make that
> +	 * optional like we do in the afu directed path). It does not indicate
> +	 * that we need to do an explicit disable (which should occur
> +	 * implicitly as part of the reset) or purge, but we do these as well
> +	 * to be on the safe side.
> +	 *
> +	 * Notably we used to have some issues with the disable sequence
> +	 * (before the sequence was spelled out in the architecture) which is
> +	 * why we were so heavy weight in the first place, however a bug was
> +	 * discovered that had rendered the disable operation ineffective, so
> +	 * it is conceivable that was the sole explanation for those
> +	 * difficulties. Point is, we should be careful and do some regression
> +	 * testing if we ever attempt to remove any part of this procedure.
> +	 */
>   	cxl_ops->afu_reset(ctx->afu);
>   	cxl_afu_disable(ctx->afu);
>   	cxl_psl_purge(ctx->afu);
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 58d7d821..b7f2e96 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1309,6 +1309,7 @@ static const struct cxl_service_layer_ops psl_ops = {
>   	.write_timebase_ctrl = write_timebase_ctrl_psl,
>   	.timebase_read = timebase_read_psl,
>   	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
> +	.needs_reset_before_disable = true,
>   };
>
>   static const struct cxl_service_layer_ops xsl_ops = {
>
