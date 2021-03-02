Return-Path: <SRS0=ynH/=IA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E47C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 22:49:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C6664EED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 22:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C6664EED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DqslC0L4Nz3ccj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 09:49:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FoEWol+U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=FoEWol+U; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dqskn3fhNz30N6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Mar 2021 09:49:20 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Dqskk3fWpz9sRR;
 Wed,  3 Mar 2021 09:49:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1614725359;
 bh=HFXBoTB9QkIdpfj1nthDl4GEiFA8/e8waHgz50PRC8I=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FoEWol+UK+GJoezLROpzsabdlUI03TbZ4RDyPvqk3eDCGhyynEf972LjugnqBrJIz
 OPCWA2PWLBK0S3xQNe/T4dHP5oe6TrnfPp/4b+FmS7t0gAdslcRp/IGhSRGTXwJRZD
 eGqsvxvXt+syiaFA/17r59OhQOC0P/4j3CuETrYmyKNhwqq8DU8E+icn+mOaoTfc/j
 IFywYYKkO5/M1IXpJS6E0SWjQ62oMk1hV5NEYWlmRx7ZrxRr0pn4Mq7WQ7p26D8jrJ
 bKbU3+cfxYG+1L4o/wPfydWM2fRHrt4NhzGBkvbf64opIEA2eExypKkfl7d3fhHo3J
 fyV1WT+IWN0RA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the powerpc-fixes tree
In-Reply-To: <6113ab65-7b3c-07f0-2813-76ddaa4c7236@kleine-koenig.org>
References: <20210302112131.5bb7b08b@canb.auug.org.au>
 <87pn0is3wg.fsf@mpe.ellerman.id.au>
 <6113ab65-7b3c-07f0-2813-76ddaa4c7236@kleine-koenig.org>
Date: Wed, 03 Mar 2021 09:49:15 +1100
Message-ID: <87eegxrx1w.fsf@mpe.ellerman.id.au>
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org> writes:
> Hello,
>
> On 3/2/21 3:09 AM, Michael Ellerman wrote:
>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>>> Hi all,
>>>
>>> After merging the powerpc-fixes tree, today's linux-next build (powerpc
>>> allyesconfig) failed like this:
>>>
>>> drivers/net/ethernet/ibm/ibmvnic.c:5399:13: error: conflicting types fo=
r 'ibmvnic_remove'
>>>   5399 | static void ibmvnic_remove(struct vio_dev *dev)
>>>        |             ^~~~~~~~~~~~~~
>>> drivers/net/ethernet/ibm/ibmvnic.c:81:12: note: previous declaration of=
 'ibmvnic_remove' was here
>>>     81 | static int ibmvnic_remove(struct vio_dev *);
>>>        |            ^~~~~~~~~~~~~~
>>>
>>> Caused by commit
>>>
>>>    1bdd1e6f9320 ("vio: make remove callback return void")
>>=20
>> Gah, is IBMVNIC in any of our defconfigs?! ... no it's not.
>
> Would you accept a patch to add the driver to one of the defconfigs as=20
> an excuse for the build breakage I created?

Thanks, but I already sent a patch adding it.

We should really have these drivers enabled in our defconfig, so that's
on us.

cheers
