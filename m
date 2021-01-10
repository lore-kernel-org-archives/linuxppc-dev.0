Return-Path: <SRS0=Om5s=GN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 12:11:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E86C238E5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 12:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E86C238E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DDG0624XYzDqNy
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:11:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=85.215.255.80;
 helo=mo4-p02-ob.smtp.rzone.de; envelope-from=hns@goldelico.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=goldelico.com header.i=@goldelico.com
 header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=egZ1hzH0; 
 dkim-atps=neutral
X-Greylist: delayed 294 seconds by postgrey-1.36 at bilbo;
 Sun, 10 Jan 2021 23:00:11 AEDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DDFlH4GrTzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2021 23:00:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610280007;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:From:
 Subject:Sender;
 bh=suxnFiUZXehwYdxu3HHH3yerlSomJchhrhNdK2IYwzY=;
 b=egZ1hzH0hxBSGQpTQeBaqmzw9ZtW6bXQPs+0CCwJb6f+TeUlMxzDq0494pTzVHhYki
 wJtkHRrHcPJUOQ33pHzS+JSeOSidFyhc4UD47YPuY3mkm76CweCv9S6etFdWGPb8m4CW
 jhnSN1fWa+qYuIVaXQCJOT7UDWXeuvFvLQQlKF7GnkpptLSoaP/sP6yopHXIMCyBnsPi
 c6YKn2HGN3SMaDhU/3lJzd6AWy0NOTiMie7egZnL4+pQfAJG3TfxEtz3/bphsvTDDtV8
 0xHzuc7pNzxBHKNmUl/ZRpe/FXQ3mFfrQoX5/oyURZbUAHr2fqWAqMAyEah3Ks/5NUSe
 cHfQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGHPrrwDOsPyQ="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
 with ESMTPSA id m056b3x0ABrBL8P
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256
 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Sun, 10 Jan 2021 12:53:11 +0100 (CET)
Subject: Re: [patch V3 13/37] mips/mm/highmem: Switch to generic kmap atomic
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=iso-8859-1
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <DUUPMQ.U53A0W7YJPGM@crapouillou.net>
Date: Sun, 10 Jan 2021 12:53:10 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B074439-2E91-4FCF-84C8-82AE13D8C7F0@goldelico.com>
References: <JUTMMQ.NNFWKIUV7UUJ1@crapouillou.net>
 <20210108235805.GA17543@alpha.franken.de>
 <20210109003352.GA18102@alpha.franken.de>
 <DUUPMQ.U53A0W7YJPGM@crapouillou.net>
To: Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3124)
X-Mailman-Approved-At: Sun, 10 Jan 2021 23:04:06 +1100
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
Cc: juri.lelli@redhat.com, linux-aio@kvack.org, airlied@linux.ie,
 nouveau@lists.freedesktop.org, bigeasy@linutronix.de,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 linux-mips <linux-mips@vger.kernel.org>, bsegall@google.com, clm@fb.com,
 ray.huang@amd.com, paulus@samba.org, kraxel@redhat.com,
 sparclinux@vger.kernel.org, deanbo422@gmail.com, hch@lst.de,
 vincent.guittot@linaro.org, paulmck@kernel.org, x86@kernel.org,
 linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@kernel.org,
 peterz@infradead.org, linux-graphics-maintainer@vmware.com, bskeggs@redhat.com,
 airlied@redhat.com, linux-snps-arc@lists.infradead.org, linux-mm@kvack.org,
 mgorman@suse.de, linux-xtensa@linux-xtensa.org, arnd@arndb.de,
 intel-gfx@lists.freedesktop.org, sroland@vmware.com, josef@toxicpanda.com,
 rostedt@goodmis.org, torvalds@linuxfoundation.org, green.hu@gmail.com,
 rodrigo.vivi@intel.com, dsterba@suse.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, dietmar.eggemann@arm.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, chris@zankel.net,
 monstr@monstr.eu, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 nickhu@andestech.com, jcmvbkbc@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 christian.koenig@amd.com, bcrl@kvack.org, spice-devel@lists.freedesktop.org,
 vgupta@synopsys.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 bristot@redhat.com, davem@davemloft.net, linux-btrfs@vger.kernel.org,
 viro@zeniv.linux.org.uk
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


> Am 10.01.2021 um 12:35 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Thomas,
>=20
> Le sam. 9 janv. 2021 =E0 1:33, Thomas Bogendoerfer =
<tsbogend@alpha.franken.de> a =E9crit :
>> On Sat, Jan 09, 2021 at 12:58:05AM +0100, Thomas Bogendoerfer wrote:
>>> On Fri, Jan 08, 2021 at 08:20:43PM +0000, Paul Cercueil wrote:
>>> > Hi Thomas,
>>> >
>>> > 5.11 does not boot anymore on Ingenic SoCs, I bisected it to this =
commit.

Just for completeness, I have no such problems booting CI20/jz4780 or =
Skytone400/jz4730 (unpublished work) with 5.11-rc2.
But may depend on board capabilites (ram size, memory layout or =
something else).

>>> >
>>> > Any idea what could be happening?
>>> not yet, kernel crash log of a Malta QEMU is below.
>> update:
>> This dirty hack lets the Malta QEMU boot again:
>> diff --git a/mm/highmem.c b/mm/highmem.c
>> index c3a9ea7875ef..190cdda1149d 100644
>> --- a/mm/highmem.c
>> +++ b/mm/highmem.c
>> @@ -515,7 +515,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, =
pgprot_t prot)
>> 	vaddr =3D __fix_to_virt(FIX_KMAP_BEGIN + idx);
>> 	BUG_ON(!pte_none(*(kmap_pte - idx)));
>> 	pteval =3D pfn_pte(pfn, prot);
>> -	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
>> +	set_pte(kmap_pte - idx, pteval);
>> 	arch_kmap_local_post_map(vaddr, pteval);
>> 	current->kmap_ctrl.pteval[kmap_local_idx()] =3D pteval;
>> 	preempt_enable();
>> set_pte_at() tries to update cache and could do an kmap_atomic() =
there.
>> Not sure, if this is allowed at this point.
>=20
> Yes, I can confirm that your workaround works here too.
>=20
> Cheers,
> -Paul
>=20
>=20

