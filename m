Return-Path: <SRS0=d5Dh=4V=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D8CC3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 15:37:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D33220870
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 15:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FQKMY/tg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FQKMY/tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D33220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48XdLR6pw3zDqSc
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Mar 2020 02:37:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=hansenpartnership.com (client-ip=66.63.167.143;
 helo=bedivere.hansenpartnership.com;
 envelope-from=james.bottomley@hansenpartnership.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=HansenPartnership.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=hansenpartnership.com header.i=@hansenpartnership.com
 header.a=rsa-sha256 header.s=20151216 header.b=FQKMY/tg; 
 dkim=pass (1024-bit key) header.d=hansenpartnership.com
 header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216
 header.b=FQKMY/tg; dkim-atps=neutral
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48XdHw5gnvzDqSN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2020 02:35:39 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id BB8D68EE11D;
 Wed,  4 Mar 2020 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
 s=20151216; t=1583336135;
 bh=yvUo8IjzRxclOUjv2L0BqatO0ZoZ57dg6J4dJmfyKiE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=FQKMY/tgJYu79uu/Ab1FOmQPT/juFlN89GT+e2FMpLZ8cqHx1ddwMw2iKV4d/5zZy
 0TqIUW+PmiFiMBkPi8i1o+M9tTlJoTA2jWGZZl877fmTR0miZrpGDWaEbOVlk1rBdv
 Dy2XC5ARK0cSRzxALmpMKLJon41wBtUk0gNzmOI0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id f31uS89INl0f; Wed,  4 Mar 2020 07:35:35 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com
 (jarvis.ext.hansenpartnership.com [153.66.160.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C59938EE0FC;
 Wed,  4 Mar 2020 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
 s=20151216; t=1583336135;
 bh=yvUo8IjzRxclOUjv2L0BqatO0ZoZ57dg6J4dJmfyKiE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=FQKMY/tgJYu79uu/Ab1FOmQPT/juFlN89GT+e2FMpLZ8cqHx1ddwMw2iKV4d/5zZy
 0TqIUW+PmiFiMBkPi8i1o+M9tTlJoTA2jWGZZl877fmTR0miZrpGDWaEbOVlk1rBdv
 Dy2XC5ARK0cSRzxALmpMKLJon41wBtUk0gNzmOI0=
Message-ID: <1583336133.3284.1.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] ima: add a new CONFIG for loading arch-specific
 policies
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, 
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Date: Wed, 04 Mar 2020 07:35:33 -0800
In-Reply-To: <1583325309.6264.23.camel@linux.ibm.com>
References: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com>
 <1583307813.3907.4.camel@HansenPartnership.com>
 <1583325309.6264.23.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Philipp Rudo <prudo@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2020-03-04 at 07:35 -0500, Mimi Zohar wrote:
> On Tue, 2020-03-03 at 23:43 -0800, James Bottomley wrote:
> > On Tue, 2020-03-03 at 21:33 -0500, Nayna Jain wrote:
> > > diff --git a/security/integrity/ima/Kconfig
> > > b/security/integrity/ima/Kconfig
> > > index 3f3ee4e2eb0d..d17972aa413a 100644
> > > --- a/security/integrity/ima/Kconfig
> > > +++ b/security/integrity/ima/Kconfig
> > > @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
> > >  	depends on IMA_MEASURE_ASYMMETRIC_KEYS
> > >  	depends on SYSTEM_TRUSTED_KEYRING
> > >  	default y
> > > +
> > > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > > +	bool
> > > +	depends on IMA
> > > +	depends on IMA_ARCH_POLICY
> > > +	default n
> > 
> > You can't do this: a symbol designed to be selected can't depend on
> > other symbols because Kconfig doesn't see the dependencies during
> > select.  We even have a doc for this now:
> > 
> > Documentation/kbuild/Kconfig.select-break
> 
> The document is discussing a circular dependency, where C selects B.
>  IMA_SECURE_AND_OR_TRUSTED_BOOT is not selecting anything, but is
> being selected.  All of the Kconfig's are now dependent on
> IMA_ARCH_POLICY being enabled before selecting
> IMA_SECURE_AND_OR_TRUSTED_BOOT.
> 
> As Ard pointed out, both IMA and IMA_ARCH_POLICY are not needed, as
> IMA_ARCH_POLICY is already dependent on IMA.

Then removing them is fine, if they're not necessary ... you just can't
 select a symbol with dependencies because the two Kconfig mechanisms
don't mix.

James

