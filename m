Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F2EC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 11:37:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2EC2082D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 11:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="guBils2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2EC2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BnPN1j0pzDrgP
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 22:37:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.b="guBils2t";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=alien8.de
 (client-ip=5.9.137.197; helo=mail.skyhub.de; envelope-from=bp@alien8.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=alien8.de header.i=@alien8.de header.b="guBils2t"; 
 dkim-atps=neutral
X-Greylist: delayed 138008 seconds by postgrey-1.36 at bilbo;
 Sat, 08 Dec 2018 22:33:30 AEDT
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BnK646RmzDrQb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 22:33:25 +1100 (AEDT)
Received: from zn.tnic (p200300EC2BDEA700C0511CCA78411630.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bde:a700:c051:1cca:7841:1630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 121791EC08EA;
 Sat,  8 Dec 2018 12:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1544268801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=B5CDGzsrX4V2SXTubOP+f8uhJVd6TTji+V4DFVcJN34=;
 b=guBils2tX8g7UeBlevew8xBHYpWMggzF17cKwsrB0DCM0BRU/CiKDvNVApeuhOfeSdj09X
 fJ3Rn0+KM0u7RNMVZVpuDsLvjBYIBlUgevxdj+K5py2eZRASQeEsC5Y3UuXZbeiCW983E6
 gJEtxZZMqeRSaByiSh1zpy5cRuZsKMw=
Date: Sat, 8 Dec 2018 12:33:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/2] x86, powerpc: remove -funit-at-a-time compiler
 option entirely
Message-ID: <20181208113313.GD30399@zn.tnic>
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
 <87k1lia6bd.fsf@concordia.ellerman.id.au>
 <CAK7LNARbzF9-ZYvX7U76HqC957Fj=U3rmQfCEYXKqZNV8SFmNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARbzF9-ZYvX7U76HqC957Fj=U3rmQfCEYXKqZNV8SFmNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Richard Weinberger <richard@sigma-star.at>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 08, 2018 at 03:36:52PM +0900, Masahiro Yamada wrote:
> x86 maintainers,
> 
> Ping.

You got the required ACKs. If you want me to carry this one and the
UML one through the tip tree, lemme know. Or you can do what Richard
suggested. Your call.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
