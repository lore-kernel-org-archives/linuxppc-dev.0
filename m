Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5834C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 23:18:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E342C20866
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 23:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E342C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XWcn4jktzDqNb
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:18:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XWb01Cm4zDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 10:17:15 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2VNDX4g072664
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 19:17:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rk152j311-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 19:17:12 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 1 Apr 2019 00:17:10 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Apr 2019 00:17:06 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2VNH5qG49742042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 31 Mar 2019 23:17:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CCB311C04C;
 Sun, 31 Mar 2019 23:17:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28AE011C050;
 Sun, 31 Mar 2019 23:17:05 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 31 Mar 2019 23:17:05 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 00F9CA01D7;
 Mon,  1 Apr 2019 10:17:01 +1100 (AEDT)
Subject: Re: [PATCH -next] ocxl: remove set but not used variables 'tid' and
 'lpid'
To: Yue Haibing <yuehaibing@huawei.com>, fbarrat@linux.ibm.com, arnd@arndb.de, 
 gregkh@linuxfoundation.org
References: <20190329154456.27152-1-yuehaibing@huawei.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 1 Apr 2019 10:16:58 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329154456.27152-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19033123-0012-0000-0000-000003098669
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19033123-0013-0000-0000-00002140C189
Message-Id: <481699cc-ffc8-4322-31c2-8a18b0b36da7@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-31_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=937 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903310176
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 30/3/19 2:44 am, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/misc/ocxl/link.c: In function 'xsl_fault_handler':
> drivers/misc/ocxl/link.c:187:17: warning: variable 'tid' set but not used [-Wunused-but-set-variable]
> drivers/misc/ocxl/link.c:187:6: warning: variable 'lpid' set but not used [-Wunused-but-set-variable]
> 
> They are never used and can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/ocxl/link.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index d50b861..3be07e9 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -184,7 +184,7 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
>   	u64 dsisr, dar, pe_handle;
>   	struct pe_data *pe_data;
>   	struct ocxl_process_element *pe;
> -	int lpid, pid, tid;
> +	int pid;
>   	bool schedule = false;
>   
>   	read_irq(spa, &dsisr, &dar, &pe_handle);
> @@ -192,9 +192,7 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
>   
>   	WARN_ON(pe_handle > SPA_PE_MASK);
>   	pe = spa->spa_mem + pe_handle;
> -	lpid = be32_to_cpu(pe->lpid);
>   	pid = be32_to_cpu(pe->pid);
> -	tid = be32_to_cpu(pe->tid);
>   	/* We could be reading all null values here if the PE is being
>   	 * removed while an interrupt kicks in. It's not supposed to
>   	 * happen if the driver notified the AFU to terminate the
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

