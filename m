Return-Path: <SRS0=Sk7F=Y7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6291FC5DF60
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 11:25:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C2F2187F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 11:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Ml77gR1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C2F2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4781KY3GFyzF36v
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 22:25:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4781Fc4lH3zF63k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2019 22:21:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="Ml77gR1F"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4781FY6nbkz9sPk;
 Thu,  7 Nov 2019 22:21:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1573125714;
 bh=SQjOUdmp2dtdcIZfeEWQOp+PIbNXiuzVApc6kLzPTKY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Ml77gR1Fw0n0YfITP4YrFd8lvFF3z05cSaeBXVnkc773KQxpPdng3SHv3ImLfW1dQ
 TmyY0wG5hy2lBweYfx4hOFVDTyBEUKftNjpsPHmXAgyJyqKWACQYAHarbG7rPK4SEN
 cG4xCqDtSu4ZiEMfQnQ8CB88m4tSVmpxoWiffIgpSC7FBZQXKcEK22QzeGL9QdRUld
 LNVlWGOzhUgjSPQHl7u1D3AEaSw6TGNZpOEiHUPKE4+uxn8X90JWEGyX0RkV+85n6F
 0OVVNrBzl15/VgDri0u4WuV0PCvwT2IRvrVaaZjocWET8WzcFY77w3N/ydjZCYJwRK
 UmAznZIU67zvw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "christophe.leroy\@c-s.fr" <christophe.leroy@c-s.fr>,
 "paulus\@samba.org" <paulus@samba.org>,
 "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
 "malat\@debian.org" <malat@debian.org>
Subject: Re: [PATCH v3] powerpc: Support CMDLINE_EXTEND
In-Reply-To: <46da00814535270a2b525de1f75afc79f3abbf5c.camel@alliedtelesis.co.nz>
References: <20190801225006.21952-1-chris.packham@alliedtelesis.co.nz>
 <9262a291-161f-e172-9d13-88a717da9de4@c-s.fr>
 <46da00814535270a2b525de1f75afc79f3abbf5c.camel@alliedtelesis.co.nz>
Date: Thu, 07 Nov 2019 22:21:47 +1100
Message-ID: <87eeyk53uc.fsf@mpe.ellerman.id.au>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
> Hi All,
>
> On Fri, 2019-08-02 at 06:40 +0200, Christophe Leroy wrote:
>>=20
>> Le 02/08/2019 =C3=A0 00:50, Chris Packham a =C3=A9crit :
>> > Bring powerpc in line with other architectures that support extending =
or
>> > overriding the bootloader provided command line.
>> >=20
>> > The current behaviour is most like CMDLINE_FROM_BOOTLOADER where the
>> > bootloader command line is preferred but the kernel config can provide=
 a
>> > fallback so CMDLINE_FROM_BOOTLOADER is the default. CMDLINE_EXTEND can
>> > be used to append the CMDLINE from the kernel config to the one provid=
ed
>> > by the bootloader.
>> >=20
>> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>=20
>> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> Just going over some old patches this doesn't appear to be in next. Is
> there anything stopping it from being accepted?

Just me not being overloaded :/, sorry.

Have put it in my next-test branch, which means it should appear in next
in the next few days.

cheers
