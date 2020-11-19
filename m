Return-Path: <SRS0=HG9l=EZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14B8C388F9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 09:45:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA70246BB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 09:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YVP8tPXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA70246BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CcFCT3h8lzDqnV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 20:45:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ljp@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=YVP8tPXJ; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CcF9k36mHzDqd9;
 Thu, 19 Nov 2020 20:43:38 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AJ9XOVO046850; Thu, 19 Nov 2020 04:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=DETla2P0bMOshP3ToLQ7nRIRlzdfwifxmy327xXRyrM=;
 b=YVP8tPXJ4ll6p0k9+xgCRKFWEeKh1XYC+b6zj79BU/Ofktda3pMPkSUkgbOWfsTrSYG0
 641DTc7ilnW53HiUWQugSbr+XCYUhV+b1fNyqfghJxe51OU892a2MlD526paWRcLbss3
 yK66A3z6jiVIygvjWLkDyVbOe+CBRXm+1SXJ6J0WRyLG6lva5jroLfCXVlr3qliJlWIO
 W4VikgIGkn5xQv3gSAbaxPikVvRm4pCnVkT44Fou6Qy2vdhtMVeNxl9G7z34sbDtnFds
 6/JVQCKuIhC8mxbb5506EXeH4XPbSsDNHOsqJR5lQ6S1el56XbwsVEp8HbECvryIvOqs FQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34wg661hyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2020 04:43:34 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ9SCWu002859;
 Thu, 19 Nov 2020 09:43:33 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma01wdc.us.ibm.com with ESMTP id 34uyn1m02h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2020 09:43:32 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0AJ9hVfB17891634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2020 09:43:31 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A24D7C6059;
 Thu, 19 Nov 2020 09:43:31 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C3FEC6057;
 Thu, 19 Nov 2020 09:43:31 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2020 09:43:31 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 19 Nov 2020 03:43:31 -0600
From: ljp <ljp@linux.vnet.ibm.com>
To: Thomas Falcon <tlfalcon@linux.ibm.com>
Subject: Re: [PATCH net-next v2 9/9] ibmvnic: Do not replenish RX buffers
 after every polling loop
In-Reply-To: <1605748345-32062-10-git-send-email-tlfalcon@linux.ibm.com>
References: <1605748345-32062-1-git-send-email-tlfalcon@linux.ibm.com>
 <1605748345-32062-10-git-send-email-tlfalcon@linux.ibm.com>
Message-ID: <1a4e7b1ef1fb101cbb26fb9d5867ee46@linux.vnet.ibm.com>
X-Sender: ljp@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-19_05:2020-11-17,
 2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=782
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190069
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
Cc: cforno12@linux.ibm.com, netdev@vger.kernel.org, ricklind@linux.ibm.com,
 dnbanerg@us.ibm.com,
 Linuxppc-dev <linuxppc-dev-bounces+ljp=linux.ibm.com@lists.ozlabs.org>,
 drt@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, kuba@kernel.org,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2020-11-18 19:12, Thomas Falcon wrote:
> From: "Dwip N. Banerjee" <dnbanerg@us.ibm.com>
> 
> Reduce the amount of time spent replenishing RX buffers by
> only doing so once available buffers has fallen under a certain
> threshold, in this case half of the total number of buffers, or
> if the polling loop exits before the packets processed is less
> than its budget.
> 
> Signed-off-by: Dwip N. Banerjee <dnbanerg@us.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c
> b/drivers/net/ethernet/ibm/ibmvnic.c
> index 96df6d8fa277..9fe43ab0496d 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2537,7 +2537,10 @@ static int ibmvnic_poll(struct napi_struct
> *napi, int budget)
>  		frames_processed++;
>  	}
> 
> -	if (adapter->state != VNIC_CLOSING)
> +	if (adapter->state != VNIC_CLOSING &&
> +	    ((atomic_read(&adapter->rx_pool[scrq_num].available) <
> +	      adapter->req_rx_add_entries_per_subcrq / 2) ||
> +	      frames_processed < budget))

1/2 seems a simple and good algorithm.
Explaining why "frames_process < budget" is necessary in the commit 
message
or source code also helps.


>  		replenish_rx_pool(adapter, &adapter->rx_pool[scrq_num]);
>  	if (frames_processed < budget) {
>  		if (napi_complete_done(napi, frames_processed)) {
