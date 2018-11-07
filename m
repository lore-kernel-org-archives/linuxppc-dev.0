Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06A4C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 14:21:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A5F20827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 14:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A5F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qpW11wH4zF3JX
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 01:21:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qpSn4bzgzF3Cf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 01:19:21 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA7EEkZY128775
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Nov 2018 09:19:18 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nkyvqn805-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Nov 2018 09:19:18 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 7 Nov 2018 14:19:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Nov 2018 14:19:11 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA7EJA8p50987230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Nov 2018 14:19:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54CFDA405B;
 Wed,  7 Nov 2018 14:19:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEE63A4054;
 Wed,  7 Nov 2018 14:19:09 +0000 (GMT)
Received: from localhost (unknown [9.79.176.163])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  7 Nov 2018 14:19:09 +0000 (GMT)
Date: Wed, 07 Nov 2018 19:49:08 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE
To: Alexander Graf <agraf@suse.de>, Scott Wood <oss@buserror.net>
References: <20181107014934.26428-1-oss@buserror.net>
In-Reply-To: <20181107014934.26428-1-oss@buserror.net>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 18110714-0028-0000-0000-000003163872
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110714-0029-0000-0000-000023D286B5
Message-Id: <1541600158.a6gip2ac6c.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-07_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070128
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
Cc: kvm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 kvm-ppc@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Scott Wood wrote:
> TRACE_INCLUDE_PATH and TRACE_INCLUDE_FILE are used by
> <trace/define_trace.h>, so like that #include, they should
> be outside #ifdef protection.
>=20
> They also need to be #undefed before defining, in case multiple trace
> headers are included by the same C file.  This became the case on
> book3e after commit cf4a6085151a ("powerpc/mm: Add missing tracepoint for
> tlbie"), leading to the following build error:
>=20
>    CC      arch/powerpc/kvm/powerpc.o
> In file included from arch/powerpc/kvm/powerpc.c:51:0:
> arch/powerpc/kvm/trace.h:9:0: error: "TRACE_INCLUDE_PATH" redefined
> [-Werror]
>   #define TRACE_INCLUDE_PATH .
>   ^
> In file included from arch/powerpc/kvm/../mm/mmu_decl.h:25:0,
>                   from arch/powerpc/kvm/powerpc.c:48:
> ./arch/powerpc/include/asm/trace.h:224:0: note: this is the location of
> the previous definition
>   #define TRACE_INCLUDE_PATH asm
>   ^
> cc1: all warnings being treated as errors
>=20
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
>  arch/powerpc/kvm/trace.h       | 8 ++++++--
>  arch/powerpc/kvm/trace_booke.h | 9 +++++++--
>  arch/powerpc/kvm/trace_hv.h    | 9 +++++++--
>  arch/powerpc/kvm/trace_pr.h    | 9 +++++++--
>  4 files changed, 27 insertions(+), 8 deletions(-)

Thanks for getting to this. Apart from a small nit below, for this=20
patch:
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

>=20
> diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
> index 491b0f715d6b..ea1d7c808319 100644
> --- a/arch/powerpc/kvm/trace.h
> +++ b/arch/powerpc/kvm/trace.h
> @@ -6,8 +6,6 @@
>=20
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM kvm
> -#define TRACE_INCLUDE_PATH .
> -#define TRACE_INCLUDE_FILE trace

The convention is to also have the TRACE_SYSTEM macro defined outside=20
and before the header #ifdef. So, that would be good to do as part of=20
this cleanup as well. If not, I can send a patch later.

Thanks,
Naveen

=

