Return-Path: <linuxppc-dev+bounces-28916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06D9CA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 07:37:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyrn65ptkz2yjw;
	Mon, 05 Oct 2026 18:36:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791185818;
	cv=none; b=VPovbfSFuzxUuCPntPM5Yl/QXKeENFdwpF6cwZ8HjZyTf1TAS5nGG1yR4a2Zf8zjQMvgWhSrTA56VknOrnqZd2ci6LVI7zSmZ3pRkCTzGGwJywMsHF//zZkG/kATELbj6B3T6bGfbQvhlNc1HdodLk65akP/5bslC/EGr6gfmO/T8b3oxQJdVpM5NXm7WLcE+ZPfs+mrrP+IrtcgFw4t/3RWfk9M9/lkauxZZDlY4QR82sxT6QpPUMbS6DmCf4rzq20HMG0nUWwL7FGMtDPSWLTzIQz9v+orgbIphw2AZkilY1bsH8gVTTYN4IZYRiSJUj6Ce6aHQqM0haBOhYi8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791185818; c=relaxed/relaxed;
	bh=RJFv3jrtkC0svbmP1yEJmkw1gwKAt3tmxR7hZ8Km7N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecictw+MoOWreGYh/z6P2ysxfk/mEjyhtS49ewvWulS3UCWBe86HAyGlv7ReS0TAazHs28eu+7lCfW/gkjDAGFeHIfCFVu+YIvvxTX9eucUxIIsq/RHKurLZ8m0/IYabyRjbcW8DPJpPrzNQt92Dqs+rApS2/jJ9C0TMguKzWneVcohU6XJ4OuL/m/Rbuei+6gowM4ArK2aG8SGKqMntPsTHK9+4WWgWAnNglt9oBw7l1/DGFip+LIBMeCY2/lZEtt6i4Bkcjus7azG0nttsTHYeHdZexlgdrfSqfH9nU7st7a/k7aGQq3z+/PcRV1YH6KTs+aEz5jTCqGughEE3sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tNPrw0Xw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tNPrw0Xw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyrn52jxXz2yf9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 18:36:56 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515LWn1475326;
	Mon, 5 Oct 2026 07:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RJFv3jrtkC0svbmP1yEJmkw1gwKAt3
	tmxR7hZ8Km7N0=; b=tNPrw0Xwu+PW5ZOjVHPX8f7TxEjF79+1atiHePnl+eiQyp
	hAdgfv3wTl0NSckjkHASEaLJi1+qlrhXsRcBIjcBQx+AfZtEB1PRhmKCjQ6cY1yv
	y2Qubi+bDhh1nFz2kNxgwSnatxj/e44T1YB81PaPumikpEK4bbSP7gGlN9Csul/C
	M0cQ0tSeEeJpDLKgjIrzidbu30dn9HVupG9w39PjRBoXBkjRvjhu1SBkMbtqtxc9
	HkQF3+99cwY0Xjs3tbwpOeweuMOTnMWYGOIKubwXHEQMlA78M6f4oC+b6pc1r+CF
	2yn9HitBz9AgHz3t3HAeIPcbi77GsP+nRgqAbKcQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scr8yg5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 07:36:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956PPbu899535;
	Mon, 5 Oct 2026 07:36:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g49hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 07:36:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6957agQ346662112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 07:36:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA9C20063;
	Mon,  5 Oct 2026 07:36:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26C6C20040;
	Mon,  5 Oct 2026 07:36:40 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Oct 2026 07:36:38 +0000 (GMT)
Date: Mon, 5 Oct 2026 13:14:50 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>
Cc: amachhiw@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        sourabhjain@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH v2] powerpc/mpic: Fix memory leak of mpic on error paths
Message-ID: <20261005130342.de3acc9a-b0-amachhiw@linux.ibm.com>
Mail-Followup-To: Jyoti Gupta <jyoti@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	sourabhjain@linux.ibm.com, mkchauras@gmail.com
References: <20260930180919.335930-1-jyoti@linux.ibm.com>
 <20261001001512.d05b4c2a-13-amachhiw@linux.ibm.com>
 <98cf7d072c8986bfdc5a28f577876503@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98cf7d072c8986bfdc5a28f577876503@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzMCBTYWx0ZWRfX0jGzlFEajmGC
 nFMXLbGcFGPnKbjs7dgC5teM2V/rTzcaa048hS2vUKjBNMyl+5X3sjaSZ8Vfll70zUwQ3VlTmhQ
 m++gG2H5fDxiyiRGm6rpWowIGhTJJcE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzMCBTYWx0ZWRfX8L/WxFSR0osz
 Py40UnxEL8q7GlQh+5YEhzpiOJ8eE8OzNEo7yav7PqSB3UUGjT8unzti7s/qEZRi1qMNyd4Puyu
 5PGDy1G07cU4Tydo6rqToW3XBy+/Q+SLuQEw0i6a60QpgnkIVUhdPSHLZWdA2OeRd2Ux4Lz3j8b
 xSooFaR6ggzkrnhEvQoCA2IZajHgMy6NGIRcdkFR5ur6Ytk/N0CDTjOMumAx6/5shioOLqDUNhX
 MAfA/OmjdF7mFPrUAhQ14RcbUDNX3Pc1O/GJCuKGY9BkMQA1XjU20x76CE/NMdpGLZ2qzBP450f
 FCZhDmyfjHAtYpOrXvMyj876hkWQyiVV02di2qiipNuzA7ANvrwA6fTi+se2/the5CVRONHH6pQ
 KJoTFmdbGhAxTlijG82etIzBeXUB6eFuPhotq4dyFnJZAq160MmZqIgOKwM+3kA8cW6BxGNiYff
 ZhKfs1BvRTxupCEeVmA==
X-Proofpoint-GUID: aA5EFFVp_JTj2QasH6w7F-RmpTFMm_Ll
X-Proofpoint-ORIG-GUID: XwwQgjwmSU_OqqkiVgT-2OT8u3Qx7W-p
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac3538f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=qiT8vAV_IABRkjKlFogA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050030

Hi Jyoti,

Please find my responses inline below.

On 2026/10/01 05:29 PM, Jyoti Gupta wrote:
> On 2026-10-01 00:20, Amit Machhiwal wrote:
> > On 2026/09/30 11:39 PM, Jyoti Gupta wrote:
> > > mpic_alloc() allocates struct mpic (and optionally the protected
> > > sources bitmap) but does not free them when mpic_setup_error_int() or
> > > irq_domain_create_linear() fails, leaking the memory.
> > > 
> > > Free the bitmap and the mpic in the common error path before
> > > dropping the
> > > device node reference.
> > > 
> > > Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree
> > > node if NULL")
> > > Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> > > ---
> > >  arch/powerpc/sysdev/mpic.c | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > Thanks for addressing the comments from v1.
> > 
> > A couple of minor suggestions:
> > 
> > 1. Changelog & Links: It is always a good practice to include a
> > changelog below
> >    the "---" line detailing the changes made in this version (e.g. "v1
> > -> v2:
> >    ...") along with a link to the previous version(s) on
> > lore.kernel.org. This
> >    helps reviewers and maintainers quickly track the evolution of the
> > patch.
> > 
> 
> Got it, thank you for the suggestion. I'll keep it in mind.
> 
> > 2. Minor nit in cleanup logic below:
> > 
> > > 
> > > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > > index 257886ec3f70..b21a880777cc 100644
> > > --- a/arch/powerpc/sysdev/mpic.c
> > > +++ b/arch/powerpc/sysdev/mpic.c
> > > @@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct
> > > device_node *node,
> > >  		if (fsl_version >= 0x401) {
> > >  			ret = mpic_setup_error_int(mpic, intvec_top - 13);
> > >  			if (ret)
> > > -				return NULL;
> > > +				goto err_of_node_put;
> > >  		}
> > > 
> > >  	}
> > > @@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct
> > > device_node *node,
> > >  						 intvec_top,
> > >  						 &mpic_host_ops, mpic);
> > > 
> > > -	/*
> > > -	 * FIXME: The code leaks the MPIC object and mappings here; this
> > > -	 * is very unlikely to fail but it ought to be fixed anyways.
> > > -	 */
> > >  	if (mpic->irqhost == NULL)
> > > -		return NULL;
> > > +		goto err_of_node_put;
> > > 
> > >  	/* Display version */
> > >  	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
> > > @@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct
> > > device_node *node,
> > >  	return mpic;
> > > 
> > >  err_of_node_put:
> > > +	if (mpic)
> > > +		bitmap_free(mpic->protected);
> > > +	kfree(mpic);
> > 
> > Both bitmap_free() and kfree() safely handle NULL pointers (and mpic is
> > guaranteed to be non-NULL at this label anyway), so the 'if (mpic)'
> > check is
> > redundant.
> > 
> 
> Thanks for the review.
> 
> Regarding the 'if (mpic)' check, I think we may need to keep it. While
> bitmap_free() and kfree() both safely handle NULL, the concern here is
> dereferencing mpic to obtain mpic->protected. There are two paths that
> reach err_of_node_put before mpic is allocated (line 1276):
> of_address_to_resource() failure at line 1258 and kzalloc_obj() returning
> NULL at line 1278. In both cases, mpic->protected would dereference a
> NULL/garbage pointer and crash.

Good catch on the early error paths before mpic allocation!

However, in v2, 'struct mpic *mpic' is left uninitialized at function entry
(since the '= NULL' initialization was dropped).

Looking more closely, if of_address_to_resource() fails at line 1258, control
jumps to err_of_node_put where 'mpic' contains uninitialized stack garbage.  In
that case, 'if (mpic)' evaluates to true, leading to an invalid pointer
dereference when evaluating mpic->protected and a crash on kfree(mpic).

Rather than initializing mpic to NULL and checking 'if (mpic)' on error paths,
the preferred approach in Linux is to use layered error labels.  In fact,
Documentation/process/coding-style.rst (Section 7, "Centralized exiting of
functions") specifically describes this pattern when discussing "one err bugs":


  A common type of bug to be aware of is ``one err bugs`` which look like this:

  .. code-block:: c

  	err:
  		kfree(foo->bar);
  		kfree(foo);
  		return ret;

  The bug in this code is that on some exit paths ``foo`` is NULL.  Normally the
  fix for this is to split it up into two error labels ``err_free_bar:`` and
  ``err_free_foo:``:

  .. code-block:: c

  	err_free_bar:
  		kfree(foo->bar);
  	err_free_foo:
  		kfree(foo);
  		return ret;

Applying that pattern here gives:

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 257886ec3f70..d799cf4da7bd 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
                if (fsl_version >= 0x401) {
                        ret = mpic_setup_error_int(mpic, intvec_top - 13);
                        if (ret)
-                               return NULL;
+                               goto err_free_mpic;
                }
 
        }
@@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
                                                 intvec_top,
                                                 &mpic_host_ops, mpic);
 
-       /*
-        * FIXME: The code leaks the MPIC object and mappings here; this
-        * is very unlikely to fail but it ought to be fixed anyways.
-        */
        if (mpic->irqhost == NULL)
-               return NULL;
+               goto err_free_mpic;
 
        /* Display version */
        switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
@@ -1526,6 +1522,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 
        return mpic;
 
+err_free_mpic:
+       bitmap_free(mpic->protected);
+       kfree(mpic);
 err_of_node_put:
        of_node_put(node);
        return NULL;

This ensures:

1. Early error paths (of_address_to_resource and kzalloc_obj failures) jump
   directly to err_of_node_put without touching mpic.
2. Later error paths jump to err_free_mpic where mpic is guaranteed to be valid.
3. No 'if (mpic)' check or 'struct mpic *mpic = NULL;' is needed.

What do you think?

Thanks,
Amit

