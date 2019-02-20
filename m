Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1517C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:59:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF66B2083B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="IrEH4N+6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5H+0z6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF66B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444GP85HN4zDqLc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 22:59:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="IrEH4N+6"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="k5H+0z6k"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444GMP3XG5zDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 22:58:09 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id E9B152232B;
 Wed, 20 Feb 2019 06:58:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 20 Feb 2019 06:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 KOFvQgYgydW7uNPrYrrIxSYhXoUfT4AhZp+Oj4g5A5Y=; b=IrEH4N+6lLMbOOI1
 rfEdklkKQR4006rMa356cDv5KJU4gMQUi09vTKnXunhaM1KJzzEptfxqYm9/RfSj
 AX+fAnqo5y/0TG4u3PCLLZUhQDADfkaVHRKEgXfh7l0aIo8zXkksWtM+1xxpbxnv
 0GrSzhadoVlyZKJsEVt1z0utHxVmFne4+9E90OeNd/hnrtmHSjyyOY+qakF7Auvw
 9PHN+Y9EGCw6hg7AxFOeSPoy5zUOmP/dV/cT6V2ArgPsp7VhtTqwbVA+wEWLyDr0
 sCx2qUFzZGCSwcFd06vpM4pS4RzgwAd9zM9HFEP92PlnSX2F5xuCMWFIJltWyoF2
 BnXmyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=KOFvQgYgydW7uNPrYrrIxSYhXoUfT4AhZp+Oj4g5A
 5Y=; b=k5H+0z6k/Vo0glWXarJFOLZUcgbitKelE0nApUlCtyWXyl3d12fwV0D8D
 bVsnpFH5NhGKNUFAkq0NkTyplHKA+7kJ4dSnnfu+rBXaom3Lbwq7jtBXnvorAdGr
 7KMVfNV77P1eYhwIQlehcA2QZlN/Onm/5ogq075QbMqiUneD6BrAhmrCAEeWdcaE
 2FcxqnIpIudShLkw7bcit3IQ/hlsHiy52Vl8KZTV1f7I/AJrWfaa7pcm7IF9dV+n
 4dYx0rdKC7ZTDvLgBu9HnD7kCUQkqz7eqCWNQboMcR7H3cXyYL1a9hNnY5eP2Y9n
 zUDu+Ric2H96LobZ7gIdRVT7TOY+g==
X-ME-Sender: <xms:zUBtXHbxNKnkeN4HEjnCIHsxhb5mPdrF87Tib2oGYeZZJ4PqPVwiNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdeigdefgeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdlfedtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddt
 reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
 hsvghllhdrtggtqeenucfkphepuddvuddrgeehrddvudelrdefnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehruhhstghurhesrhhushhsvghllhdrtggtnecuvehluhhsthgvrhfuih
 iivgeptd
X-ME-Proxy: <xmx:zUBtXG9q00S4UbcZxSBHatMRXzZkFtfWT35NOttHSp1GtLQLZAlSjA>
 <xmx:zUBtXLIZ1fN8zG_JBqvvtRj1S0BW4TANjvxJDagrTryUhJ2hcLZSag>
 <xmx:zUBtXHXxIi_MSLHW-o22nvKRo4sVafYhpBDsnR7OZaqij_vzVUE3zA>
 <xmx:zkBtXHRnt64X0kkFFZZDPiot68ZK4QgwYvSeCoxQJQqObuZd01KHtQ>
Received: from crackle.ozlabs.ibm.com
 (ppp121-45-219-3.bras1.cbr2.internode.on.net [121.45.219.3])
 by mail.messagingengine.com (Postfix) with ESMTPA id AC72010319;
 Wed, 20 Feb 2019 06:58:02 -0500 (EST)
Message-ID: <f4fc28e2f6807ef0669d1de8a72fcb5f5b5cfc43.camel@russell.cc>
Subject: Re: [PATCH v2 2/3] powerpc/lib: Refactor __patch_instruction() to
 use __put_user_asm()
From: Russell Currey <ruscur@russell.cc>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 20 Feb 2019 22:57:59 +1100
In-Reply-To: <5ff8b24e-a748-19d3-8651-b626dd676ea4@c-s.fr>
References: <20181210070044.27503-1-ruscur@russell.cc>
 <20181210070044.27503-3-ruscur@russell.cc>
 <3b213170-9b93-cb71-b0c2-220ea31dbdea@c-s.fr>
 <5ff8b24e-a748-19d3-8651-b626dd676ea4@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
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
Cc: mikey@neuling.org, kernel-hardening@lists.openwall.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-01-25 at 12:45 +0100, Christophe Leroy wrote:
> Hi Russel,
> 
> Le 17/12/2018 à 08:09, Christophe Leroy a écrit :
> > Hi Russel,
> > 
> > Le 10/12/2018 à 08:00, Russell Currey a écrit :
> > > __patch_instruction() is called in early boot, and uses
> > > __put_user_size(), which includes the locks and unlocks for KUAP,
> > > which could either be called too early, or in the Radix case,
> > > forced to
> > > use "early_" versions of functions just to safely handle this one
> > > case.
> > 
> > Looking at x86, I see that __put_user_size() doesn't includes the
> > locks. 
> > The lock/unlock is do by callers. I'll do the same.
> > 
> > 
> > > __put_user_asm() does not do this, and thus is safe to use both
> > > in early
> > > boot, and later on since in this case it should only ever be
> > > touching
> > > kernel memory.
> > > 
> > > __patch_instruction() was previously refactored to use
> > > __put_user_size()
> > > in order to be able to return -EFAULT, which would allow the
> > > kernel to
> > > patch instructions in userspace, which should never happen.  This
> > > has
> > > the functional change of causing faults on userspace addresses if
> > > KUAP
> > > is turned on, which should never happen in practice.
> > > 
> > > A future enhancement could be to double check the patch address
> > > is
> > > definitely allowed to be tampered with by the kernel.
> > 
> > This makes me realise that we are calling lock_user_access() with
> > kernel 
> > addresses. That most likely breaks protection on kernel addresses
> > for 
> > book3s/32. I'll have to work around it.
> > 
> > Another thing I realised also is that get_user() at least is called
> > in 
> > some exceptions/trap handlers. Which means it can be called nested
> > with 
> > an ongoing user access. It means that get_paca()-
> > >user_access_allowed 
> > might be modified during those exceptions/traps.
> 
> Any comment about that ? Isn't it a problem ?

Yes, I think so.  I wonder why I haven't hit this issue, though.  Which
handlers is this an issue with?

Maybe we could do something like...

unlock_user_access() checks if user access is already unlocked (== 1),
if so sets user_access_allowed to 2

lock_user_access() sees that user_access_allowed is 2, and knows it's
nested and sets user_access_allowed back to 1 instead of its usual 0.

...that's pretty gross, though.  It also means that every
implementation has to figure out how to cope with that.

I've done a lot of testing where a) user access hasn't been left
unlocked and b) faults haven't happened where they shouldn't, so I
wonder how I could try and hit such a case.

Could also have a get_user() without locking that's only allowed to be
used by exception handlers...

I dunno.  Open to better ideas.

- Russell
> 
> Christophe
> 
> > Christophe
> > 
> > > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > > ---
> > >   arch/powerpc/lib/code-patching.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/lib/code-patching.c 
> > > b/arch/powerpc/lib/code-patching.c
> > > index 89502cbccb1b..15e8c6339960 100644
> > > --- a/arch/powerpc/lib/code-patching.c
> > > +++ b/arch/powerpc/lib/code-patching.c
> > > @@ -26,9 +26,9 @@
> > >   static int __patch_instruction(unsigned int *exec_addr,
> > > unsigned int 
> > > instr,
> > >                      unsigned int *patch_addr)
> > >   {
> > > -    int err;
> > > +    int err = 0;
> > > -    __put_user_size(instr, patch_addr, 4, err);
> > > +    __put_user_asm(instr, patch_addr, err, "stw");
> > >       if (err)
> > >           return err;
> > > 

