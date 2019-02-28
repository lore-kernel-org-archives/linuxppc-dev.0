Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD780C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 05:06:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6833A2171F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 05:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6833A2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4490sC37VdzDqDs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 16:06:55 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4490pW3b0PzDqKh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 16:04:35 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1S53YAW005390
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 00:04:07 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qx8a69wb1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 00:04:07 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 28 Feb 2019 05:04:04 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Feb 2019 05:04:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1S541Mt17236026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Feb 2019 05:04:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 672F7AE058;
 Thu, 28 Feb 2019 05:04:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16B3FAE045;
 Thu, 28 Feb 2019 05:04:01 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Feb 2019 05:04:01 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BD9DAA025F;
 Thu, 28 Feb 2019 16:03:59 +1100 (AEDT)
Subject: Re: [PATCH 3/5] ocxl: read_pasid never returns an error, so make it
 void
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-4-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 28 Feb 2019 16:03:59 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227045741.21412-4-alastair@au1.ibm.com>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19022805-0028-0000-0000-0000034DF377
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022805-0029-0000-0000-0000240C4D35
Message-Id: <2f9993e1-eaad-263f-27eb-99175a34ff1f@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-28_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280034
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
 linux-kernel@vger.kernel.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 27/2/19 3:57 pm, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> No need for a return value in read_pasid as it only returns 0.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/ocxl/config.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index 0ee7856b033d..026ac2ac4f9c 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -68,7 +68,7 @@ static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
>   	return 0;
>   }
>   
> -static int read_pasid(struct pci_dev *dev, struct ocxl_fn_config *fn)
> +static void read_pasid(struct pci_dev *dev, struct ocxl_fn_config *fn)
>   {
>   	u16 val;
>   	int pos;
> @@ -89,7 +89,6 @@ static int read_pasid(struct pci_dev *dev, struct ocxl_fn_config *fn)
>   out:
>   	dev_dbg(&dev->dev, "PASID capability:\n");
>   	dev_dbg(&dev->dev, "  Max PASID log = %d\n", fn->max_pasid_log);
> -	return 0;
>   }
>   
>   static int read_dvsec_tl(struct pci_dev *dev, struct ocxl_fn_config *fn)
> @@ -205,11 +204,7 @@ int ocxl_config_read_function(struct pci_dev *dev, struct ocxl_fn_config *fn)
>   {
>   	int rc;
>   
> -	rc = read_pasid(dev, fn);
> -	if (rc) {
> -		dev_err(&dev->dev, "Invalid PASID configuration: %d\n", rc);
> -		return -ENODEV;
> -	}
> +	read_pasid(dev, fn);
>   
>   	rc = read_dvsec_tl(dev, fn);
>   	if (rc) {
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

