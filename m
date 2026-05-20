Return-Path: <linuxppc-dev+bounces-21217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF239CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 08:51:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL4yq1WY9z2xqv;
	Wed, 20 May 2026 18:51:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779267091;
	cv=none; b=ZkWwEw2pX0hFs4Fofym+0c95/YdTE9LMBZISjN/I7xMcg5+KJYSN2F01i+JpjvxqqAqTCvercYqbSeuVyLJfy2y3IceKC0PSip3/94qziq2BIHvza+nvqFkLBdcrG3YYH8y5kaxJL+Zir/4OBNI8dzU3kJYNS0DsAbseQ91AK4jxAFCa/WTn5MlmKO3DbdhKN3xieXigbtV7ej/GAb/0uQr8kzLr1LA1uobz/PmWPl88oEjS3Y8kNXRRjpkfkU277438c7N/xb+WWDWYdKAJGL7VjSzTXl0nqQ9LWT7sXks9qCSmhAzNYYIkiD0dVr8/KmPKYOQhaIbqNkzXZxRSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779267091; c=relaxed/relaxed;
	bh=KVGbQSGJqboMkQGEaBuh2n5D9Rw1MUG1r1v6327U8ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzV944GZc4LlQLDg/adwwHFAdUd+UvBaGkXFOJl+RbddMjAhpNTkwj3Bcl7FYmKS4pRDleyhnUml1ZFBMxBduZTjsLJBVPsQS36exkT6yaS7qYKRnB5zYQT5kSKssCWOR4M8CLRs2Cfz3hy/5B0g9M7WasP3NakVPQ+1rPZmyyuqu7yMlENjoIYUYPe5XfKpo8i+W+j9wN/n2pgt7P5guyEh4hwOmdis7UBV/dg2841q0xOaHH/CVqtyqVvfxi7jZJtp08t1OqIpgbKqGlX923Sy4EiRV4GJDynmx0NvK07rkj3tXETbwW/E9OA57U01bPABSiHzo/e5QQaXxDv84Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.a=rsa-sha256 header.s=s31663417 header.b=YLUbgQxR; dkim-atps=neutral; spf=pass (client-ip=212.227.15.15; helo=mout.gmx.net; envelope-from=quwenruo.btrfs@gmx.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.a=rsa-sha256 header.s=s31663417 header.b=YLUbgQxR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com (client-ip=212.227.15.15; helo=mout.gmx.net; envelope-from=quwenruo.btrfs@gmx.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 538 seconds by postgrey-1.37 at boromir; Wed, 20 May 2026 18:51:27 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL4yl0zgfz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 18:51:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1779267016; x=1779871816; i=quwenruo.btrfs@gmx.com;
	bh=KVGbQSGJqboMkQGEaBuh2n5D9Rw1MUG1r1v6327U8ig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YLUbgQxR5QvM+EMmdtqQKsawDTlqjY9MKdCFb/joPmzKUmOc4OLHAegzhsTwEsTZ
	 bBCdAGPEgTch0CLg7mwgul+qyn6D6lr6wrkPt77EamEwjPeMesT9yUP4OM2aw+poY
	 RPVlMvpCxFrqIhbinbz+PNBdvco0T5FRy9MXzu6Xsf2oBlXn7OxY4qlSgGd7lkjHG
	 jiGhRhNWKEoTUgxkael17vZQGD5oidK03J69xZRreYrLoLunqTx12bPmzqOW7bo53
	 aw7u2nVnbGpgUT7npHzxn7k6wkh/1wtHaqCTV18gya4n2ynFWreYInndgXokcufxR
	 XE6feTvK18Wck3mRng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTqW-1wtkYJ26tS-00KAV0; Wed, 20
 May 2026 10:41:30 +0200
Message-ID: <f46636c8-80ba-4802-a6a0-74cbc35e7bee@gmx.com>
Date: Wed, 20 May 2026 18:11:09 +0930
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
To: Christoph Hellwig <hch@lst.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: kreijack@inwind.it, David Sterba <dsterba@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 Song Liu <song@kernel.org>,
 Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
 Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-raid@vger.kernel.org
References: <20260512052230.2947683-1-hch@lst.de>
 <20260512052230.2947683-2-hch@lst.de> <20260512114231.GG2558453@suse.cz>
 <20260513054742.GA1018@lst.de>
 <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it>
 <20260515043705.GA3855@lst.de>
 <34C16854-1065-4542-8836-DDED58EC1844@zytor.com>
 <20260518051207.GB9374@lst.de>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20260518051207.GB9374@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dvYkZM9TiFDCY/a0OvC9eApZvlSwcJd3UwtLDS5MwAZMjs7M4Nd
 LicIaUhdRQfptJSOREFXlXXwIu6efRES75IROjxURvlDWzg8rXGNi60K4CTQXbKTh9THL/c
 wJ3/QeMKkDZW8kmACTTO7VjjFLSoLau+o3l06KjnXZ62BokkLWYoMVcl2p/DM4z+IpoUtZb
 i5VmwtojDyLUB+n1WFCOg==
UI-OutboundReport: notjunk:1;M01:P0:I1WRZZrpweQ=;guzwcn1FG5zB/VqGjp//5r0lEaW
 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



=E5=9C=A8 2026/5/18 14:42, Christoph Hellwig =E5=86=99=E9=81=93:
> On Fri, May 15, 2026 at 12:59:34PM -0700, H. Peter Anvin wrote:
>> I don't think this is a good idea. Error out; it is the btrfs maintaine=
rs' job to ensure user data isn't lost.
>>
>> The RAID-6 code has *never* supported only 3 units, and if it ever work=
ed for *any* of the implementations it was purely by accident. Speaking as=
 the original author I should know; this was deliberate as in some cases t=
he degenerate case (3) would have required extra trays in the code to no u=
ser benefit.
>>
>> I would not be surprised if the kernel crashed or corrupted the page ca=
che in that case.
>=20
> It does, that's why I wanted to exclude it.  Anyway, for the about to be
> resent version I'll drop this btrfs patch over the stated objection and
> will otherwise not change anything.  This means the (IMHO hypothetical)
> users of this configuration will get a WARN_ON_ONCE triggered, but
> otherwise keep working (or rather not working) as before.
>=20

For the btrfs part, I believe I can get the current 2-disk-raid5 and=20
3-disk-raid6 to fallback to raid1 inside btrfs.

I hope the btrfs part can be finished and reach the next merge window,=20
but I'm not 100% sure.

What is the planned cycle to merge this raid5/6 cleanup?

Thanks,
Qu

