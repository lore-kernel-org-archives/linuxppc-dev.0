Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0712EC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 03:28:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E66C2075B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 03:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E66C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jrSQ2941zDqJY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 13:28:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jrQb5ZMPzDqC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 13:27:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44jrQb1qrdz8sxG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 13:27:19 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44jrQb1PJYz9s5c; Tue, 16 Apr 2019 13:27:19 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44jrQZ3NJCz9s00
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 13:27:17 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3G3PPmA016201
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2019 23:27:15 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rw121vf2k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2019 23:27:14 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 16 Apr 2019 04:27:12 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 04:27:08 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3G3R7fS51118148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 03:27:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA1594C04A;
 Tue, 16 Apr 2019 03:27:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17B074C040;
 Tue, 16 Apr 2019 03:27:07 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 03:27:07 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0426FA010A;
 Tue, 16 Apr 2019 13:27:05 +1000 (AEST)
Subject: Re: [PATCH v4] powerpc/xmon: add read-only mode
To: "Christopher M. Riedl" <cmr@informatik.wtf>, linuxppc-dev@ozlabs.org
References: <20190416032638.3588-1-cmr@informatik.wtf>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 16 Apr 2019 13:27:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416032638.3588-1-cmr@informatik.wtf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041603-0028-0000-0000-000003613614
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041603-0029-0000-0000-000024206B69
Message-Id: <58829b89-a589-db40-326f-e681f25b4aa0@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160022
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
Cc: oohall@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

On 16/4/19 1:26 pm, Christopher M. Riedl wrote:
> Operations which write to memory and special purpose registers should be
> restricted on systems with integrity guarantees (such as Secure Boot)
> and, optionally, to avoid self-destructive behaviors.
> 
> Add a config option, XMON_DEFAULT_RO_MODE, to set default xmon behavior.
> The kernel cmdline options xmon=ro and xmon=rw override this default.
> 
> The following xmon operations are affected:
> memops:
> 	disable memmove
> 	disable memset
> 	disable memzcan
> memex:
> 	no-op'd mwrite
> super_regs:
> 	no-op'd write_spr
> bpt_cmds:
> 	disable
> proc_call:
> 	disable
> 
> Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
> Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> 
> v3->v4:
> 	Address Andrew's nitpick.
> 
>   arch/powerpc/Kconfig.debug |  8 ++++++++
>   arch/powerpc/xmon/xmon.c   | 42 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 4e00cb0a5464..326ac5ea3f72 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -117,6 +117,14 @@ config XMON_DISASSEMBLY
>   	  to say Y here, unless you're building for a memory-constrained
>   	  system.
>   
> +config XMON_DEFAULT_RO_MODE
> +	bool "Restrict xmon to read-only operations by default"
> +	depends on XMON
> +	default y
> +	help
> +          Operate xmon in read-only mode. The cmdline options 'xmon=rw' and
> +          'xmon=ro' override this default.
> +
>   config DEBUGGER
>   	bool
>   	depends on KGDB || XMON
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index a0f44f992360..ce98c8049eb6 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
>   #endif
>   static unsigned long in_xmon __read_mostly = 0;
>   static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
> +static bool xmon_is_ro = IS_ENABLED(CONFIG_XMON_DEFAULT_RO_MODE);
>   
>   static unsigned long adrs;
>   static int size = 1;
> @@ -202,6 +203,8 @@ static void dump_tlb_book3e(void);
>   #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
>   #endif
>   
> +static const char *xmon_ro_msg = "Operation disabled: xmon in read-only mode\n";
> +
>   static char *help_string = "\
>   Commands:\n\
>     b	show breakpoints\n\
> @@ -989,6 +992,10 @@ cmds(struct pt_regs *excp)
>   				memlocate();
>   				break;
>   			case 'z':
> +				if (xmon_is_ro) {
> +					printf(xmon_ro_msg);
> +					break;
> +				}
>   				memzcan();
>   				break;
>   			case 'i':
> @@ -1042,6 +1049,10 @@ cmds(struct pt_regs *excp)
>   			set_lpp_cmd();
>   			break;
>   		case 'b':
> +			if (xmon_is_ro) {
> +				printf(xmon_ro_msg);
> +				break;
> +			}
>   			bpt_cmds();
>   			break;
>   		case 'C':
> @@ -1055,6 +1066,10 @@ cmds(struct pt_regs *excp)
>   			bootcmds();
>   			break;
>   		case 'p':
> +			if (xmon_is_ro) {
> +				printf(xmon_ro_msg);
> +				break;
> +			}
>   			proccall();
>   			break;
>   		case 'P':
> @@ -1777,6 +1792,11 @@ read_spr(int n, unsigned long *vp)
>   static void
>   write_spr(int n, unsigned long val)
>   {
> +	if (xmon_is_ro) {
> +		printf(xmon_ro_msg);
> +		return;
> +	}
> +
>   	if (setjmp(bus_error_jmp) == 0) {
>   		catch_spr_faults = 1;
>   		sync();
> @@ -2016,6 +2036,12 @@ mwrite(unsigned long adrs, void *buf, int size)
>   	char *p, *q;
>   
>   	n = 0;
> +
> +	if (xmon_is_ro) {
> +		printf(xmon_ro_msg);
> +		return n;
> +	}
> +
>   	if (setjmp(bus_error_jmp) == 0) {
>   		catch_memory_errors = 1;
>   		sync();
> @@ -2884,9 +2910,17 @@ memops(int cmd)
>   	scanhex((void *)&mcount);
>   	switch( cmd ){
>   	case 'm':
> +		if (xmon_is_ro) {
> +			printf(xmon_ro_msg);
> +			break;
> +		}
>   		memmove((void *)mdest, (void *)msrc, mcount);
>   		break;
>   	case 's':
> +		if (xmon_is_ro) {
> +			printf(xmon_ro_msg);
> +			break;
> +		}
>   		memset((void *)mdest, mval, mcount);
>   		break;
>   	case 'd':
> @@ -3796,6 +3830,14 @@ static int __init early_parse_xmon(char *p)
>   	} else if (strncmp(p, "on", 2) == 0) {
>   		xmon_init(1);
>   		xmon_on = 1;
> +	} else if (strncmp(p, "rw", 2) == 0) {
> +		xmon_init(1);
> +		xmon_on = 1;
> +		xmon_is_ro = false;
> +	} else if (strncmp(p, "ro", 2) == 0) {
> +		xmon_init(1);
> +		xmon_on = 1;
> +		xmon_is_ro = true;
>   	} else if (strncmp(p, "off", 3) == 0)
>   		xmon_on = 0;
>   	else
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

