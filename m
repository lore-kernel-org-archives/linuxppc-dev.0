Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946ECC282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 06:40:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14392084F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 06:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14392084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44d15B5z9TzDqCY
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 16:40:30 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d11b5rVjzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 16:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44d11b4F5mz8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 16:37:23 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44d11b3j38z9sQr; Mon,  8 Apr 2019 16:37:23 +1000 (AEST)
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
 by ozlabs.org (Postfix) with ESMTPS id 44d11Z5ydHz9sQq
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Apr 2019 16:37:22 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x386YCFe143956
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Apr 2019 02:37:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rqv5v3xkq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Apr 2019 02:37:19 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 8 Apr 2019 07:37:17 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 8 Apr 2019 07:37:14 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x386bDeF19923158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Apr 2019 06:37:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB53211C04A;
 Mon,  8 Apr 2019 06:37:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40EAB11C054;
 Mon,  8 Apr 2019 06:37:13 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  8 Apr 2019 06:37:13 +0000 (GMT)
Received: from [9.102.53.223] (unknown [9.102.53.223])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 96F52A0190;
 Mon,  8 Apr 2019 16:37:11 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc/xmon: add read-only mode
To: "Christopher M. Riedl" <cmr@informatik.wtf>, linuxppc-dev@ozlabs.org
References: <20190408030804.5805-1-cmr@informatik.wtf>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 8 Apr 2019 16:37:02 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408030804.5805-1-cmr@informatik.wtf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040806-0016-0000-0000-0000026C5E60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040806-0017-0000-0000-000032C87F7A
Message-Id: <f7a3d198-235d-b38c-e7a8-0ed103d7366d@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-08_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080061
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 8/4/19 1:08 pm, Christopher M. Riedl wrote:
> Operations which write to memory and special purpose registers should be
> restricted on systems with integrity guarantees (such as Secure Boot)
> and, optionally, to avoid self-destructive behaviors.
> 
> Add a config option, XMON_RW, to control default xmon behavior along
> with kernel cmdline options xmon=ro and xmon=rw for explicit control.
> Use XMON_RW instead of XMON in the condition to set PAGE_KERNEL_TEXT to
> allow xmon in read-only mode alongside write-protected kernel text.
> XMON_RW defaults to !STRICT_KERNEL_RWX.
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
> ---
> v1->v2:
> 	Use bool type for xmon_is_ro flag
> 	Replace XMON_RO with XMON_RW config option
> 	Make XMON_RW dependent on STRICT_KERNEL_RWX
> 	Use XMON_RW to control PAGE_KERNEL_TEXT
> 	Add printf in xmon read-only mode when dropping/skipping writes
> 	Disable memzcan (zero-fill memop) in xmon read-only mode
> 
>   arch/powerpc/Kconfig.debug                   | 10 +++++
>   arch/powerpc/include/asm/book3s/32/pgtable.h |  5 ++-
>   arch/powerpc/include/asm/book3s/64/pgtable.h |  5 ++-
>   arch/powerpc/include/asm/nohash/pgtable.h    |  5 ++-
>   arch/powerpc/xmon/xmon.c                     | 42 ++++++++++++++++++++
>   5 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 4e00cb0a5464..0c7f21476018 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -117,6 +117,16 @@ config XMON_DISASSEMBLY
>   	  to say Y here, unless you're building for a memory-constrained
>   	  system.
>   
> +config XMON_RW
> +	bool "Allow xmon read and write operations"

"Allow xmon write operations" would be clearer. This option has no 
impact on read operations.

> +	depends on XMON
> +	default !STRICT_KERNEL_RWX
> +	help
> +	  Allow xmon to read and write to memory and special-purpose registers.
> +          Conversely, prevent xmon write access when set to N. Read and write
> +          access can also be explicitly controlled with 'xmon=rw' or 'xmon=ro'
> +          (read-only) cmdline options. Default is !STRICT_KERNEL_RWX.

This is an improvement but still doesn't clearly explain the 
relationship between selecting this option and using the cmdline options.


> +
>   config DEBUGGER
>   	bool
>   	depends on KGDB || XMON
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index aa8406b8f7ba..615144ad667d 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -86,8 +86,9 @@ static inline bool pte_user(pte_t pte)
>    * set breakpoints anywhere, so don't write protect the kernel text
>    * on platforms where such control is possible.
>    */
> -#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
> -	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> +#if defined(CONFIG_KGDB) || defined(CONFIG_XMON_RW) || \
> +	defined(CONFIG_BDI_SWITCH) || defined(CONFIG_KPROBES) || \
> +	defined(CONFIG_DYNAMIC_FTRACE)
>   #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
>   #else
>   #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 581f91be9dd4..bc4655122f6b 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -168,8 +168,9 @@
>    * set breakpoints anywhere, so don't write protect the kernel text
>    * on platforms where such control is possible.
>    */
> -#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
> -	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> +#if defined(CONFIG_KGDB) || defined(CONFIG_XMON_RW) || \
> +	defined(CONFIG_BDI_SWITCH) || defined(CONFIG_KPROBES) || \
> +	defined(CONFIG_DYNAMIC_FTRACE)

We might need to rethink how the cmdline options work.

What happens if CONFIG_XMON_RW=n, but "xmon=rw" on the command line?

I think I agree with Oliver that we're not being clear whether this 
config option is selecting code to be compiled in, or whether it's just 
setting a default.

>   #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
>   #else
>   #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
> index 1ca1c1864b32..c052931bd243 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -22,8 +22,9 @@
>    * set breakpoints anywhere, so don't write protect the kernel text
>    * on platforms where such control is possible.
>    */
> -#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
> -	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> +#if defined(CONFIG_KGDB) || defined(CONFIG_XMON_RW) || \
> +	defined(CONFIG_BDI_SWITCH) || defined(CONFIG_KPROBES) || \
> +	defined(CONFIG_DYNAMIC_FTRACE)
>   #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
>   #else
>   #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index a0f44f992360..224ca0b3506b 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
>   #endif
>   static unsigned long in_xmon __read_mostly = 0;
>   static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
> +static bool xmon_is_ro = !IS_ENABLED(CONFIG_XMON_RW);
>   
>   static unsigned long adrs;
>   static int size = 1;
> @@ -202,6 +203,8 @@ static void dump_tlb_book3e(void);
>   #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
>   #endif
>   
> +static const char *xmon_is_ro_warn = "xmon read-only mode: skipping write\n";

Yay, error messages! Though something like: "Operation disabled: xmon is 
in read-only mode" would be clearer.

> +
>   static char *help_string = "\
>   Commands:\n\
>     b	show breakpoints\n\
> @@ -989,6 +992,10 @@ cmds(struct pt_regs *excp)
>   				memlocate();
>   				break;
>   			case 'z':
> +				if (xmon_is_ro) {
> +					printf(xmon_is_ro_warn);
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
> +				printf(xmon_is_ro_warn);
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
> +				printf(xmon_is_ro_warn);
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
> +		printf(xmon_is_ro_warn);
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
> +		printf(xmon_is_ro_warn);
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
> +			printf(xmon_is_ro_warn);
> +			break;
> +		}
>   		memmove((void *)mdest, (void *)msrc, mcount);
>   		break;
>   	case 's':
> +		if (xmon_is_ro) {
> +			printf(xmon_is_ro_warn);
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

