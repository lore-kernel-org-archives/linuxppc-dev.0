Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858F9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 10:47:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A06761582
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 10:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A06761582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6JZN593Gz3c2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 21:47:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=CvJWxrHN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=CvJWxrHN; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6JYy234xz3bPH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 21:46:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F6JYs0Q1hz9s1l;
 Fri, 26 Mar 2021 21:46:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616755601;
 bh=doEUsCeV3X5i1gDBs4ejhTJ8hEzuHjNceYhqumx4I8c=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CvJWxrHND/IQHrLjqzdxdAvO4vddm7fnbFKwD8Yt+QHkOiRNl4f41F/S16ky/DDAw
 Wfet+kJFCHg1OZCQ2wFxqko8AoZnF2timySC6HlMMtL3ImyPrTba7l5hHHuacFZHGT
 v+6T+6K/BZVIYLfRgAcDpA451OFwxy8Aim9ueb22uTpstDN/+edihMR6nyOvJsIJOe
 q2PRrOhIH1h7LwuXTJI9UwX4Kx9w90MbYNoL3vFa5NR2wYkVfFRy2xWP8PPmNBHHH2
 ZeFaflEgazK+Fht+MSVXDz9m7B4oMLUq0/hOlS+KI+lncnVB2Qxa9ZQ8XJgrUFrShS
 2Su0UEoA9jHvA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.ibm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: VDSO ELF header
In-Reply-To: <30c51951-332b-7aa8-13ba-44a0b6ae3498@linux.ibm.com>
References: <c45ae4f8-1cbc-c687-b6a2-9a431fafc85c@linux.ibm.com>
 <9366c258-127f-f105-abd1-6baa9a6745c5@csgroup.eu>
 <5b03e966-2cfd-5f0c-c48d-dea5e0001833@linux.ibm.com>
 <30c51951-332b-7aa8-13ba-44a0b6ae3498@linux.ibm.com>
Date: Fri, 26 Mar 2021 21:46:36 +1100
Message-ID: <87blb6gpkj.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Laurent Dufour <ldufour@linux.ibm.com> writes:
> Le 25/03/2021 =C3=A0 17:56, Laurent Dufour a =C3=A9crit=C2=A0:
>> Le 25/03/2021 =C3=A0 17:46, Christophe Leroy a =C3=A9crit=C2=A0:
>>> Le 25/03/2021 =C3=A0 17:11, Laurent Dufour a =C3=A9crit=C2=A0:
>>>> Since v5.11 and the changes you made to the VDSO code, it no more expo=
sing=20
>>>> the ELF header at the beginning of the VDSO mapping in user space.
>>>>
>>>> This is confusing CRIU which is checking for this ELF header cookie=20
>>>> (https://github.com/checkpoint-restore/criu/issues/1417).
>>>
>>> How does it do on other architectures ?
>>=20
>> Good question, I'll double check the CRIU code.
>
> On x86, there are 2 VDSO entries:
> 7ffff7fcb000-7ffff7fce000 r--p 00000000 00:00 0                          =
[vvar]
> 7ffff7fce000-7ffff7fcf000 r-xp 00000000 00:00 0                          =
[vdso]
>
> And the VDSO is starting with the ELF header.
>
>>>> I'm not an expert in loading and ELF part and reading the change you m=
ade, I=20
>>>> can't identify how this could work now as I'm expecting the loader to =
need=20
>>>> that ELF header to do the relocation.
>>>
>>> I think the loader is able to find it at the expected place.
>>=20
>> Actually, it seems the loader relies on the AUX vector AT_SYSINFO_EHDR. =
I guess=20
>> CRIU should do the same.
>>=20
>>>>
>>>> =C2=A0From my investigation it seems that the first bytes of the VDSO =
area are now=20
>>>> the vdso_arch_data.
>>>>
>>>> Is the ELF header put somewhere else?
>>>> How could the loader process the VDSO without that ELF header?
>>>>
>>>
>>> Like most other architectures, we now have the data section as first pa=
ge and=20
>>> the text section follows. So you will likely find the elf header on the=
 second=20
>>> page.
>
> I'm wondering if the data section you're refering to is the vvar section =
I can=20
> see on x86.

Many of the other architectures have separate vm_special_mapping's for
the data page and the vdso binary, where the former is called "vvar".

eg, s390:

static struct vm_special_mapping vvar_mapping =3D {
	.name =3D "[vvar]",
	.fault =3D vvar_fault,
};

static struct vm_special_mapping vdso_mapping =3D {
	.name =3D "[vdso]",
	.mremap =3D vdso_mremap,
};


I guess we probably should be doing that too.

cheers
