Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BCC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:37:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD6F2064A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD6F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rdlc4SkmzDqjx
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:37:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RcFV0pPrzF3cB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 03:29:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42RcFT6TCyz8tQB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 03:29:33 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 42RcFT5Ql0z9s55; Sat,  6 Oct 2018 03:29:33 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=muriloo@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42RcFT1rpvz9s4s
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2018 03:29:33 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w95HT73A142148
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Oct 2018 13:29:31 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mxan0dqvg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 05 Oct 2018 13:29:30 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 5 Oct 2018 11:29:30 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 5 Oct 2018 11:29:27 -0600
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w95HTQrZ49742046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Oct 2018 10:29:26 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FD41C6057;
 Fri,  5 Oct 2018 11:29:26 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82C40C6055;
 Fri,  5 Oct 2018 11:29:25 -0600 (MDT)
Received: from localhost (unknown [9.85.158.53])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri,  5 Oct 2018 11:29:25 -0600 (MDT)
Date: Fri, 5 Oct 2018 14:29:22 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Don't print kernel instructions in
 show_user_instructions()
References: <20181005132123.6038-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005132123.6038-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18100517-0020-0000-0000-00000E732F59
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009825; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098319; UDB=6.00568076; IPR=6.00878359; 
 MB=3.00023630; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-05 17:29:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100517-0021-0000-0000-00006344F4E0
Message-Id: <20181005172922.GA9867@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-05_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050173
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
Cc: linuxppc-dev@ozlabs.org, jannh@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 05, 2018 at 11:21:23PM +1000, Michael Ellerman wrote:
> Recently we implemented show_user_instructions() which dumps the code
> around the NIP when a user space process dies with an unhandled
> signal. This was modelled on the x86 code, and we even went so far as
> to implement the exact same bug, namely that if the user process
> crashed with its NIP pointing into the kernel we will dump kernel text
> to dmesg. eg:
>
>   bad-bctr[2996]: segfault (11) at c000000000010000 nip c000000000010000 lr 12d0b0894 code 1
>   bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a10028 38810020 fb810050 7f8802a6
>   bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1b79> 4082002c e8010080 eb610048
>
> This was discovered on x86 by Jann Horn and fixed in commit
> 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on usermode RIP").
>
> Fix it by checking the adjusted NIP value (pc) and number of
> instructions against USER_DS, and bail if we fail the check, eg:
>
>   bad-bctr[2969]: segfault (11) at c000000000010000 nip c000000000010000 lr 107930894 code 1
>   bad-bctr[2969]: Bad NIP, not dumping instructions.
>
> Fixes: 88b0fe175735 ("powerpc: Add show_user_instructions()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Thank you all!

> ---
>  arch/powerpc/kernel/process.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 913c5725cdb2..bb6ac471a784 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1306,6 +1306,16 @@ void show_user_instructions(struct pt_regs *regs)
>
>  	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
>
> +	/*
> +	 * Make sure the NIP points at userspace, not kernel text/data or
> +	 * elsewhere.
> +	 */
> +	if (!__access_ok(pc, instructions_to_print * sizeof(int), USER_DS)) {
> +		pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
> +			current->comm, current->pid);
> +		return;
> +	}
> +
>  	pr_info("%s[%d]: code: ", current->comm, current->pid);
>
>  	for (i = 0; i < instructions_to_print; i++) {
> --
> 2.17.1
>

--
Murilo

