Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A054C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:29:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2495D20850
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="nDa7Issc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2495D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439jKG6yk4zDr0P
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:29:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="nDa7Issc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::2; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="nDa7Issc"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439hvq4Ck7zDqyq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 04:11:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544116274;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=OrpUZRvMRV5UNzP7aHYj/q/62oXYA3VPNve/bVWT6do=;
 b=nDa7IsscL7EwxnXXESj6TO9QH3OjWacGT4uhARdAhuATv5L4Uyjp95pEw0e0S8jtBc
 sNkvVDLjS1Aux6ifU8MVV9+aCy6JGt0CEgdbgEbr14oz9TGKGf9QFC9r62Mu0FwpyOSZ
 f7s+17zD/pw7ezISM2tFmtUk2BzN/IUzZtTZ6EENq8U83HYLUDuOek/ac+/7oTnGbskB
 SFfnAG1mwhz5sGuLJkpp9kjKbB+0V0W/ug+cFTYqTz1LJcImlsdhw+PbPEhBvAK+dbbW
 Xco7Z8s7GRYEcsBEhT97tpN+bXzo8xvMplLxB0uEN0ZOpFaWsTzMafuIaHjx/HyHR4rC
 zlkg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2Zx2rpgxXYAKMvPcNaPaOxP0g1sEn3/7MhtsWzs"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b10a:5107:60ab:2366:90fb:25ed]
 by smtp.strato.de (RZmta 44.6 AUTH) with ESMTPSA id 404b20uB6HAtoJJ
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 6 Dec 2018 18:10:55 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
Date: Thu, 6 Dec 2018 18:10:54 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <9ECD27D6-B039-4253-9FB9-749B41DE4CC6@xenosoft.de>
References: <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
 <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
 <20181205140550.GA27549@lst.de>
 <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Please don=E2=80=99t merge this code. We are still testing and trying to fig=
ure out where the problems are in the code.

=E2=80=94 Christian

Sent from my iPhone

> On 6. Dec 2018, at 11:55, Christian Zigotzky <chzigotzky@xenosoft.de> wrot=
e:
>=20
>> On 05 December 2018 at 3:05PM, Christoph Hellwig wrote:
>>=20
>> Thanks.  Can you try a few stepping points in the tree?
>>=20
>> First just with commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>> (the first one) applied?
>>=20
>> Second with all commits up to 5da11e49df21f21dac25a2491aa788307bdacb6b
>>=20
>> And if that still works with commits up to
>> c1bfcad4b0cf38ce5b00f7ad880d3a13484c123a
>>=20
> Hi Christoph,
>=20
> I undid the commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6 with the follo=
wing command:
>=20
> git checkout 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>=20
> Result: PASEMI onboard ethernet works again and the P5020 board boots.
>=20
> I will test the other commits in the next days.
>=20
> @All
> It is really important, that you also test Christoph's work on your PASEMI=
 and NXP boards. Could you please help us with solving the issues?
>=20
> 'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'
>=20
> Thanks,
> Christian
>=20
