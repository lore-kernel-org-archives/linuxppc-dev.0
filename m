Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C4C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 01:11:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DB72082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 01:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mFreGYMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DB72082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42jxPY0PhyzDsG1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 12:11:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="mFreGYMS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out3-smtp.messagingengine.com (client-ip=66.111.4.27;
 helo=out3-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="mFreGYMS"; dkim-atps=neutral
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42jxKl5GpKzDsQ7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 12:07:55 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 7A4C221D3C;
 Sun, 28 Oct 2018 21:07:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 28 Oct 2018 21:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=h3F6TomMKrex/zNRUDLskmYKbnYpc2cCv/vNWRMmZ
 5M=; b=mFreGYMSR9IcAxlks8d0LhCmyL4rAqolyFbZLZ8vRtsYTORfP5+crXZdt
 OTUoaVM4WGyACGWKsTNebfxaWmY3lEVkR1Nhhw75SPpF915qHbonIE9GrQHkFotK
 92thxcQ7GL8xVF3XMAM1p2/wd+yC3X2D0yU38z5QF8f99/3aBNDSq8SmYXyLIFYc
 uz1JILb+LUaZmkIzIuUJiuHF7LD/Y6zYs9apHcvnRpTY3Ro2QuYpoOvJ1gzPe4ox
 CGR4JjksBYuxya6O/GcrxS0JYd+RqQfWfBaWVHW8Ups5hhSEvSgW+G+XSCflQtZ2
 rhVL/F2+arbvf915iCYCIK+Tm6yZw==
X-ME-Sender: <xms:aV3WWzNgKvP2TBqODbjhNVrbT5t7Swlq_WxA-Ckj6QoF8beYd-tcyQ>
X-ME-Proxy: <xmx:aV3WW-MWGgylCVLRl7MBGLPtjSVTHG8CSykYVJgmgUIyKgHgb1JV4g>
 <xmx:aV3WW675ybLvdIeaTOnczoP6EzuzwoCTsy7mSIFOLGq2262xceAGWA>
 <xmx:aV3WW80ggJAvgMMUJlWiNEv1P7pZClKNuZt0cst_-oxB_SqbQ0iStA>
 <xmx:aV3WW7YQmkQh_u9_z7vssvgH7iobHtlIsShbzr2IUtp6MpB48D7TOg>
 <xmx:aV3WW0BU-bd-Kocn0WyfOk0V3_Fucsi3Z1sGfx8OuIx1-USeMLl6bg>
 <xmx:aV3WW3GZYk26bTW2Hpo2LV_fvvojz6pKerzgTfYUn4C7bPgHDwp1oQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9055DE4892;
 Sun, 28 Oct 2018 21:07:51 -0400 (EDT)
Message-ID: <8f359a830d9b86837130f9333c54233180793c98.camel@russell.cc>
Subject: Re: [PATCH 2/5] powerpc/futex: GUAP support for futex ops
From: Russell Currey <ruscur@russell.cc>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Date: Mon, 29 Oct 2018 12:08:01 +1100
In-Reply-To: <20181026183238.Horde.Qb6gGcTLnJI-ma8mXsMeBA1@messagerie.si.c-s.fr>
References: <20181026063513.30806-1-ruscur@russell.cc>
 <20181026063513.30806-3-ruscur@russell.cc>
 <20181026183238.Horde.Qb6gGcTLnJI-ma8mXsMeBA1@messagerie.si.c-s.fr>
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

On Fri, 2018-10-26 at 18:32 +0200, LEROY Christophe wrote:
> Russell Currey <ruscur@russell.cc> a écrit :
> 
> > Wrap the futex operations in GUAP locks and unlocks.
> 
> Does it means futex doesn't work anymore once only patch 1 is
> applied  
> ? If so, then you should split patch 1 in two parts and reorder  
> patches so that guap can only be activated once all necessary
> changes  
> are done. Otherwise the serie won't be bisectable

Yeah, I agree.  I just wanted to remove some amount of breadth from
what already is one gigantic patch.  Bisectability is more important
than that, however.

- Russell

> 
> Christophe
> 
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > ---
> >  arch/powerpc/include/asm/futex.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/futex.h  
> > b/arch/powerpc/include/asm/futex.h
> > index 94542776a62d..3aed640ee9ef 100644
> > --- a/arch/powerpc/include/asm/futex.h
> > +++ b/arch/powerpc/include/asm/futex.h
> > @@ -35,6 +35,7 @@ static inline int
> > arch_futex_atomic_op_inuser(int  
> > op, int oparg, int *oval,
> >  {
> >  	int oldval = 0, ret;
> > 
> > +	unlock_user_access();
> >  	pagefault_disable();
> > 
> >  	switch (op) {
> > @@ -62,6 +63,7 @@ static inline int
> > arch_futex_atomic_op_inuser(int  
> > op, int oparg, int *oval,
> >  	if (!ret)
> >  		*oval = oldval;
> > 
> > +	lock_user_access();
> >  	return ret;
> >  }
> > 
> > @@ -75,6 +77,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32
> > __user *uaddr,
> >  	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> >  		return -EFAULT;
> > 
> > +	unlock_user_access();
> >          __asm__ __volatile__ (
> >          PPC_ATOMIC_ENTRY_BARRIER
> >  "1:     lwarx   %1,0,%3         # futex_atomic_cmpxchg_inatomic\n\
> > @@ -95,6 +98,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32
> > __user *uaddr,
> >          : "cc", "memory");
> > 
> >  	*uval = prev;
> > +	lock_user_access();
> >          return ret;
> >  }
> > 
> > --
> > 2.19.1
> 
> 

