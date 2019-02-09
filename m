Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F1C282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 19:35:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63F8218D2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 19:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63F8218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xj1c1ZtWzDqT7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 06:35:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stevens-zone.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=darren@stevens-zone.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
X-Greylist: delayed 320 seconds by postgrey-1.36 at bilbo;
 Sun, 10 Feb 2019 06:33:28 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xhzr6Q3PzDqSp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 06:33:27 +1100 (AEDT)
Received: from mintppc.lan ([80.189.87.237]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.179]) with ESMTPA (Nemesis) id
 1MKsf5-1gXRT90vML-00LCWu; Sat, 09 Feb 2019 20:27:58 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: Christoph Hellwig <hch@lst.de>
Date: Sat, 09 Feb 2019 19:26:04 +0000 (GMT)
Message-ID: <4d52ea48c8.6712fa7d@auth.smtp.1and1.co.uk>
In-Reply-To: <20190208091818.GA23491@lst.de>
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
 <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
 <20190208091818.GA23491@lst.de>
User-Agent: YAM/2.9p1 (AmigaOS4; PPC; rv:20140418r7798)
Subject: Re: use generic DMA mapping code in powerpc V4
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xFYHAWvkVGGPZUerWM9X70U6H0psCEByuBL4MKRy9sT3GMXQ/xr
 EqsstRHe/an64RSKV1WPKBYCCn1SLT4y2lNeywqtH5LLOYmsecnHer2LGWZVMQGT8P5URse
 7AnblEEt3JzNCcQbzsNC1G4yvKON7pEl9Prejqko6cCkYyozCCx/c7pcoWd1yn4Pl13paUM
 1PHCg8RJyufZQPnYIDi3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aXpgd0jRgg8=:xCsYWc6Hr9PZYCtBJhfwZl
 xYUBELQXmLjR/ZPz6ADd1iFEezEqS3hIj0yTpJUGhNS4HG+S3vl5qGgniSg7biWHPqmdcNH/S
 zkcAQLelXbS5Ka1utoQV70yODkFs/eALWihK/cUapk36gm/+1hwf3pYBWqx72KRmgoZx5+M5T
 n9dZWLWhtbIsWSGEQlMdo36+ANUc2JFz2Gn5eXiJQWVmut8foaFpBhzt4cwjp/JXbiteArqgP
 b/aJRS42T/B1uneSEi/Cxu24++SqXQI1FQWiNysQSMufGADuqIAkp1ZxBT75xMQGa7xQ77PH8
 2+jj+zGEVrSij+/dz8BafKOeBYmiC1efXaSgcVn/zb/QssoG6gE+vq5dV0GMxkxlt1XCJ9NNb
 nG6zIfqsIvGKycOis9MxpNqkXbp07RV/KHQY2rtblQV3ufoctw89X/ZL55PhurIXMMPcfOL86
 XQhCOCefBi3pbtDzgQrd160gomjFgj6R9lNuO5ZyQWSV+M87sNMOKRyc40yUX1V3utJ5WoOVV
 UKidRm/GA7HW8HVGSMHTBCVQOKe6hoRj3upcwgZkuv4LacAsGlNUZdLj97BthiOEd4zn4Uyt0
 HvJYz9EGgNeqE6PaeQGaRtRPxOBhKgcRb3O/0Pwh7NgRBn1LsjuARvccQy9ziK807VuI2h6Wa
 5jnt/XkH+k7LGShU+t33467QGTNGNQBA0Kf7JpOjHf+3cATF9UryijWmaJhydrPa5wC+NAQA1
 JLVc5jZ5fPZ02EpD0lKGBAaxY3XDrVofdT/ThCtmtSXonmxb7jV/PWPFHeI=
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
Cc: linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Julian Margetson <runaway@candw.ms>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Christoph

On 08/02/2019, Christoph Hellwig wrote:
> On Fri, Feb 08, 2019 at 10:01:46AM +0100, Christian Zigotzky wrote:
>> Hi Christoph,
>>
>> Your new patch fixes the problems with the P.A. Semi Ethernet! :-)
>
> Thanks a lot once again for testing!
>
> Now can you test with this patch and the whole series?
>
> I've updated the powerpc-dma.6 branch to include this fix.

Finally got to compile a working version from this, not sure what was wron=
g with my previous builds...

I've tested on my X5000, all working good so far, in fact my Soundblaster =
live sound card seem=A0to like the changes and works without patching the =
kernel. (Nice)

Not sure when I'll get chance to test on X1000 though.

Regards
Darren

