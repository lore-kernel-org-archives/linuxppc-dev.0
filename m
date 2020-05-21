Return-Path: <SRS0=dcvz=7D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBC7C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 13:56:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842D8206F6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="U1ummp7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842D8206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49SWPh0J1kzDqlQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 23:56:40 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49SWL95TYXzDqRg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2020 23:53:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=U1ummp7o; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49SWKw5Zjyz9sRf;
 Thu, 21 May 2020 23:53:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1590069215;
 bh=x0gmE3z8OBKdaFX9xEcEKrvKpGE5oUxiR1vLxs+y9m0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=U1ummp7o80EpVG+XHrZ+kY4mdOMj66aPIDu5nh5DSYxAr90UFT/UjNp2Zv20PMhPq
 FutLYG1LwUbwvn8i0fOfPn08DRbaU4pDlYWcByEyHRHQYMEtctNRfa0WgmM8ZBaPhb
 uVYMYUTuMpgq+CMyGEULlRnrrJm9WVjrG4Du9vtHMQmANXcX+VE0M5rEEcE86PnsNS
 Mul59ND40j40D1g5t26BIV6SW9Xbe0Z428Ag6OFLi0HcS/10P0QKyszCzFH/9TqS9j
 6PfjFLvhroAJX5arEVgTI8cNrRF/utxBtxRY+bGX61fCFkKMLmUk28N+hRusHvh1j3
 LWzQ6uAZR8snA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] powerpc: Remove support for ppc405/440 Xilinx
 platforms
In-Reply-To: <33b873a8-ded2-4866-fb70-c336fb325923@csgroup.eu>
References: <cover.1585311091.git.michal.simek@xilinx.com>
 <CAK8P3a2mKPRFbRE3MWScr9GSiL4cpLg0wqv1Q28XDCZVPWgHfg@mail.gmail.com>
 <20200327131026.GT1922688@smile.fi.intel.com>
 <20200327131531.GU1922688@smile.fi.intel.com>
 <CAK8P3a1Z+ZPTDzgAjdz0a7d85R62BhUqkdEWgrwXh-OnYe6rog@mail.gmail.com>
 <20200327141434.GA1922688@smile.fi.intel.com>
 <b5adcc7a-9d10-d75f-50e3-9c150a7b4989@c-s.fr>
 <87mu7xum41.fsf@mpe.ellerman.id.au>
 <bac9af641140cf6df04e3532589a11c2f3bccd2f.camel@kernel.crashing.org>
 <87pncprwp9.fsf@mpe.ellerman.id.au>
 <5782f9a42ad8acd8b234fa9c15a09db93552dc6b.camel@kernel.crashing.org>
 <871roykwu6.fsf@mpe.ellerman.id.au>
 <CAK8P3a1XmeeP7FKfNwXZO8cXyJ_U_Jr0kjOaGZ6F=7OcoZ+0nw@mail.gmail.com>
 <87zha17otl.fsf@mpe.ellerman.id.au>
 <33b873a8-ded2-4866-fb70-c336fb325923@csgroup.eu>
Date: Thu, 21 May 2020 23:53:45 +1000
Message-ID: <87o8qhgzrq.fsf@mpe.ellerman.id.au>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>,
 Richard Fontana <rfontana@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Sasha Levin <sashal@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 Masahiro Yamada <masahiroy@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 YueHaibing <yuehaibing@huawei.com>, Michal Simek <michal.simek@xilinx.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Leonardo Bras <leonardo@linux.ibm.com>, DTML <devicetree@vger.kernel.org>,
 Andrew Donnellan <ajd@linux.ibm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>,
 Mark Brown <broonie@kernel.org>, git@xilinx.com,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Allison Randal <allison@lohutok.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Michal Simek <monstr@monstr.eu>,
 Wei Hu <weh@microsoft.com>, Christian Lamparter <chunkeey@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Armijn Hemel <armijn@tjaldur.nl>, Rob Herring <robh+dt@kernel.org>,
 Enrico Weigelt <info@metux.net>, "David S. Miller" <davem@davemloft.net>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 21/05/2020 =C3=A0 09:02, Michael Ellerman a =C3=A9crit=C2=A0:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>> +On Wed, Apr 8, 2020 at 2:04 PM Michael Ellerman <mpe@ellerman.id.au> w=
rote:
>>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>>>> On Fri, 2020-04-03 at 15:59 +1100, Michael Ellerman wrote:
>>>>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>>>> IBM still put 40x cores inside POWER chips no ?
>>>>
>>>> Oh yeah that's true. I guess most folks don't know that, or that they
>>>> run RHEL on them.
>>>
>>> Is there a reason for not having those dts files in mainline then?
>>> If nothing else, it would document what machines are still being
>>> used with future kernels.
>>=20
>> Sorry that part was a joke :D  Those chips don't run Linux.
>>=20
>
> Nice to know :)
>
> What's the plan then, do we still want to keep 40x in the kernel ?

I guess we keep it for now.

Perhaps we mark it BROKEN for a few releases and see if anyone
complains?

> If yes, is it ok to drop the oldies anyway as done in my series=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D172630 ?

Yeah let's do it. I would love to get rid of that horrible
PPC405_ERR77() sprinkled all through our atomics.

> (Note that this series will conflict with my series on hugepages on 8xx=20
> due to the PTE_ATOMIC_UPDATES stuff. I can rebase the 40x modernisation=20
> series on top of the 8xx hugepages series if it is worth it)

Yeah if you can rebase that would be great.

cheers
