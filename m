Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F12EC2BC61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 01:09:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146B62082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 01:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDBkB3Rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146B62082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42jxLx3pb8zDsPf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 12:08:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDBkB3Rc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out3-smtp.messagingengine.com (client-ip=66.111.4.27;
 helo=out3-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="CDBkB3Rc"; dkim-atps=neutral
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42jxJT2GxbzDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 12:06:47 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id DE5F12112B;
 Sun, 28 Oct 2018 21:06:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Sun, 28 Oct 2018 21:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=b/ubvb9E3Rm1V9m509uQbu3goKdQY/1iEyKuXSUmJ
 JM=; b=CDBkB3Rcwqt0AYyqyIdZ/d7UxTXq8j0xyJjNM8t08Fqc1LImAM2VyIn60
 GvfpDJ+OlAisEwO1PPcUjj2d2iZ1JkawQCWpCKbFoR0PKPb03yghyAv85Wdx9KI1
 Vo56tbh1X9aUCLPbcuxfbFZw1Wm8RH4oZST/Rrcy1O+GcRPLVUjhGFk9jFCOOhqJ
 eqqYKOP5QBVmCYnKcpy9V4M8XdeYs3DJLAO4BcyO3Wwgze9z4ICAQENi2EaGWEp5
 wULG9YbsDMa/bIlmiyxp2BsV9jNV2aGH5wcNJISa96cmbWL11fEYxSgoQnwDhYo3
 DTY1716wM3rqR/Zm7uQxQvtt6oeMg==
X-ME-Sender: <xms:I13WW5JCKPKMbjU1e5BU_2U57Ndduoz2QkylkOB9iFuq1dkb4FNG2A>
X-ME-Proxy: <xmx:I13WWxsDHg035moiXFdsAWD5NEo62USwJy-E7Ln0vyco3GN6ijrlbg>
 <xmx:I13WWzpqMgWlOBJHaxtDa4NIW2n08p5S7gSsUVFyzCiXP9u1qtiDRw>
 <xmx:I13WW5CJTFi7NQlsF1Snvxn8-zpLdqwM-dWD29fYBI5AJy5xDniAPw>
 <xmx:I13WW9_0VRwzi2NV9QrbOA6sIPsGOv3kTjngUnBfLCFtLLoE9UzgBw>
 <xmx:I13WW9bTXDgevbmecAc39zPH5E8ER02PSULovgnH6NqYiLOJovj8zA>
 <xmx:JF3WW3aW_KRy_ZldECkY-cS_hjemPerjl9QLyo8IBUeA2166w7V3DQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id D6036102E4;
 Sun, 28 Oct 2018 21:06:41 -0400 (EDT)
Message-ID: <7b3e80077b4d9f22da891c143c78bb743cc24136.camel@russell.cc>
Subject: Re: [PATCH 5/5] powerpc/64s: Document that PPC supports nosmap
From: Russell Currey <ruscur@russell.cc>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Date: Mon, 29 Oct 2018 12:06:51 +1100
In-Reply-To: <20181026183525.Horde.tXUVv2_ZCCOci3XQBF4ZYw1@messagerie.si.c-s.fr>
References: <20181026063513.30806-1-ruscur@russell.cc>
 <20181026063513.30806-6-ruscur@russell.cc>
 <20181026183525.Horde.tXUVv2_ZCCOci3XQBF4ZYw1@messagerie.si.c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-10-26 at 18:35 +0200, LEROY Christophe wrote:
> Why not call our new functionnality SMAP instead of calling it GUAP ?

mpe wasn't a fan of using the same terminology as other architectures. 
Having a separate term does avoid some assumptions about how things
work or are implemented, but sharing compatibility with an existing
parameter is nice.

Personally I don't really care too much about the name.

- Russell

> 
> Christophe
> 
> Russell Currey <ruscur@russell.cc> a écrit :
> 
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt  
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index a5ad67d5cb16..8f78e75965f0 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2764,7 +2764,7 @@
> >  			noexec=on: enable non-executable mappings
> > (default)
> >  			noexec=off: disable non-executable mappings
> > 
> > -	nosmap		[X86]
> > +	nosmap		[X86,PPC]
> >  			Disable SMAP (Supervisor Mode Access
> > Prevention)
> >  			even if it is supported by processor.
> > 
> > --
> > 2.19.1
> 
> 

