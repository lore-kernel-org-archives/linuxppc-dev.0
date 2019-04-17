Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B7DC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 15:40:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F22C20674
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 15:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F22C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kmf44QRgzDqKj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:40:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kmXn69dXzDqNk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 01:35:53 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HFWNAC097102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 11:35:51 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rx4j37afh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 11:35:50 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 17 Apr 2019 16:35:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 16:35:44 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HFZhFD51052714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 15:35:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C98B42047;
 Wed, 17 Apr 2019 15:35:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B200842049;
 Wed, 17 Apr 2019 15:35:42 +0000 (GMT)
Received: from [9.145.35.200] (unknown [9.145.35.200])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 15:35:42 +0000 (GMT)
Subject: Re: [PATCH v4 7/7] ocxl: Provide global MMIO accessors for external
 drivers
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190327053137.15173-1-alastair@au1.ibm.com>
 <20190327053137.15173-8-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 17 Apr 2019 17:35:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327053137.15173-8-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041715-0008-0000-0000-000002DAE8E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041715-0009-0000-0000-000022472680
Message-Id: <aba561f2-dd6f-6bde-a551-3d37c835a8a1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170104
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greg Kurz <groug@kaod.org>,
 linux-kernel@vger.kernel.org, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 27/03/2019 à 06:31, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> External drivers that communicate via OpenCAPI will need to make
> MMIO calls to interact with the devices.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---


Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

And that's the final one! Thanks a lot Alastair, that took some effort, 
but I'm quite happy with the result.

   Fred



>   drivers/misc/ocxl/Makefile |   2 +-
>   drivers/misc/ocxl/mmio.c   | 234 +++++++++++++++++++++++++++++++++++++
>   include/misc/ocxl.h        | 110 +++++++++++++++++
>   3 files changed, 345 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/misc/ocxl/mmio.c
> 
> diff --git a/drivers/misc/ocxl/Makefile b/drivers/misc/ocxl/Makefile
> index bc4e39bfda7b..d07d1bb8e8d4 100644
> --- a/drivers/misc/ocxl/Makefile
> +++ b/drivers/misc/ocxl/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
>   
> -ocxl-y				+= main.o pci.o config.o file.o pasid.o
> +ocxl-y				+= main.o pci.o config.o file.o pasid.o mmio.o
>   ocxl-y				+= link.o context.o afu_irq.o sysfs.o trace.o
>   ocxl-y				+= core.o
>   obj-$(CONFIG_OCXL)		+= ocxl.o
> diff --git a/drivers/misc/ocxl/mmio.c b/drivers/misc/ocxl/mmio.c
> new file mode 100644
> index 000000000000..aae713db4ebe
> --- /dev/null
> +++ b/drivers/misc/ocxl/mmio.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2019 IBM Corp.
> +#include <linux/sched/mm.h>
> +#include "trace.h"
> +#include "ocxl_internal.h"
> +
> +int ocxl_global_mmio_read32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 *val)
> +{
> +	if (offset > afu->config.global_mmio_size - 4)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		*val = readl_be((char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		*val = readl((char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_read32);
> +
> +int ocxl_global_mmio_read64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 *val)
> +{
> +	if (offset > afu->config.global_mmio_size - 8)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		*val = readq_be((char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		*val = readq((char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_read64);
> +
> +int ocxl_global_mmio_write32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 val)
> +{
> +	if (offset > afu->config.global_mmio_size - 4)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		writel_be(val, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		writel(val, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_write32);
> +
> +int ocxl_global_mmio_write64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 val)
> +{
> +	if (offset > afu->config.global_mmio_size - 8)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		writeq_be(val, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		writeq(val, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_write64);
> +
> +int ocxl_global_mmio_set32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 mask)
> +{
> +	u32 tmp;
> +
> +	if (offset > afu->config.global_mmio_size - 4)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		tmp = readl_be((char *)afu->global_mmio_ptr + offset);
> +		tmp |= mask;
> +		writel_be(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		tmp = readl((char *)afu->global_mmio_ptr + offset);
> +		tmp |= mask;
> +		writel(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_set32);
> +
> +int ocxl_global_mmio_set64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 mask)
> +{
> +	u64 tmp;
> +
> +	if (offset > afu->config.global_mmio_size - 8)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		tmp = readq_be((char *)afu->global_mmio_ptr + offset);
> +		tmp |= mask;
> +		writeq_be(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		tmp = readq((char *)afu->global_mmio_ptr + offset);
> +		tmp |= mask;
> +		writeq(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_set64);
> +
> +int ocxl_global_mmio_clear32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 mask)
> +{
> +	u32 tmp;
> +
> +	if (offset > afu->config.global_mmio_size - 4)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		tmp = readl_be((char *)afu->global_mmio_ptr + offset);
> +		tmp &= ~mask;
> +		writel_be(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		tmp = readl((char *)afu->global_mmio_ptr + offset);
> +		tmp &= ~mask;
> +		writel(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_clear32);
> +
> +int ocxl_global_mmio_clear64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 mask)
> +{
> +	u64 tmp;
> +
> +	if (offset > afu->config.global_mmio_size - 8)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		tmp = readq_be((char *)afu->global_mmio_ptr + offset);
> +		tmp &= ~mask;
> +		writeq_be(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		tmp = readq((char *)afu->global_mmio_ptr + offset);
> +		tmp &= ~mask;
> +		writeq(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	writeq(tmp, (char *)afu->global_mmio_ptr + offset);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_clear64);
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index dea93885a839..5c4b4916e6be 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -45,6 +45,12 @@ struct ocxl_fn_config {
>   	s8 max_afu_index;
>   };
>   
> +enum ocxl_endian {
> +	OCXL_BIG_ENDIAN = 0,    /**< AFU data is big-endian */
> +	OCXL_LITTLE_ENDIAN = 1, /**< AFU data is little-endian */
> +	OCXL_HOST_ENDIAN = 2,   /**< AFU data is the same endianness as the host */
> +};
> +
>   // These are opaque outside the ocxl driver
>   struct ocxl_afu;
>   struct ocxl_fn;
> @@ -230,6 +236,110 @@ void ocxl_afu_set_private(struct ocxl_afu *afu, void *private);
>    */
>   void *ocxl_afu_get_private(struct ocxl_afu *dev);
>   
> +// Global MMIO
> +/**
> + * Read a 32 bit value from global MMIO
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @val: returns the value
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_read32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 *val);
> +
> +/**
> + * Read a 64 bit value from global MMIO
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @val: returns the value
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_read64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 *val);
> +
> +/**
> + * Write a 32 bit value to global MMIO
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @val: The value to write
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_write32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 val);
> +
> +/**
> + * Write a 64 bit value to global MMIO
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @val: The value to write
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_write64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 val);
> +
> +/**
> + * Set bits in a 32 bit global MMIO register
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @mask: a mask of the bits to set
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_set32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 mask);
> +
> +/**
> + * Set bits in a 64 bit global MMIO register
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @mask: a mask of the bits to set
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_set64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 mask);
> +
> +/**
> + * Set bits in a 32 bit global MMIO register
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @mask: a mask of the bits to set
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_clear32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 mask);
> +
> +/**
> + * Set bits in a 64 bit global MMIO register
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @mask: a mask of the bits to set
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_clear64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 mask);
>   
>   // Functions left here are for compatibility with the cxlflash driver
>   
> 

