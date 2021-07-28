Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B4FC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 12:44:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1C160F9E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 12:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E1C160F9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZYJ85Tdyz3cjj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 22:44:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=UQ/8qIYa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=UQ/8qIYa; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZYHf4Vlwz308L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2021 22:43:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GZYHZ1ybVz9sSs;
 Wed, 28 Jul 2021 22:43:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1627476219;
 bh=Ua9l0fbwYf9DXxQijm/D7Oz8UlSCL9oNqn7tF7luSvs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UQ/8qIYaJRScflx9AwVVfU8McpeRUkUYefqiEfaOVkRXs/DxN86r+qHS+ZTAjrn1D
 lF7JC95nT+52+/MF0/mRtVAwfDY0dzHfTq1ignDIu/4vW+BMSqjBUhlVojjtuDc/DL
 hwdeIQKdlPyRjwuXKGhfLtMpibnFjTF3k3B3hsyqwhvm6e0ZS8Qqvy65eZhR7Si7ln
 NkSd1NITOy6wBYJy7EHTVwFenb+JvprNMuqPQ+svLhxIwsGG4vH6kPNPOn1lK3OhYg
 Pi1AfR1tzasUVFm7Kg3A9FcnwgCfm2cTC4Z0uMwCM4R7GZ5+fcT8h9Kza/UTTrIY6Y
 31aMlFhFzs40w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Christophe
 Leroy <christophe.leroy@csgroup.eu>
Subject: Re: Possible regression by ab037dd87a2f (powerpc/vdso: Switch VDSO
 to generic C implementation.)
In-Reply-To: <4f037af0-5066-ebb9-53a6-733b3bd8eeac@molgen.mpg.de>
References: <a273c619-9258-e29a-24c3-ea47a13c4817@molgen.mpg.de>
 <3661999754da1a5e5c810fa669654cc7db95b059.camel@kernel.crashing.org>
 <4f037af0-5066-ebb9-53a6-733b3bd8eeac@molgen.mpg.de>
Date: Wed, 28 Jul 2021 22:43:36 +1000
Message-ID: <878s1q1udj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Derek Parker <parkerderek86@gmail.com>, Dmitrii Okunev <xaionaro@gmail.com>,
 murp@ibm.com, linuxppc-dev@lists.ozlabs.org, laboger@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Paul Menzel <pmenzel@molgen.mpg.de> writes:
> Am 28.07.21 um 01:14 schrieb Benjamin Herrenschmidt:
>> On Tue, 2021-07-27 at 10:45 +0200, Paul Menzel wrote:
>
>>> On ppc64le Go 1.16.2 from Ubuntu 21.04 terminates with a segmentation
>>> fault [1], and it might be related to *[release-branch.go1.16] runtime:
>>> fix crash during VDSO calls on PowerPC* [2], conjecturing that commit
>>> ab037dd87a2f (powerpc/vdso: Switch VDSO to generic C implementation.)
>>> added in Linux 5.11 causes this.
>>>
>>> If this is indeed the case, this would be a regression in userspace. Is
>>> there a generic fix or should the change be reverted?
>>=20
>> From the look at the links you posted, this appears to be completely
>> broken assumptions by Go that some registers don't change while calling
>> what essentially are external library functions *while inside those
>> functions* (ie in this case from a signal handler).
>>=20
>> I suppose it would be possible to build the VDSO with gcc arguments to
>> make it not use r30, but that's just gross...
>
> Thank you for looking into this. No idea, if it falls under Linux=E2=80=
=99 no=20
> regression policy or not.

Reluctantly yes, I think it does. Though it would have been good if it
had been reported to us sooner.

It looks like that Go fix is only committed to master, and neither of
the latest Go 1.16 or 1.15 releases contain the fix? ie. there's no way
for a user to get a working version of Go other than building master?

I'll see if we can work around it in the kernel. Are you able to test a
kernel patch if I send you one?

cheers
