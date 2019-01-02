Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB36C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 21:55:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF7E21479
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 21:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF7E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VPwk4W4ZzDqLn
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 08:55:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stevens-zone.net
 (client-ip=212.227.126.135; helo=mout.kundenserver.de;
 envelope-from=darren@stevens-zone.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
X-Greylist: delayed 319 seconds by postgrey-1.36 at bilbo;
 Thu, 03 Jan 2019 08:53:07 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43VPtW5RDZzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2019 08:53:07 +1100 (AEDT)
Received: from mintppc.lan ([80.189.87.237]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.163]) with ESMTPA (Nemesis) id
 1N2lzA-1hJh3z0aUO-0134yL; Wed, 02 Jan 2019 22:47:35 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Date: Wed, 02 Jan 2019 21:46:51 +0000 (GMT)
Message-ID: <4d20f218a26.60da37fd@auth.smtp.1and1.co.uk>
In-Reply-To: <43MLSx0CY2z9sPY@ozlabs.org>
References: <4c6da03c92f.ac1d78@auth.smtp.1and1.co.uk>
 <43MLSx0CY2z9sPY@ozlabs.org>
User-Agent: YAM/2.9p1 (AmigaOS4; PPC; rv:20140418r7798)
Subject: Re: powerpc/pasemi: Add Nemo board IRQ initroutine
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:WQ6zCPTCRyDObgCs9SBiB7ANzmoex6cBWieyHzwtrbws6GplJx+
 QVEf3VPkgrgvXzf9unQfst4AGOU+WQnp8PlXSJF92IxVhVNVJ8PNZuiST7q/e1+wEvsYk3q
 CAUuNa1jsacpkBezciAES9elQRz4hWz+7UwipnT4EMQreALg5EAVdq0lWtljPtxeu6V99pI
 bL1FXC+FcEC9mDbL/krMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aw7jwJqDUY8=:0Vyvfk21F3dfqg/F/D8YNQ
 a4es0FC0tfUz3a8uLp5OmO8w6Ge1XVpcQ8qfSSAVq7h5eKYyv+k2Cs6duprHC2ZbvVlqoMc1c
 hxa94BSP+bc3NmFgqgMCnr8zR0A0KiRZD52TNwFYuJa36O8ckkY42Ga0EK+NUWtHPk9Pn1EVC
 7BJr02mwKZ+HEr+FGqYGK262lJZ3B5dGnX7g+gYq5pgozIM7LBufpyLAUZ4HOdVzoSizlrbAQ
 W+rvSz//EyrUalE1x14OZAihii4fgkF+S6FxMw7Xldo9TV8gnpSX5j0IZ28VK6xvfuTt4DaS3
 YPCbTpGd63001iHR2KephLplsIYYtXJAGJGohYkNEhFISeZ4z5RDobySyNAebQcLS6mjzOIzB
 rrCYRXfrNOiL3+mO9xxKv8vVCNAHNU3oMpfemiIGrx/3kM6eIH2XToZfOMDW3Yx2Te2nOJdln
 h50MkTPiaUd1uvjXb0DtrvRC8bxCsZttMNvizOTpfzw/f5xO+mW27LoDQAUBfeqMSJVb8rGAi
 LN+cW69vWlLVsecB1+f/g4lXFAeTyaD1aAhoU1x//Dx0VQVCFP4NCXe5lbLNmaeXbTb8FCKDE
 sthPfmslhFBMWwVlfnSvIhNGRuPBCbgOqctS6QPAujEH3g0BOQ7b/LUrxEObwqfOL4nx2drDt
 GXAes6/yx7hRMKZ6uyOR4TRoQdqDJu7umP4h1Hq+59zdoTYyUryJhzc8Rn5MFgACDPjtnVbTp
 WRRjo70EJ2MQVQJcDbvsNoD/qfuuzS1GNMbKMb13SaPICfZ0JYtcn+Sas9Y=
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
Cc: linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Michael

On 22/12/2018, Michael Ellerman wrote:
> On Sun, 2018-08-19 at 20:21:47 UTC, Darren Stevens wrote:
>> Add a IRQ init routine for the Nemo board which inits and attatches
>> the i8259 found in the SB600, and a cascade routine to dispatch the
>> interrupts.
>> 
>> Signed-off-by: Darren Stevens <Darren@stevens-zone.net>
>
> Applied to powerpc next, thanks.

Thankyou very much! We can now build a X1000 kernel without an out-of-tree patch, which is good.

> https://git.kernel.org/powerpc/c/51f4cc2047a4b7e9bf1b49acf06c11

Sorry for not mentioning this earlier(holidays etc..), but this commit has my 4th patch, but the commit message from the 2nd patch. I don't know how, and it is not a major problem, but can we get it updated?

Regards
Darren

