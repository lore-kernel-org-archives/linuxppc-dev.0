Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FBFC433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 15:54:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F8F2080D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 15:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F8F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sguazz.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1Rnm3b1rzDqw4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 01:54:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=centrum.lixper.it (client-ip=46.4.16.148; helo=centrum.lixper.it;
 envelope-from=srs0=ts6c=as=sguazz.it=giuseppe@centrum.lixper.it;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sguazz.it
Received: from centrum.lixper.it (centrum.lixper.it [46.4.16.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1RMC6m15zDqvy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2020 01:34:45 +1000 (AEST)
Received: from net-130-25-222-52.cust.vodafonedsl.it ([130.25.222.52]
 helo=uefi)
 by centrum.lixper.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <giuseppe@sguazz.it>)
 id 1jspcG-0006t9-JA
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Jul 2020 17:34:41 +0200
Message-ID: <990279c219476c4d513df52454adf583de32641a.camel@sguazz.it>
Subject: Re: kernel since 5.6 do not boot anymore on Apple PowerBook
From: Giuseppe Sacco <giuseppe@sguazz.it>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 07 Jul 2020 17:34:35 +0200
In-Reply-To: <64815669-5282-f74f-efc6-6c4c376fb602@csgroup.eu>
References: <89e412a76350b28f791bb8a2b6f9647a034f6fc8.camel@sguazz.it>
 <04544f16-fb20-54b9-e56e-47d45af03b6c@csgroup.eu>
 <c98f8586c16c86bb9b4485138bbabce9f15c282b.camel@sguazz.it>
 <64815669-5282-f74f-efc6-6c4c376fb602@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GeoIP: IT
X-SRS: Sender address rewritten from <giuseppe@sguazz.it> to
 <SRS0=Ts6C=AS=sguazz.it=giuseppe@centrum.lixper.it> by centrum.lixper.it.
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Il giorno mar, 07/07/2020 alle 16.52 +0200, Christophe Leroy ha
scritto:
> 
> Le 07/07/2020 à 16:03, Giuseppe Sacco a écrit :
> > Hello Cristophe,
> > 
> > > Can you tell which defconfig you use or provide your .config
> > 
> > You may get the standard one from debian or a reduced one that I
> > made on purpose. The latter is here:
> > https://eppesuigoccas.homedns.org/~giuseppe/config-5.4.50.gz
> >  (boot)
> > https://eppesuigoccas.homedns.org/~giuseppe/config-5.6.19.gz
> >  (no boot)
> 
> Thanks
> 
> Can you provide the complete output when it works, so that I can see 
> what is after the place it stops when it fails.

Here it is:
https://eppesuigoccas.homedns.org/~giuseppe/dmesg-5.4.40-minimo.gz

> And can you try without CONFIG_VMAP_STACK on 5.6.19

Sure, I'll let you know.

Thank you,
Giuseppe

