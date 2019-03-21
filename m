Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C5C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 21:18:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF101218D4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 21:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF101218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QKQD1h9fzDqPF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 08:18:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QKNR0KbCzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 08:16:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44QKNK0TDpz9tyfT;
 Thu, 21 Mar 2019 22:16:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7jX3PQF3ONST; Thu, 21 Mar 2019 22:16:32 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44QKNJ6Xyyz9tyfS;
 Thu, 21 Mar 2019 22:16:32 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id B689874B; Thu, 21 Mar 2019 22:16:32 +0100 (CET)
Received: from mry91-4-88-160-8-182.fbx.proxad.net
 (mry91-4-88-160-8-182.fbx.proxad.net [88.160.8.182]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Thu, 21 Mar 2019 22:16:32 +0100
Date: Thu, 21 Mar 2019 22:16:32 +0100
Message-ID: <20190321221632.Horde.sUFPCFV5Nrk0KQFVNqmMjw2@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Meelis Roos <mroos@linux.ee>
Subject: Re: powerpc32 boot crash in 5.1-rc1
In-Reply-To: <91966c00-b09f-7e07-89cb-04ac208d5dc1@linux.ee>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
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

Meelis Roos <mroos@linux.ee> a =C3=A9crit=C2=A0:

> While 5.0.0 worked fine on my PowerMac G4, 5.0 + git (unknown rev as=20=
=20
>=20of Mar 13), 5.0.0-11520-gf261c4e and todays git all fail to boot.
>
> The problem seems to be in page fault handler in load_elf_binary()=20=20
>=20of init process.

The patch at https://patchwork.ozlabs.org/patch/1053385/ should fix it

Christophe

>
> Two different screenshots are attached (let's see if they come through).
>
> --=20
>=20Meelis Roos <mroos@linux.ee>


