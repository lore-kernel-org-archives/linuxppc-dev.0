Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D064DC433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 13:31:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EB62072E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 13:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sC4ib1q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EB62072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsdCL1tJPzDqZW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 23:31:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=rcardoso@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=sC4ib1q4; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bsd540Kb5zDqZF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 23:25:43 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08HD2sQZ088902; Thu, 17 Sep 2020 09:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wmOzpjGG1h2Oq7Ir2GbzRIjQQIyrtaS+Bel/vK91xI0=;
 b=sC4ib1q4eMwT34d/lTDP0VzNmoCxlDn+bZunq61KViNMpmCpi5i1DzhvgoDa2cr90RfT
 dZGjljZ6JQx2dODyh4ENX93cv7i+LPZU7jRFDfzM71fA5VrJL3ZJcaDV/fjrgsvT1bzw
 9jTkVkcJ3jwRsIfMFsTnycTCJckLHRx9M6GDv41a6fXsiUdogflXiSMUX9wfaXA79Shq
 fQc1I7V1riO9Vif6MqxyxsuemVehpnAlr4CYmSYpLAv5Se0f0WB6F6bOecym7MDmCMiZ
 K68Lwz8m0ap7Rk9nR5eDDhd5YhsZWbhKjoz2VVVTv5+6yI3N9av5dMJJc8fPIeqSZLER 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33m86sh5g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 09:25:32 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HD39K5090326;
 Thu, 17 Sep 2020 09:25:31 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33m86sh5ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 09:25:31 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HDMdgl008441;
 Thu, 17 Sep 2020 13:25:30 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 33k5v20xdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 13:25:30 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08HDPTLY45351318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2020 13:25:29 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FEA2AE063;
 Thu, 17 Sep 2020 13:25:29 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A74EAE060;
 Thu, 17 Sep 2020 13:25:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.95.89])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2020 13:25:25 +0000 (GMT)
Subject: Re: [PATCH v6 1/8] powerpc/watchpoint: Fix quarword instruction
 handling on p10 predecessors
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
 christophe.leroy@c-s.fr
References: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
 <20200902042945.129369-2-ravi.bangoria@linux.ibm.com>
From: Rogerio Alves <rcardoso@linux.ibm.com>
Message-ID: <4522c423-c020-3abc-8db6-acdc2a095d21@linux.ibm.com>
Date: Thu, 17 Sep 2020 10:25:24 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902042945.129369-2-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-17_09:2020-09-16,
 2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170098
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
Cc: mikey@neuling.org, jniethe5@gmail.com, pedromfc@linux.ibm.com,
 linux-kernel@vger.kernel.org, paulus@samba.org, rogealve@linux.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 9/2/20 1:29 AM, Ravi Bangoria wrote:
> On p10 predecessors, watchpoint with quarword access is compared at
> quardword length. If the watch range is doubleword or less than that
> in a first half of quarword aligned 16 bytes, and if there is any
> unaligned quadword access which will access only the 2nd half, the
> handler should consider it as extraneous and emulate/single-step it
> before continuing.
> 
> Reported-by: Pedro Miraglia Franco de Carvalho <pedromfc@linux.ibm.com>
> Fixes: 74c6881019b7 ("powerpc/watchpoint: Prepare handler to handle more than one watchpoint")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Rogerio Alves <rcardoso@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_breakpoint.h |  1 +
>   arch/powerpc/kernel/hw_breakpoint.c      | 12 ++++++++++--
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> index db206a7f38e2..9b68eafebf43 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -42,6 +42,7 @@ struct arch_hw_breakpoint {
>   #else
>   #define HW_BREAKPOINT_SIZE  0x8
>   #endif
> +#define HW_BREAKPOINT_SIZE_QUADWORD	0x10
>   
>   #define DABR_MAX_LEN	8
>   #define DAWR_MAX_LEN	512
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 1f4a1efa0074..9f7df1c37233 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -520,9 +520,17 @@ static bool ea_hw_range_overlaps(unsigned long ea, int size,
>   				 struct arch_hw_breakpoint *info)
>   {
>   	unsigned long hw_start_addr, hw_end_addr;
> +	unsigned long align_size = HW_BREAKPOINT_SIZE;
>   
> -	hw_start_addr = ALIGN_DOWN(info->address, HW_BREAKPOINT_SIZE);
> -	hw_end_addr = ALIGN(info->address + info->len, HW_BREAKPOINT_SIZE);
> +	/*
> +	 * On p10 predecessors, quadword is handle differently then
> +	 * other instructions.
> +	 */
> +	if (!cpu_has_feature(CPU_FTR_ARCH_31) && size == 16)
> +		align_size = HW_BREAKPOINT_SIZE_QUADWORD;
> +
> +	hw_start_addr = ALIGN_DOWN(info->address, align_size);
> +	hw_end_addr = ALIGN(info->address + info->len, align_size);
>   
>   	return ((ea < hw_end_addr) && (ea + size > hw_start_addr));
>   }
> 
