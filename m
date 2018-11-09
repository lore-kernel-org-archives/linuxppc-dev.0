Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E5C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 16:24:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E86320825
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 16:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E86320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s57z0zD5zF3c4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 03:24:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s55w31PFzF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 03:22:27 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA9GK5FP124966
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Nov 2018 11:22:24 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nnddp8va7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2018 11:22:24 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 9 Nov 2018 16:22:23 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 9 Nov 2018 16:22:20 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA9GMJrh19595380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Nov 2018 16:22:19 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A587078068;
 Fri,  9 Nov 2018 16:22:19 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF23C78064;
 Fri,  9 Nov 2018 16:22:18 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.198.236])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri,  9 Nov 2018 16:22:18 +0000 (GMT)
References: <1541697162-1926-1-git-send-email-leitao@debian.org>
User-agent: mu4e 1.0; emacs 26.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] powerpc/xmon: Fix invocation inside lock region
In-reply-to: <1541697162-1926-1-git-send-email-leitao@debian.org>
Date: Fri, 09 Nov 2018 14:22:16 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18110916-0020-0000-0000-00000E87B102
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010015; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01114992; UDB=6.00578117; IPR=6.00895092; 
 MB=3.00024092; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-09 16:22:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110916-0021-0000-0000-000063A99C26
Message-Id: <877ehmrzk7.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-09_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=698 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811090149
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Breno Leitao <leitao@debian.org> writes:

> Currently xmon needs to get devtree_lock (through rtas_token()) during its
> invocation (at crash time). If there is a crash while devtree_lock is being
> held, then xmon tries to get the lock but spins forever and never get into
> the interactive debugger, as in the following case:
>
> 	int *ptr = NULL;
> 	raw_spin_lock_irqsave(&devtree_lock, flags);
> 	*ptr = 0xdeadbeef;
>
> This patch avoids calling rtas_token(), thus trying to get the same lock,
> at crash time. This new mechanism proposes getting the token at
> initialization time (xmon_init()) and just consuming it at crash time.
>
> This would allow xmon to be possible invoked independent of devtree_lock
> being held or not.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

I'm not familiar with xmon code but I was curious, and for what it's
worth:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> ---
>  arch/powerpc/xmon/xmon.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 36b8dc47a3c3..b566203d09c5 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -75,6 +75,9 @@ static int xmon_gate;
>  #define xmon_owner 0
>  #endif /* CONFIG_SMP */
>
> +#ifdef CONFIG_PPC_PSERIES
> +static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
> +#endif
>  static unsigned long in_xmon __read_mostly = 0;
>  static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
>
> @@ -358,7 +361,6 @@ static inline void disable_surveillance(void)
>  #ifdef CONFIG_PPC_PSERIES
>  	/* Since this can't be a module, args should end up below 4GB. */
>  	static struct rtas_args args;
> -	int token;
>
>  	/*
>  	 * At this point we have got all the cpus we can into
> @@ -367,11 +369,11 @@ static inline void disable_surveillance(void)
>  	 * If we did try to take rtas.lock there would be a
>  	 * real possibility of deadlock.
>  	 */
> -	token = rtas_token("set-indicator");
> -	if (token == RTAS_UNKNOWN_SERVICE)
> +	if (set_indicator_token == RTAS_UNKNOWN_SERVICE)
>  		return;
>
> -	rtas_call_unlocked(&args, token, 3, 1, NULL, SURVEILLANCE_TOKEN, 0, 0);
> +	rtas_call_unlocked(&args, set_indicator_token, 3, 1, NULL,
> +			   SURVEILLANCE_TOKEN, 0, 0);
>
>  #endif /* CONFIG_PPC_PSERIES */
>  }
> @@ -3688,6 +3690,14 @@ static void xmon_init(int enable)
>  		__debugger_iabr_match = xmon_iabr_match;
>  		__debugger_break_match = xmon_break_match;
>  		__debugger_fault_handler = xmon_fault_handler;
> +
> +#ifdef CONFIG_PPC_PSERIES
> +		/*
> +		 * Get the token here to avoid trying to get a lock
> +		 * during the crash, causing a deadlock.
> +		 */
> +		set_indicator_token = rtas_token("set-indicator");
> +#endif
>  	} else {
>  		__debugger = NULL;
>  		__debugger_ipi = NULL;


--
Thiago Jung Bauermann
IBM Linux Technology Center

