Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3ACC10F00
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22102171F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22102171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4497Gf4yn8zDqMf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:55:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4497Dq3FFxzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:54:19 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1S9nb4r076770
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 04:54:16 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qxbk3d9g9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 04:54:16 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 28 Feb 2019 09:54:15 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Feb 2019 09:54:13 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1S9sCWX16974074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Feb 2019 09:54:12 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A4EC11206B;
 Thu, 28 Feb 2019 09:54:12 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC365112064;
 Thu, 28 Feb 2019 09:54:11 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.84])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 28 Feb 2019 09:54:11 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id 728C12E2D5F; Thu, 28 Feb 2019 15:24:10 +0530 (IST)
Date: Thu, 28 Feb 2019 15:24:10 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH v2] powerpc/powernv/idle: Restore IAMR after idle
References: <20190208111103.4901-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208111103.4901-1-ruscur@russell.cc>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 19022809-0064-0000-0000-000003B0C11C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010679; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167519; UDB=6.00609945; IPR=6.00948133; 
 MB=3.00025777; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-28 09:54:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022809-0065-0000-0000-00003C8FCF5A
Message-Id: <20190228095410.GC24751@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-28_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=933 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280070
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
Reply-To: ego@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Russell,

On Fri, Feb 08, 2019 at 10:11:03PM +1100, Russell Currey wrote:
> Without restoring the IAMR after idle, execution prevention on POWER9
> with Radix MMU is overwritten and the kernel can freely execute userspace without
> faulting.
> 
> This is necessary when returning from any stop state that modifies user
> state, as well as hypervisor state.
> 
> To test how this fails without this patch, load the lkdtm driver and
> do the following:
> 
>    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
> 
> which won't fault, then boot the kernel with powersave=off, where it
> will fault.  Applying this patch will fix this.
> 
> Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of user
> space")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
> Since v1:
>       - no longer use paca to save IAMR, instead use _DAR (thanks mpe)

Looks good to me. Once we move to Nick Piggin's C-based save/restore
code, we will be saving all these SPR values on the stack anyway.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

--
Thanks and Regards
gautham.

