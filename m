Return-Path: <linuxppc-dev+bounces-25479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BFCC55838
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 08:01:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hG08p5RBnz304x;
	Thu, 06 Aug 2026 18:01:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786003274;
	cv=none; b=JTTyxAChtlOZzfRpl/9xSzGz/JLuHZr6yA1XpSgKy8J1wY2basBObZzojlmeAlxZEQSJGsKzujOPYkTE6XoGtLmJbLUtp5Gmnn4oUUnvTnfEOoy1IZn1TxdRMe1fJGNntZ/r5esnB3n37BazGoy0uGfgZNzNXFRhgs2krUYlDSNOKZOPF7beaJThHkJ5wIdZ/s/V2R6twEHYIo7h4Yjp+GiDm7X/OcMRA1H+E7vgyBO5yO2RawI2xIPYXU8rSFqaYwSvmov9MPYQo8wGAzuneCpXAFdjs+uTwgow/s3jorEQ+aw40gDbs5K4exEgm3ferdR9chMenF8pmNAOAyUjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786003274; c=relaxed/relaxed;
	bh=LD9ImqlIwH6oeN7pmBkN0TXKzq62mCPW1c400six0EM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SRqMBiRoGV1jNE4VjEiTEdLfWp6xW/1IeQUkoYPRVFoUm/RdPyCOxPL74iAGlhZSCl+f4sQNlrzjzDijZg9d9sMQSkqEjQoVhI3ryJTh6MddVCaDt7a0O1t7QfgRhF3VrGuibsimaq6FUWwTrBbwYA1rPE89eU1X26Y1lTAat8k72332N3lp97y84PDeKdS5gimEj5aPqg+yEpL+mOPHSGNB0Ch/wiYYqW/bNt8SKwz44udm32IEdZDhCzRElYiSP1qIEnH/YYN6KKgu3tm73XNK5/l1KONZt/Da1uvu0GRnkd47rWa4447p8uoZsU6/1tUhACNzNEUTvqyOmQZeQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=flapping.org; dkim=pass (2048-bit key; unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=egPJEGkj; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZWijIyTZ; dkim-atps=neutral; spf=pass (client-ip=103.168.172.142; helo=flow-a7-smtp.messagingengine.com; envelope-from=tomo@flapping.org; receiver=lists.ozlabs.org) smtp.mailfrom=flapping.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=egPJEGkj;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZWijIyTZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flapping.org (client-ip=103.168.172.142; helo=flow-a7-smtp.messagingengine.com; envelope-from=tomo@flapping.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 448 seconds by postgrey-1.37 at boromir; Thu, 06 Aug 2026 18:01:11 AEST
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hG08l4yyXz2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 18:01:11 +1000 (AEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 63DA6138020C;
	Thu,  6 Aug 2026 03:53:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 03:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786002818;
	 x=1786006418; bh=LD9ImqlIwH6oeN7pmBkN0TXKzq62mCPW1c400six0EM=; b=
	egPJEGkjiHQFhksFyQs6njKum2R6mjsKp77i7wKapRMZytD/ZMCUf6skygPzuCOP
	+islbK1gtxlkCIKS1mZg/6zOJ/zebc+DTvbH46mCB5YJouplVK503uRqq7W15I/o
	3TgO48JjjlnSaL0YcH3UoKNGRkmzLcgsbYDPbBjfmF3WeJIw/rw80wvazrsz+/xt
	391na+sZX7WxAZbeMVMhRnRvtrYYlaS0D7OwFckvyIv9wUAoENYDq5bCm9u8zkN5
	yFhvIWjhHXh0imufYp/Ou/xYEKENAl9Y2L4lnioa9/u74xxtsvMocdSw6yBs84aB
	h9ZpKmCJYt68sgE6nXGuhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786002818; x=
	1786006418; bh=LD9ImqlIwH6oeN7pmBkN0TXKzq62mCPW1c400six0EM=; b=Z
	WijIyTZVqCgYF8yEJsG9No+5i1j/eLJ4jHZnEiVZUztXSOYRW2kpLiPpXctlzrvd
	QjG9lS1udZ0s4VwyJATEGHIBpwQ4mKEokFZi1POoTAmESpd/wCo3QvyLOmOXu30G
	S3VwfLAy42HT4otDBGdCh3X1sNbrdsmjC8diS/7Un0/yOcAVQQF6xGzp4hyUcy0P
	MO+gPOU/YN+Q5kYAo2yzwJTHhUvW23qiduRIL0hBmulv6qMpYAuGFqou/OLY5csf
	4+14uuM71HYvnsDayhIGyhIFkrAoyAcKOQgNVtWRtU4SfkjReU238fTBr+9pZLRu
	zbzv0mRvDGOKV/lPWHp8w==
X-ME-Sender: <xms:gD10atsuyjsKUGFggi9pHLdlrO9l2L-0Xw54vpyijCZgrUKv_iHXFw>
    <xme:gD10ariDFCROd4tfT0-1IOZLsUSGolX0CkJcm4k8MdJ76gYxKX9HonMn-mV0YgGXg
    aqRBIW0S4wsA85c4J55d0lyti7662mELieircjuYxos5GagAo8_PPwb>
X-ME-Received: <xmr:gD10atyq2bOYKHFLYZ0HNTKNtS7Y7QbfYmuS7F1kTqEkJfQclF0Pk7FT0CZqjxbJ42w0JQOjPZH-qAfd-uQ3H2iU>
X-ME-Proxy-Cause: dmFkZTFbzfkfUcr/Inba17tKt3JJ3fMrX1N2IUQX31//l4d7tbGDIvsDLekSwrzIspHZhe
    o+VTNd8j7u+Iie4/vsjYzHSLs0OWqSktFzQQhv8+NgGQIag2veIThRlj6+GB4jPUZxbvRv
    7OcvW9OzYxQuUr1i11mPCdpCcP7JRmOC0AJubMcCqZzfBmd1SK+vQp2JnmKLkWhMihSU6c
    fuDLRKKIqB0TdhjglBxB6X+eg2BrSYejmwu+bPOgNY8XxzIAOT7HNAjxMRX3DU+DWoXY+3
    iqGQXmHWNriOrJNH10CsO0qMQAf0vVKqv3pavtuHNTRXYCSn7ZXnVkmSYj7XLAxVtRClJ5
    uMxrtDYXoXwt9dN3I6Zq2DXu0tisA4QU9oyBVOhL/MGaUvPN7ENRu1ubiEqgWezdnSFkGd
    R+WSh6dUTjILfP/1fC8AHH9gAYn1ifQx8fttklkGOY9PvdOInMy9A2QWtcBTVoKuq4ZJ87
    jGRPUzoTJn3s/Z85CJAyst7sBa7zZyubtPJDRIXnzVy4moi33ZTVd73Yow/k2k93qDJoPn
    ujLeIUX8ykSirlln1YstkTapUdKLSL+ZlQz92GTjCPH3yT2ke++BySC86l/RQ8xt9yHtpq
    HuQ5KAsbuce3wRDzwJuS1P1E6hwRg/AlR2acSfHVRXzCEhfs1zUl4PXcH5Jg
X-ME-Proxy: <xmx:gD10ah4JLuOZHllR0vjlTCUtzn-Mc5_uuX65vuzFNNPm_EyBpFehJg>
    <xmx:gD10avdsAz76rOQyAp-33iSXydJPZZ1b0Zgq1DMJi_-_OwSSQaVdcA>
    <xmx:gD10appd7HS1t5mf-1wS6rEoYY6l6WqnOPKEdonqQWVh2-JLyYqbiA>
    <xmx:gD10aj1L7da9tdvfPV6TtI5ekFlRIJ2Z_J0Ytzk0_II-t1ZwjfeLag>
    <xmx:gT10agEzz7xbZ8Ik0es4bQ2PmLSZWo8Vxh-Sz_rMo4P0HwUZ3ojOOAA8>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 03:53:28 -0400 (EDT)
Date: Thu, 06 Aug 2026 16:53:26 +0900 (JST)
Message-Id: <20260806.165326.1361973663671179487.tomo@flapping.org>
To: chleroy@kernel.org
Cc: tomo@flapping.org, linkmauve@linkmauve.fr, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com,
 rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
 daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
 work@onurozkan.dev, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, fujita.tomonori@gmail.com,
 joelagnelf@nvidia.com, gregkh@linuxfoundation.org, prafulrai522@gmail.com,
 nsc@kernel.org, japo@linux.ibm.com, lina+kernel@asahilina.net,
 j@jannau.net, airlied@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev, mkchauras@gmail.com
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <d347de18-10ee-41e9-a672-b08f70bc88e4@kernel.org>
References: <anG67Q6Y59kDqh-c@desktop>
	<20260804.224035.269658578200153488.tomo@flapping.org>
	<d347de18-10ee-41e9-a672-b08f70bc88e4@kernel.org>
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
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Aug 2026 14:56:41 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> =

> =

> Le 04/08/2026 =E0 15:40, FUJITA Tomonori a =E9crit=A0:
>> [Vous ne recevez pas souvent de courriers de
>> tomo@flapping.org. D?couvrez pourquoi ceci est important ?
>> https://aka.ms/LearnAboutSenderIdentification ]
>> On Tue, 4 Aug 2026 12:11:57 +0200
>> Link Mauve <linkmauve@linkmauve.fr> wrote:
>> =

>>> Hi,
>>>
>>> On Mon, Aug 03, 2026 at 12:27:13PM +0530, Madhavan Srinivasan wrote=
:
>>>> On Wed, 08 Jul 2026 13:54:47 +0530, Mukesh Kumar Chaurasiya (IBM)
>>>> wrote:
>>>>> Enable experimental rust support for ppc64le and ppc32be. The pat=
ch
>>>>> for
>>>>> ppc32 has been provided by Link Mauve[1] and ppc64le support[2] h=
as
>>>>> been
>>>>> merged over it. ppc32 needs some toolchain fixes mentioned in the=

>>>>> patch
>>>>> `rust: Add PowerPC support` and the discussion for that is done
>>>>> here[1].
>>>>>
>>>>> This has been tested on
>>>>> - powernv9 hardware
>>>>> - pseries P11 hardware
>>>>> - pseries(9, 10) qemu
>>>>> - powernv(9, 10) qemu
>>>>> - rustdoc on x86 and powerpc64le
>>>>> - rusttest on x86 and powerpc64le
>>>>>
>>>>> [...]
>>>>
>>>> Applied to powerpc/next.
>>>>
>>>> [1/7] rust: Fix "multiple candidates for rmeta dependency core" er=
ror
>>>>        https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgit.kernel.org%2Fpowerpc%2Fc%2F00cdfd072c709c608606461d7d44d46=
13119bfa9&data=3D05%7C02%7Cchristophe.leroy%40csgroup.eu%7C34e4deafcc1d=
41c1738a08def22e01b0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63921=
4476617198585%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7=
C&sdata=3D4qQe1qS37TGv6%2Bf9H56kWVqMYSAHsWiDx5oz8WHZ8%2Bg%3D&reserved=3D=
0
>>>> [2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER=
 is
>>>> disabled
>>>>        https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgit.kernel.org%2Fpowerpc%2Fc%2Fbe809b60cbb61aab96179f44ac36702=
42ae72996&data=3D05%7C02%7Cchristophe.leroy%40csgroup.eu%7C34e4deafcc1d=
41c1738a08def22e01b0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63921=
4476617235654%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7=
C&sdata=3Dcw2l64D3ah%2FM3pxFmvMpUnNmcqcSvN3RFoDiYAIR76g%3D&reserved=3D0=

>>>> [3/7] powerpc/jump_label: adjust inline asm to be consistent
>>>>        https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgit.kernel.org%2Fpowerpc%2Fc%2F13244c0a40139fe66c4c5c5655f4d73=
2a6002957&data=3D05%7C02%7Cchristophe.leroy%40csgroup.eu%7C34e4deafcc1d=
41c1738a08def22e01b0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63921=
4476617259593%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7=
C&sdata=3DxNvcH9k5RA5ktJupn90VdDuwx4YBvezuDcapqKlYfjs%3D&reserved=3D0
>>>> [4/7] rust/powerpc: Set min rustc version for powerpc
>>>>        https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgit.kernel.org%2Fpowerpc%2Fc%2Fe299147cdc8e19c6421a6b7863dc82a=
35b09d967&data=3D05%7C02%7Cchristophe.leroy%40csgroup.eu%7C34e4deafcc1d=
41c1738a08def22e01b0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63921=
4476617280683%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7=
C&sdata=3DuNZA7AulROQGv%2B2l4M%2FqC5W4ncWktRoSRRp8eaF%2FcCY%3D&reserved=
=3D0
>>>> [5/7] rust: Make __udivdi3() and __umoddi3() panic
>>>>        https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgit.kernel.org%2Fpowerpc%2Fc%2Fc93c194e4ee71a734986fd99a8b1ec9=
fbb7a9b8b&data=3D05%7C02%7Cchristophe.leroy%40csgroup.eu%7C34e4deafcc1d=
41c1738a08def22e01b0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63921=
4476617303292%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7=
C&sdata=3DznZPWXM7k5FpRlekIyUN1bHzmMyk1YESR56WsiwBuMA%3D&reserved=3D0
>>>> [6/7] rust: Add PowerPC support
>>>>        https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgit.kernel.org%2Fpowerpc%2Fc%2F73b741adb264967093ef4eb59905618=
a7e0d0de0&data=3D05%7C02%7Cchristophe.leroy%40csgroup.eu%7C34e4deafcc1d=
41c1738a08def22e01b0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63921=
4476617326590%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7=
C&sdata=3DaFHGhd7RX%2Ft5%2BMjqt6pBmIKPKAKmFEQndKP1F%2F8HSxk%3D&reserved=
=3D0
>>>> [7/7] powerpc: Enable Rust for ppc64le
>>>>        https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgit.kernel.org%2Fpowerpc%2Fc%2Fbc87cbdb952e9223616b839d64bdb47=
23aa2ed1d&data=3D05%7C02%7Cchristophe.leroy%40csgroup.eu%7C34e4deafcc1d=
41c1738a08def22e01b0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63921=
4476617346994%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7=
C&sdata=3DITEFv9C1CSUVLqJNe5Y8sStUE3KoOVYVzSzbP0qis74%3D&reserved=3D0
>>>>
>>>> cheers
>>>>
>>>
>>> I just tested those again in linux-next, with the Wii support serie=
s
>>> on
>>> top, but now the kernel fails to build due to ARCH_WARN_ASM and
>>> ARCH_WARN_REACHABLE not being defined on PowerPC:
>>> ```
>>> error: no rules expected `ARCH_WARN_ASM`
>>>     --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_wa=
rn_asm.rs:1:28
>>>      |
>>>    1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}",=

>>>    "{flags}", "{size}"))
>>>      |                            ^^^^^^^^^^^^^ no rules expected t=
his token in macro call
>>>      |
>>>     ::: ../rust/kernel/lib.rs:279:1
>>>      |
>>> 279 | macro_rules! concat_literals {
>>>      | ---------------------------- when calling this macro
>>>      |
>>>      =3D note: while trying to match sequence start
>>>
>>> error: no rules expected `ARCH_WARN_REACHABLE`
>>>     --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_re=
achable_asm.rs:1:28
>>>      |
>>>    1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
>>>      |                            ^^^^^^^^^^^^^^^^^^^ no rules expe=
cted this token in macro call
>>>      |
>>>     ::: ../rust/kernel/lib.rs:279:1
>>>      |
>>> 279 | macro_rules! concat_literals {
>>>      | ---------------------------- when calling this macro
>>>      |
>>>      =3D note: while trying to match sequence start
>>>
>>> error: aborting due to 2 previous errors
>>> ```
>>>
>>> This is in addition to the bindings::kvfree_call_rcu() call, but th=
at
>>> one is already being handled in a different thread.
>> Looks like powerpc needs something like the followings:
>> diff --git a/arch/powerpc/include/asm/bug.h
>> b/arch/powerpc/include/asm/bug.h
>> index 0db48977c70c..8aba39e0cf26 100644
>> --- a/arch/powerpc/include/asm/bug.h
>> +++ b/arch/powerpc/include/asm/bug.h
>> @@ -32,34 +32,38 @@
>>   #endif /* verbose */
>>   #else /* !__ASSEMBLER__ */
>> -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags=

>> -and
>> -   sizeof(struct bug_entry), respectively */
>>   #ifdef CONFIG_DEBUG_BUGVERBOSE
>> -#define _EMIT_BUG_ENTRY                                \
>> +#define _EMIT_BUG_ENTRY(file, line, flags)     \
>>          ".section __bug_table,\"aw\"\n"         \
>>          "2:     .4byte 1b - .\n"                \
>> -       "       .4byte %0 - .\n"                \
>> -       "       .short %1, %2\n"                \
>> -       ".org 2b+%3\n"                          \
>> -       ".previous\n"
>> +       "       .4byte " file " - .\n"          \
>> +       "       .short " line ", " flags "\n"
>>   #else
>> -#define _EMIT_BUG_ENTRY                                \
>> +#define _EMIT_BUG_ENTRY(file, line, flags)     \
>>          ".section __bug_table,\"aw\"\n"         \
>>          "2:     .4byte 1b - .\n"                \
>> -       "       .short %2\n"                    \
>> -       ".org 2b+%3\n"                          \
>> -       ".previous\n"
>> +       "       .short " flags "\n"
>>   #endif
>>   #define BUG_ENTRY(cond_str, insn, flags, ...)          \
>>          __asm__ __volatile__(                           \
>>                  "1:     " insn "\n"                     \
>> -               _EMIT_BUG_ENTRY                         \
>> +               _EMIT_BUG_ENTRY("%0", "%1", "%2")       \
>> +               ".org 2b+%3\n"                          \
>> +               ".previous\n"                           \
>>                  : : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i=
" (__LINE__), \
>>                    "i" (flags),                          \
>>                    "i" (sizeof(struct bug_entry)),       \
>>                    ##__VA_ARGS__)
>> +#define ARCH_WARN_ASM(file, line, flags, size)         \
>> +               "1:     twi 31, 0, 0\n"                 \
>> +               _EMIT_BUG_ENTRY(file, line, flags)      \
>> +               ".org 2b+" size "\n"                    \
>> +               ".previous\n"
> =

> Will this build ? Isn't ARCH_WARN_ASM() for use in ASM .S files ?

No. It's used by Rust code; the C preprocessor uses ARCH_WARN_ASM() to
generate the code for Rust inline assembly.


