Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E986C10F14
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 11:37:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4565206BA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 11:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4565206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gbTv0N0czDqTk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 21:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=john.garry@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
X-Greylist: delayed 920 seconds by postgrey-1.36 at bilbo;
 Fri, 12 Apr 2019 20:42:58 AEST
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gZH60pmdzDqTL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 20:42:54 +1000 (AEST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id DA38F622108C275A13F2;
 Fri, 12 Apr 2019 18:27:26 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0;
 Fri, 12 Apr 2019 18:27:14 +0800
Subject: Re: [PATCH v5 1/6] iommu: add generic boot option iommu.dma_mode
To: Zhen Lei <thunder.leizhen@huawei.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, "Will
 Deacon" <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Sebastian Ott
 <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 "Martin Schwidefsky" <schwidefsky@de.ibm.com>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu
 <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin"
 <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>,
 linux-ia64 <linux-ia64@vger.kernel.org>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
 <20190409125308.18304-2-thunder.leizhen@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <010d3cbd-ef74-ad21-c735-0af8b18955e6@huawei.com>
Date: Fri, 12 Apr 2019 11:26:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190409125308.18304-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 12 Apr 2019 21:35:41 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Hanjun Guo <guohanjun@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 09/04/2019 13:53, Zhen Lei wrote:
> Currently the IOMMU dma contains 3 modes: passthrough, lazy, strict. The
> passthrough mode bypass the IOMMU, the lazy mode defer the invalidation
> of hardware TLBs, and the strict mode invalidate IOMMU hardware TLBs
> synchronously. The three modes are mutually exclusive. But the current
> boot options are confused, such as: iommu.passthrough and iommu.strict,
> because they are no good to be coexist. So add iommu.dma_mode.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 19 ++++++++
>  drivers/iommu/iommu.c                           | 59 ++++++++++++++++++++-----
>  include/linux/iommu.h                           |  5 +++
>  3 files changed, 71 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2b8ee90bb64470d..f7766f8ac8b9084 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1811,6 +1811,25 @@
>  			1 - Bypass the IOMMU for DMA.
>  			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>
> +	iommu.dma_mode= Configure default dma mode. if unset, use the value
> +			of CONFIG_IOMMU_DEFAULT_PASSTHROUGH to determine
> +			passthrough or not.

To me, for unset it's unclear what we default to. So if unset and also 
CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set, do we get lazy or strict 
mode? (note: I'm ignoring backwards compatibility and interaction of 
iommu.strict and .passthorugh also, more below).

Could we considering introducing config DEFAULT_IOMMU_DMA_MODE, similar 
to DEFAULT_IOSCHED?

> +			Note: For historical reasons, ARM64/S390/PPC/X86 have
> +			their specific options. Currently, only ARM64 support
> +			this boot option, and hope other ARCHs to use this as
> +			generic boot option.
> +		passthrough
> +			Configure DMA to bypass the IOMMU by default.
> +		lazy
> +			Request that DMA unmap operations use deferred
> +			invalidation of hardware TLBs, for increased
> +			throughput at the cost of reduced device isolation.
> +			Will fall back to strict mode if not supported by
> +			the relevant IOMMU driver.
> +		strict
> +			DMA unmap operations invalidate IOMMU hardware TLBs
> +			synchronously.
> +
>  	io7=		[HW] IO7 for Marvel based alpha systems
>  			See comment before marvel_specify_io7 in
>  			arch/alpha/kernel/core_marvel.c.
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 109de67d5d727c2..df1ce8e22385b48 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -38,12 +38,13 @@
>
>  static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
> +
>  #ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
> -static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
> +#define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_PASSTHROUGH
>  #else
> -static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
> +#define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_STRICT
>  #endif
> -static bool iommu_dma_strict __read_mostly = true;
> +static int iommu_default_dma_mode __read_mostly = IOMMU_DEFAULT_DMA_MODE;
>
>  struct iommu_callback_data {
>  	const struct iommu_ops *ops;
> @@ -147,20 +148,51 @@ static int __init iommu_set_def_domain_type(char *str)
>  	int ret;
>
>  	ret = kstrtobool(str, &pt);
> -	if (ret)
> -		return ret;
> +	if (!ret && pt)
> +		iommu_default_dma_mode = IOMMU_DMA_MODE_PASSTHROUGH;
>
> -	iommu_def_domain_type = pt ? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
> -	return 0;
> +	return ret;
>  }
>  early_param("iommu.passthrough", iommu_set_def_domain_type);
>
>  static int __init iommu_dma_setup(char *str)
>  {
> -	return kstrtobool(str, &iommu_dma_strict);
> +	bool strict;
> +	int ret;
> +
> +	ret = kstrtobool(str, &strict);
> +	if (!ret)
> +		iommu_default_dma_mode = strict ?
> +				IOMMU_DMA_MODE_STRICT : IOMMU_DMA_MODE_LAZY;
> +
> +	return ret;
>  }
>  early_param("iommu.strict", iommu_dma_setup);
>
> +static int __init iommu_dma_mode_setup(char *str)
> +{
> +	if (!str)
> +		goto fail;
> +
> +	if (!strncmp(str, "passthrough", 11))
> +		iommu_default_dma_mode = IOMMU_DMA_MODE_PASSTHROUGH;
> +	else if (!strncmp(str, "lazy", 4))
> +		iommu_default_dma_mode = IOMMU_DMA_MODE_LAZY;
> +	else if (!strncmp(str, "strict", 6))
> +		iommu_default_dma_mode = IOMMU_DMA_MODE_STRICT;
> +	else
> +		goto fail;
> +
> +	pr_info("Force dma mode to be %d\n", iommu_default_dma_mode);

What happens if the cmdline option iommu.dma_mode is passed multiple 
times? We get mutliple - possibily conflicting - prints, right?

And do we need to have backwards compatibility, such that the setting 
for iommu.strict or iommu.passthrough trumps iommu.dma_mode, regardless 
of order?

> +
> +	return 0;
> +
> +fail:
> +	pr_debug("Boot option iommu.dma_mode is incorrect, ignored\n");
> +	return -EINVAL;
> +}
> +early_param("iommu.dma_mode", iommu_dma_mode_setup);
> +
>  static ssize_t iommu_group_attr_show(struct kobject *kobj,
>  				     struct attribute *__attr, char *buf)
>  {
> @@ -1102,14 +1134,17 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>  	 */
>  	if (!group->default_domain) {
>  		struct iommu_domain *dom;
> +		int def_domain_type =
> +			(iommu_default_dma_mode == IOMMU_DMA_MODE_PASSTHROUGH)
> +			? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
>
> -		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
> -		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
> +		dom = __iommu_domain_alloc(dev->bus, def_domain_type);
> +		if (!dom && def_domain_type != IOMMU_DOMAIN_DMA) {
>  			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
>  			if (dom) {
>  				dev_warn(dev,
>  					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
> -					 iommu_def_domain_type);
> +					 def_domain_type);
>  			}
>  		}
>
> @@ -1117,7 +1152,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>  		if (!group->domain)
>  			group->domain = dom;
>
> -		if (dom && !iommu_dma_strict) {
> +		if (dom && (iommu_default_dma_mode == IOMMU_DMA_MODE_LAZY)) {
>  			int attr = 1;
>  			iommu_domain_set_attr(dom,
>  					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ffbbc7e39ceeba3..c3f4e3416176496 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -42,6 +42,11 @@
>   */
>  #define IOMMU_PRIV	(1 << 5)
>
> +
> +#define IOMMU_DMA_MODE_STRICT		0x0
> +#define IOMMU_DMA_MODE_LAZY		0x1
> +#define IOMMU_DMA_MODE_PASSTHROUGH	0x2
> +
>  struct iommu_ops;
>  struct iommu_group;
>  struct bus_type;
>


