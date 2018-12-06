Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732F9C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:25:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FB320850
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FB320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439jD26hFMzDqnM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:25:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439hpD6tLBzDr3h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 04:06:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 439hpD4Zlkz8tPZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 04:06:28 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 439hpD49MDz9s55; Fri,  7 Dec 2018 04:06:28 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mdroth@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 439hpD0Xl1z9s6w
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2018 04:06:27 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB6H04XG059916
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2018 12:06:26 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p77ant2s5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Dec 2018 12:06:26 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mdroth@linux.vnet.ibm.com>;
 Thu, 6 Dec 2018 17:06:24 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Dec 2018 17:06:21 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB6H6KaQ17694938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Dec 2018 17:06:20 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF467124054;
 Thu,  6 Dec 2018 17:06:20 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B051E124058;
 Thu,  6 Dec 2018 17:06:20 +0000 (GMT)
Received: from localhost (unknown [9.53.179.197])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  6 Dec 2018 17:06:20 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Sandipan Das <sandipan@linux.ibm.com>, ast@kernel.org, daniel@iogearbox.net
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181206092732.4206-1-sandipan@linux.ibm.com>
References: <20181206092732.4206-1-sandipan@linux.ibm.com>
User-Agent: alot/0.7
Subject: Re: [PATCH bpf] bpf: fix default unprivileged allocation limit
Date: Thu, 06 Dec 2018 10:58:20 -0600
X-TM-AS-GCONF: 00
x-cbid: 18120617-0060-0000-0000-000002DFE26B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010182; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127891; UDB=6.00585880; IPR=6.00908023; 
 MB=3.00024501; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-06 17:06:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120617-0061-0000-0000-000047724E3D
Message-Id: <154411550033.874.18180900802581812635@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060145
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
Cc: naveen.n.rao@linux.ibm.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Quoting Sandipan Das (2018-12-06 03:27:32)
> When using a large page size, the default value of the bpf_jit_limit
> knob becomes invalid and users are not able to run unprivileged bpf
> programs.
> =

> The bpf_jit_limit knob is represented internally as a 32-bit signed
> integer because of which the default value, i.e. PAGE_SIZE * 40000,
> overflows in case of an architecture like powerpc64 which uses 64K
> as the default page size (i.e. CONFIG_PPC_64K_PAGES is set).
> =

> So, instead of depending on the page size, use a constant value.
> =

> Fixes: ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict unpriv allo=
cations")

This also consistently caused a virtio-net KVM Ubuntu 18.04 guest to time o=
ut
on configuring networking during boot via systemd/netplan. A bisect
pointed to the same commit this patch addresses.

> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>  kernel/bpf/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b1a3545d0ec8..a81d097a17fb 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -365,7 +365,7 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
>  }
> =

>  #ifdef CONFIG_BPF_JIT
> -# define BPF_JIT_LIMIT_DEFAULT (PAGE_SIZE * 40000)
> +# define BPF_JIT_LIMIT_DEFAULT (4096 * 40000)

This isn't quite right as we still use (bpf_jit_limit >> PAGE_SHIFT) to che=
ck
allocations in bpf_jit_charge_modmem(), so that should be fixed up as well.

Another alternative which is to clamp BPF_JIT_LIMIT_DEFAULT to INT_MAX,
which fixes the issue for me and is similar to what
bpf_jit_charge_init() does for kernels where MODULES_VADDR is defined.
I'll go ahead and send the patch in case that seems preferable.

> =

>  /* All BPF JIT sysctl knobs here. */
>  int bpf_jit_enable   __read_mostly =3D IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_=
ON);
> -- =

> 2.19.2
>=20

