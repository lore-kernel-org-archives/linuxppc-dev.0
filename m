Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA51606A323
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ZAEZsjJp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q9DTKFid
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT38s3GxPz2xqL;
	Tue, 17 Nov 2026 09:54:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794869693;
	cv=none; b=hyH2V8hbBDzlWXdQOkpJRO82Hj1AGCPumFqVY5m0nI2cCypUPZ5sX/2r57g0zllwb36gVeRauWSuNVo+LWt47IrI+C/F7StKpWEEngS0zhtB9QQwCcF/jRCRc63+OdPVo+uh+vIlDCOISIg2VDBL2SF2bNeEHOjVXIS1Lwf1WURRvfb6bmIj2V0bi/jmFCnKTUoeg8BZc+ZWw4fzxzO/aDH52UFJpJ3lMCRcd2y5/OyIRYX4hBinpbdYOyRjgr4GwVtizaMj9MkuQmkZv2K6zSmg6v7dsKY6FsdYjKYphNoFbzM2gDAXmIfJz31Av3Z+d41ngBXsNAdz3skQMmN7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794869693; c=relaxed/relaxed;
	bh=OcAgC0vPJKwVGXFjWubBy/YnWKV2HmzIb3LAukpGicE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LBKCkvZDQO1/8Nbp8AVhmqC6zyXUjNTH1k5QQqWJ6R+dq0ErfJng8wjNlG9/BBBBbgmUb8oD34Dj/oHTF+raKa7NboP5tMHCjVli2Hjbdtvb4giS+CfrsLpDhqnTlXQOLk2yfyza7YFn/PqiLr4LJGn0slTTV+W+91fd8wKLMtbgKA6ZbYsdHUNmeFeOj/MTkp0gHOTBItWUuBKgbIcLa3TKr4fRFpy/UEGok6zNzsVYDJVs+33GJovgeQvkPVAwJPgkBO+8TORr3JDc8UKWSOzwD+BcbeWHGaUJ47T/5LBqUbYuh4UNSXwTgSoSeka3bqKAI6WH5t1fuqR3eIiA1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ZAEZsjJp; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q9DTKFid; dkim-atps=neutral; spf=pass (client-ip=103.168.172.158; helo=fhigh-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ZAEZsjJp;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q9DTKFid;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.158; helo=fhigh-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT38n6GcLz2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:54:49 +1100 (AEDT)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C0CE14000BF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 17:54:46 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 16 Nov 2026 17:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794869676;
	 x=1794956076; bh=OcAgC0vPJKwVGXFjWubBy/YnWKV2HmzIb3LAukpGicE=; b=
	ZAEZsjJpuRQxEFpNlUZgnShZrgORqdVNh9DyAVrLzb30qXR61XfYqoRaMrobLuH7
	zynLG+rLBei2d6LgTseF6/Qsv0f0k1bSxFNPhydlhTdo/E9jaEWpZr6jf2snhjJs
	p0PpdLtt2tVJhmRpWzkyXLsm8oFMA6LSBx1DIh5f5tytnmoUCfswTljpraIgofMx
	qnZ0sXkBEg3LeqYbdeM8Xg13BM0yd86FTDqd8f4Mv/KE3QWnlWRJfSmsD01uU/1H
	JunDVoj1Br6H+nLAhOO8aw4xRwlI9knNWnRUBQ3rRPBPMTP8YYfPZrVCep0r1l+S
	J1Eq2NaURUS3F4BmXDxbug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794869676; x=
	1794956076; bh=OcAgC0vPJKwVGXFjWubBy/YnWKV2HmzIb3LAukpGicE=; b=Q
	9DTKFidW8SGMQlcttnyM4KM7l8Rlgdl9JoiGLBTw6vGhuH8Hfvif5fJcsK4bxJjB
	3JnDCurQWCL01lfJmu8Cf+xXWjlRixgLbKW8ghg0iAw0TvBpR++etMHvXWbQD8bh
	4/WKFb3GuG31YwtYvfsoNpmB3P3/ANhmuRyqtPuBwfOC8j3xN/26CXSVqH+SrO5p
	O+/xL7q7fBGdD4UVk99LKvPfMrkuhR7MUQeX/LQvkdnYSkl+BCLGKvSzl17iTAuk
	hzAYTGHTC/YUqlqxDn/mlX1L2RhqbypIjTpxRAxj3FT49uj24+M3VOXay7eWdo4n
	XWRpG/d3k259KP5mbuBrg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794869676; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:FbzYD0zJdCbmefleLOWJS4umDKtATsUmXsgnBuFgJ61nS0d
	56stiu83xDDJvFtnr9uCtZONeKNffOG4ckQAnaS982Nm3C0KC+qnQE1V8acAA3Rg
	u3hVOY/pEndcc7iqyY37kIQk0alBcbTlTEbxJAenyOl2C0XLuvVPyeU2pRBWLm3X
	g6n+3l6uDe5AIEQUcRq8KttsdKVDirEJsc83Hm96O7EcCjpq1H0mQIPfRUtPu/29
	F/28d2l2nLB0MMlvtaFUIla/rfii2CN6NuRD7D3WsQRxdr3PBbh4+N5h/ysOqD3N
	BkKewVvxehYV7lGGM2Ku13U70iL7yybsjyWmykA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1FLIZhGqarwOJSnywNEf9XRvfjOg2CpkcYCnEGQdU5s=:upc1O8MhVk6W6DXMUXoKnCzT5vlTeKI3ptx/dGWzRao=;
X-ME-Sender: <xms:n4n7agXZ7ONsA579anVWRWvWK3svLhzxYQfKUya7zUY1ECSI3W_Lbg>
    <xme:n4n7ava4_Rif4XI_kTldl2Wv16XH4NtzaWT80AdcO4Cjg7P6MK9hW95CISU6e8D6_
    QnupqNF6Fvqc2g4aAIuK_wItjOGMAkT3AueMOqtQZHuHCHrR5p_jBn_>
X-ME-Proxy-Cause: dmFkZTGYHYRRTDjHLNMRLa12I41RV/zEUX5WZz+wz6jwGtrJt9YQLDiiD2umaL7QU8Y/qB
    iECjbl6aYU3q/0J7B2Zv7XwkLq2NTuAEl2lYzsFFfzHWIDRX7QGqZ1wrfNYzqWAAcxs3UP
    zvZ+yvxg01oDoRtpjdbpnQ5iFomwiYQpkHZLDJfw2rM0QquV3UEg8Lu+BITL/63EjH/G0L
    9qX9B5G+BCW0tG+4+s9LQPza5D6BLo+3wbITjCE9Rcy4y29konmMAOurewxT6Tr++S90dq
    cPHsImnluo8UikP6vG7g8wbS+eVlCp2LkEpHP56AJbqT3gqaj++5oFCkPJUPgxaZwLqpI8
    o00H6vIP2RSQYTyqnEalaSnYha3EWtY6uexVC8QlipwsgATE2m+gKnCgbyJDNbuipj3G8w
    SmwWpamBMJcnBAQF/lbbPBnnFP/wgmf16VVFk6brqBLtE8xqQY+s+i22wcrHn8BTOv79ac
    j/NZa7vV/IHjryko7kye/LXI7qW6XF7hZtp6gP2Uu19TYjVFBoVo3EondqK0SPD4vg1u3i
    guWhisYm11KjBFmyjpxNcXvaOST6ywxyTQycc8dB3YRWh7j5pHwlNFCuzfRYoY3WBr9MsW
    tlZrbtmDiKz6ymb9We4Cdj8O9Mq1lm4HDsHp9Xg9gqmHT3qq4J6qZY2GbJBQ
X-ME-Proxy: <xmx:pIn7ak8JY2mxHGkdnBacSQy0_YDqn8uAk8TXcVv0K-3nd2I73f0fZQ>
    <xmx:pIn7as3QY15meRWmJe33ONUEWlbPLODGhW_9dkJeGI2R03y9_R8Z6g>
    <xmx:pIn7an1z6hs-ML_bz8h_Ewbl3CzeMOdh0LhclBXpEMzkuPQEsNTU7Q>
    <xmx:pIn7aou5xvc1t6CKTaftA8otrpULQ6opJOJTRpeIghqsWVPUMxaptg>
    <xmx:rIn7atQNXqBX-b-MS9Yz8DIBNXfiyAH74u8AsH8C_963fMr413skDJfy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 373F832A009F; Mon, 16 Nov 2026 17:54:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwZDIwU2rPTF
Date: Mon, 16 Nov 2026 23:54:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <chleroy@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-mm@kvack.org
Cc: "Andreas Larsson" <andreas@gaisler.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
 "Jason Gunthorpe" <jgg@nvidia.com>, "Linus Walleij" <linusw@kernel.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Lucas Stach" <l.stach@pengutronix.de>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Malin Jonsson" <malin.jonsson@est.tech>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>, "Michal Simek" <monstr@monstr.eu>,
 "Mike Rapoport" <rppt@kernel.org>, "Nicholas Piggin" <npiggin@gmail.com>,
 "Nishanth Menon" <nm@ti.com>, "Richard Weinberger" <richard@nod.at>,
 "Russell King" <linux@armlinux.org.uk>,
 "Thomas Gleixner" <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Message-Id: <83495d02-4e09-40f0-94fe-e57a1e73d1a3@app.fastmail.com>
In-Reply-To: <afebfaf5-f3ee-4234-875d-e5ebf1ee64fd@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
 <20261116124832.662455-5-arnd@kernel.org>
 <afebfaf5-f3ee-4234-875d-e5ebf1ee64fd@kernel.org>
Subject: Re: [PATCH v3 04/10] powerpc: kvm: allow flexible PAGE_OFFSET
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026, at 14:38, Christophe Leroy (CS GROUP) wrote:
> Le 16/11/2026 =C3=A0 13:48, Arnd Bergmann a =C3=A9crit=C2=A0:
>> diff --git a/arch/powerpc/kvm/book3s_32_sr.S b/arch/powerpc/kvm/book3=
s_32_sr.S
>> index 6cfcd20d4668..0d8a7857f2bd 100644
>> --- a/arch/powerpc/kvm/book3s_32_sr.S
>> +++ b/arch/powerpc/kvm/book3s_32_sr.S
>> @@ -113,8 +113,8 @@
>>  =20
>>           li      r0, 4
>>           mtctr   r0
>> -	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * 0xc))
>> -        lis     r4, 0xc000
>> +	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * (PAGE_OFFSET >> 28)))
>> +        lis     r4, (PAGE_OFFSET >> 16)
>
> This is not enough I think. You need to load ctr with the number of=20
> segments you want to populate. Here above it is hardcoded to 4.

Ok, trying this one now

--- a/arch/powerpc/kvm/book3s_32_sr.S
+++ b/arch/powerpc/kvm/book3s_32_sr.S
@@ -107,14 +107,12 @@
        KVM_LOAD_BAT(2, r9, r10, r11)
        KVM_LOAD_BAT(3, r9, r10, r11)
=20
-       /* Restore Segment Registers */
-
-       /* 0xc - 0xf */
-
-        li      r0, 4
+       /* Restore Segment Registers, assumes PAGE_OFFSET is segment ali=
gned */
+        li      r0, (0x100000000 - PAGE_OFFSET) >> 28
         mtctr   r0
-       LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * 0xc))
-        lis     r4, 0xc000
+       LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * (PAGE_OFFSET >> 28)=
))
+
+        lis     r4, PAGE_OFFSET@h
 3:      mtsrin  r3, r4
         addi    r3, r3, 0x111     /* increment VSID */
         addis   r4, r4, 0x1000    /* address of next segment */

>>   	/* Restore host IVPR before re-enabling interrupts. We cheat and k=
now
>> -	 * that Linux IVPR is always 0xc0000000. */
>> -	lis	r3, 0xc000
>> +	 * that Linux IVPR is always PAGE_OFFSET. */
>> +	lis	r3, PAGE_OFFSET >> 16
>
> Maybe use PAGE_OFFSET@h instead of PAGE_OFFSET >> 16.
>
>>   	mtspr	SPRN_IVPR, r3
>
> That's probably valid but wouldn't it be more correct to use=20
> interrupt_base@h as in head_44x.S and head_85xx.S :
>
> 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
> 	mtspr	SPRN_IVPR,r4

Ok, copying that version now:

--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -229,9 +229,8 @@ _GLOBAL(kvmppc_resume_host)
        mtspr   SPRN_PID1, r3
 #endif
=20
-       /* Restore host IVPR before re-enabling interrupts. We cheat and=
 know
-        * that Linux IVPR is always PAGE_OFFSET. */
-       lis     r3, PAGE_OFFSET >> 16
+       /* Restore host IVPR before re-enabling interrupts. */
+       lis     r3, interrupt_base@h    /* IVPR only uses the high 16-bi=
ts */
        mtspr   SPRN_IVPR, r3
=20
        /* Switch to kernel stack and jump to handler. */

>> @@ -115,7 +115,8 @@ static u32 get_host_mas0(unsigned long eaddr)
>>   	mtspr(SPRN_MAS6, 0);
>>   	mas4 =3D mfspr(SPRN_MAS4);
>>   	mtspr(SPRN_MAS4, mas4 & ~MAS4_TLBSEL_MASK);
>> -	asm volatile("tlbsx 0, %0" : : "b" (eaddr & ~CONFIG_PAGE_OFFSET));
>> +	asm volatile("tlbsx 0, %0" :
>> +		: "b" (eaddr & (rounddown_pow_of_two(PAGE_OFFSET)-1)));
>
> I think this is not valid.
>
> With PAGE_OFFSET equal to 0xc0000000,
>
> Before:
>
> eaddr & 0x3fffffff
>
> Now:
>
> eaddr & (0x80000000 - 1) =3D eaddr & 0x7fffffff

I'm probably still misunderstanding the intention of this code then,
my reading of the comment was that both 0x3fffffff and 0x7fffffff
would be valid choices here as both are below PAGE_OFFSET and
large enough to alias the correct set.

What are the actual requirements for the mask?

Thanks for looking at these bits in detail, I'm quite out of my
comfort zone here, especially with the book-e stuff.

        Arnd

