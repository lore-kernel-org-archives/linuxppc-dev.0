Return-Path: <SRS0=AUN+=F4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15856C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Dec 2020 01:07:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A7B22517
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Dec 2020 01:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A7B22517
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D1X3x74t5zDqPm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Dec 2020 12:07:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D1X244C6YzDqDd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2020 12:05:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=fCiucknv; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4D1X2320TZz9sWX;
 Thu, 24 Dec 2020 12:05:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1608771947;
 bh=CL3AnHOz06mrGbhgw6tM4Noc2JcCqYwI4iu0BsEovkk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fCiucknv8nL9x1/qU3U+wOdvGZCd6NIyqFGZNxwe605kmn9m1Y3iU8lFekIv/MbRs
 KgGzk4os0Uj70EK6ulPJd7VEB/AQ69hubpSEAJWOObpUa+6aAr8XTjyTuCebWT+IIR
 1g+Ah5eczZ3TvJu6EGtfjazPe1waUuPVZPr8SspE4WzGXxMPdhuQQX8ZRBIWqsnBGL
 3Mhqes70K5LsI366MyIQYkfrqbSmj6PeBXXCvXVqiNumGlNbB3PTUm1yZbVPNfNdKl
 AyX6R+0tuTJR2sjq+JBZYo0LwVWw45rFcAHo6DWSkwpktYqfyRM0rwBuTt7TEE6/B5
 U7zEYoB7AsUNg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/32s: Fix RTAS machine check with VMAP stack
In-Reply-To: <6ed0b74d-8d01-4a20-faed-891496fb77b4@csgroup.eu>
References: <bc77d61d1c18940e456a2dee464f1e2eda65a3f0.1608621048.git.christophe.leroy@csgroup.eu>
 <6ed0b74d-8d01-4a20-faed-891496fb77b4@csgroup.eu>
Date: Thu, 24 Dec 2020 12:05:43 +1100
Message-ID: <87im8s6mjc.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 22/12/2020 =C3=A0 08:11, Christophe Leroy a =C3=A9crit=C2=A0:
>> When we have VMAP stack, exception prolog 1 sets r1, not r11.
>
> But exception prolog 1 uses r1 to setup r1 when machine check happens in =
kernel.
> So r1 must be restored when the branch is not taken. See subsequent patch=
 I just sent out.

OK. This is still on the tip of fixes, so I'll rewind it to drop this
commit, and then apply this and the fixup as one patch next week.

cheers
