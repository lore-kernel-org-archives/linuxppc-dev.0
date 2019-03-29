Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26CDC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 04:53:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9BF217F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 04:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9BF217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vq9y0yz3zDqPZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:53:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vq8G3zD2zDqQk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 15:51:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Vq8G13yBz8tRS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 15:51:42 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Vq8G0Vx4z9sQm; Fri, 29 Mar 2019 15:51:42 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Vq8F2w67z9sP4
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 15:51:40 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2T4i1pU023998
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 00:51:38 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rhass4296-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 00:51:38 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 29 Mar 2019 04:51:37 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Mar 2019 04:51:34 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2T4pXG738994106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Mar 2019 04:51:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCDB2AE05D;
 Fri, 29 Mar 2019 04:51:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31B66AE04D;
 Fri, 29 Mar 2019 04:51:33 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Mar 2019 04:51:33 +0000 (GMT)
Received: from [9.102.42.87] (unknown [9.102.42.87])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C5CE5A0206;
 Fri, 29 Mar 2019 15:51:31 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/xmon: add read-only mode
To: cmr <cmr@informatik.wtf>, linuxppc-dev@ozlabs.org
References: <20190329042153.25698-1-cmr@informatik.wtf>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 29 Mar 2019 15:49:32 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329042153.25698-1-cmr@informatik.wtf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032904-0008-0000-0000-000002D31429
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032904-0009-0000-0000-0000223F4C4D
Message-Id: <81765ce2-af34-6776-a5f6-f69d265cd3c2@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-29_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290035
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 29/3/19 3:21 pm, cmr wrote:
> Operations which write to memory should be restricted on secure systems
> and optionally to avoid self-destructive behaviors.

For reference:
  - https://github.com/linuxppc/issues/issues/219
  - https://github.com/linuxppc/issues/issues/232

Perhaps clarify what is meant here by "secure systems".

Otherwise commit message looks good.

> 
> Add a config option, XMON_RO, to control default xmon behavior along
> with kernel cmdline options xmon=ro and xmon=rw for explicit control.
> The default is to enable read-only mode.
> 
> The following xmon operations are affected:
> memops:
> 	disable memmove
> 	disable memset
> memex:
> 	no-op'd mwrite
> super_regs:
> 	no-op'd write_spr
> bpt_cmds:
> 	disable
> proc_call:
> 	disable
> 
> Signed-off-by: cmr <cmr@informatik.wtf>

You have a git config to fix :)

> ---
>   arch/powerpc/Kconfig.debug |  7 +++++++
>   arch/powerpc/xmon/xmon.c   | 24 ++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 4e00cb0a5464..33cc01adf4cb 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -117,6 +117,13 @@ config XMON_DISASSEMBLY
>   	  to say Y here, unless you're building for a memory-constrained
>   	  system.
>   
> +config XMON_RO
> +	bool "Set xmon read-only mode"
> +	depends on XMON
> +	default y
> +	help
> +	  Disable state- and memory-altering write operations in xmon.

The meaning of this option is a bit unclear.

 From the code - it looks like what this option actually does is enable 
RO mode *by default*. In which case it should probably be called 
XMON_RO_DEFAULT and the description should note that RW mode can still 
be enabled via a cmdline option.

> +
>   config DEBUGGER
>   	bool
>   	depends on KGDB || XMON
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index a0f44f992360..c13ee73cdfd4 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
>   #endif
>   static unsigned long in_xmon __read_mostly = 0;
>   static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
> +static int xmon_ro = IS_ENABLED(CONFIG_XMON_RO);
>   
>   static unsigned long adrs;
>   static int size = 1;
> @@ -1042,6 +1043,8 @@ cmds(struct pt_regs *excp)
>   			set_lpp_cmd();
>   			break;
>   		case 'b':
> +			if (xmon_ro == 1)
> +				break;

For all these cases - it would be much better to print an error message 
somewhere when we abort due to read-only mode.

>   			bpt_cmds();
>   			break;
>   		case 'C':
> @@ -1055,6 +1058,8 @@ cmds(struct pt_regs *excp)
>   			bootcmds();
>   			break;
>   		case 'p':
> +			if (xmon_ro == 1)
> +				break;
>   			proccall();
>   			break;
>   		case 'P':
> @@ -1777,6 +1782,9 @@ read_spr(int n, unsigned long *vp)
>   static void
>   write_spr(int n, unsigned long val)
>   {
> +	if (xmon_ro == 1)
> +		return;
> +
>   	if (setjmp(bus_error_jmp) == 0) {
>   		catch_spr_faults = 1;
>   		sync();
> @@ -2016,6 +2024,10 @@ mwrite(unsigned long adrs, void *buf, int size)
>   	char *p, *q;
>   
>   	n = 0;
> +
> +	if (xmon_ro == 1)
> +		return n;
> +
>   	if (setjmp(bus_error_jmp) == 0) {
>   		catch_memory_errors = 1;
>   		sync();
> @@ -2884,9 +2896,13 @@ memops(int cmd)
>   	scanhex((void *)&mcount);
>   	switch( cmd ){
>   	case 'm':
> +		if (xmon_ro == 1)
> +			break;
>   		memmove((void *)mdest, (void *)msrc, mcount);
>   		break;
>   	case 's':
> +		if (xmon_ro == 1)
> +			break;
>   		memset((void *)mdest, mval, mcount);
>   		break;
>   	case 'd':
> @@ -3796,6 +3812,14 @@ static int __init early_parse_xmon(char *p)
>   	} else if (strncmp(p, "on", 2) == 0) {
>   		xmon_init(1);
>   		xmon_on = 1;
> +	} else if (strncmp(p, "rw", 2) == 0) {
> +		xmon_init(1);
> +		xmon_on = 1;
> +		xmon_ro = 0;
> +	} else if (strncmp(p, "ro", 2) == 0) {
> +		xmon_init(1);
> +		xmon_on = 1;
> +		xmon_ro = 1;
>   	} else if (strncmp(p, "off", 3) == 0)
>   		xmon_on = 0;
>   	else
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

