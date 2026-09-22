Return-Path: <linuxppc-dev+bounces-27916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B3AC982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:26:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpzqM4cKcz2yQJ;
	Tue, 22 Sep 2026 22:26:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=51.210.91.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790064410;
	cv=none; b=VkOOeN2DGF47LDv4qYneIDUHDJJuy2vGrg29Jt0XgcktdeujEH30noOn1W2XkULTUXJBrsWbl3216Uv2TCRvA5j3JiQnm/EHxviMPv+gYgqJNBegFX9lSXqohVsh0yZmSw+d6rtpZQFEH/Q3aqO91ci0g0IA3xDWKFv7qjtF6QbTld78lQZ3i/cBsGf17CXtYy4YSxCboufM5h1asFccKnrQsk01TiqfxsHia4K+IrYpVrH1n1J6MkSWlJKDAcxrBj6mE5wdxJOfDFeAV5A/4oSsYai1euj8ao2fVgrRTQ/oS/LJ0DyGkuN2prbBzXZ2nHnrsQRBXtAIKYM44XHr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790064410; c=relaxed/relaxed;
	bh=5sO9xaC3qdPyU5zJefRGniTGdXKpOQRu0LktrMQP//k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X0pQAeSEdx8y0TGoilzyfmpM1TI59KiZ5q8RW1xqtAkTlvNU9JOIBgIkgXXLtYZA/Hhm8NCEKp9FVpfJKF5E0SjiO5mraFlE/RnhG4oD0wQ4DpTqJo/A4hmHtfGAekeRH3xKcFgCU2hP+N0FElPE6O448O8hkXDzAns4ZS+gPRoZBzNqNbPXV61wGfAmTwBtVeLcCzrqVTY6JdryE26O7Itq+APIz0wqtBbOEkiH4lqC4iQOf6w5036NFtMgBLBOEBT8l08bhyJIZ2hKTjtcgoySkasOXaS1tJElJyX2ugJVasQcXuw17Ap/oVinmI0baxMhKUPkQTtaz8+1lmJq8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=guillain.net; dkim=pass (2048-bit key; unprotected) header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=QI9ARexo; dkim-atps=neutral; spf=pass (client-ip=51.210.91.56; helo=smtpout7.mo540.mail-out.ovh.net; envelope-from=jean-christophe@guillain.net; receiver=lists.ozlabs.org) smtp.mailfrom=guillain.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=guillain.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=QI9ARexo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=guillain.net (client-ip=51.210.91.56; helo=smtpout7.mo540.mail-out.ovh.net; envelope-from=jean-christophe@guillain.net; receiver=lists.ozlabs.org)
Received: from smtpout7.mo540.mail-out.ovh.net (smtpout7.mo540.mail-out.ovh.net [51.210.91.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpt3S5dNbz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:06:42 +1000 (AEST)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [79.137.60.223])
	by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hpt3B757rz41y9;
	Tue, 22 Sep 2026 08:06:30 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <anup@brainfault.org>; Tue, 22 Sep 2026 08:06:30 +0000 (UTC)
Received: from mta10.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.164.229])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hpt3B5XYDz1xrq;
	Tue, 22 Sep 2026 08:06:30 +0000 (UTC)
Received: from guillain.net (unknown [10.1.6.5])
	(Authenticated sender: jean-christophe@guillain.net)
	by mta10.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 9DC82781C5E;
	Tue, 22 Sep 2026 08:06:27 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-97G002b68a12e8-2984-420b-a186-13f4c06436ba,
                    1B11FA1B799B51260FD44711AD952BEFB0E4E6B4) smtp.auth=jean-christophe@guillain.net
X-OVh-ClientIp:78.242.244.78
Message-ID: <792d9ce32849122eed7ecbed22e494f8b624dbc8.camel@guillain.net>
Subject: Re: [PATCH v2 0/7] KVM: Serialize vCPU creation and revert vcpu_ids
 tracking
From: Jean-Christophe Guillain <jean-christophe@guillain.net>
To: Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan	
 <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, Paul Walmsley	
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou	
 <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, Kiryl
 Shutsemau	 <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Atish Patra
 <atish.patra@linux.dev>,  Alexandre Ghiti	 <alex@ghiti.fr>, Dave Hansen
 <dave.hansen@linux.intel.com>, 	linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, 	kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?UTF-8?Q?Pawe=C5=82?= S	 <spawel523@gmail.com>
Date: Tue, 22 Sep 2026 10:06:21 +0200
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
References: <20260921174445.911676-1-seanjc@google.com>
Autocrypt: addr=jean-christophe@guillain.net; prefer-encrypt=mutual;
 keydata=mDMEaEmXaBYJKwYBBAHaRw8BAQdA1qyia8WH1pu6T8sC99WNMyKXooD/SVqJXsJOcnIux
 w20N0plYW4tQ2hyaXN0b3BoZSBHdWlsbGFpbiA8amVhbi1jaHJpc3RvcGhlQGd1aWxsYWluLm5ldD
 6IlgQTFgoAPhYhBDk2+TsBtH9ETCTubi9QTbKhgBdPBQJoSZdoAhsBBQkSzAMABQsJCAcCBhUKCQg
 LAgQWAgMBAh4BAheAAAoJEC9QTbKhgBdPrq0A/icNhFTYLybFWWq1B42UvJLGs18MNRiT5aLdFv3R
 DfHVAQCvzsLrC/qz4rOyIpDzeb0biOu3fiDTcyvV3kPiu3xTDA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
x-ovh-tracer-id: 3964856524915166012
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFDZ4aTcT5SDXmkd602DiweEYgHF4FHP6+h+Q5uvPOfv2ER677KLq0yDhnl+3VfAbnsOmXLuyCPgoyZr+w9DwEYKfDYBsM1GvNB9gelyvBoQQQ1jqTc2VOlb2ES0FKHAEw7Bf5L3b/fe3mquzvbn08slBRFk1e188EYwypcj9s9rZhNO1DYk1mNyKLKeRt/DoUs/s5cymBh82F89HDmI2s1tiBxl8Wr1ZXwxX2zpzSb0PWcSHMqCBDjPAX0FkgCGCL/d6Yl2HIHdXWeJZ1JhfYF+PvruQ1WnjYiU5EVPYFW5Zo8XyORZee15An39kaGtjsRNOOgUE821tWe0jwxcnL/tjXKv+5/16hfPHifvImMPOzEUyeotu4hT4k3MO1mBzM9bjPK0Ge53kXOvdvN3eWSkOwh8ZUiMnTCGvDRHsRriBTLNCO3iKxDfvbsDWv/YF3wOKcvuOaIbT6SyxgcR6Zc8bxUiTYj0J9TfGRfEygMeq2gXCwxFm4Y+Aziu2j67KCrej/IWQcCkXBxtUr8uMovq8EE3D1B62LwAyCKG6fisWjh7fTwVWm14s1BJb0nAGvHicc5WLjJ2cdeknhIvYm7noYy8dltGhFf1/cPZrsEYR1vNt6277gHUY5GuF77GUlPZsEjHlCZnrs5fQ2/CpblZ92YETQlFNm62zJweHxLHQ
DKIM-Signature: a=rsa-sha256; bh=5sO9xaC3qdPyU5zJefRGniTGdXKpOQRu0LktrMQP//k=;
 c=relaxed/relaxed; d=guillain.net; h=From; s=ovhmo31693-selector1;
 t=1790064393; v=1;
 b=QI9ARexol+3F2NhB7XnQCuhvcc5KGGRTJIxVXLliegLGRWPuIPgrRFpRgA9uknVR1Sa4SESl
 T3akrQF/XJwaq5ayxpHCczXK7rf8R+Fd8bNhEQtvvz8sZG2GzLKnoMYc8/tco6QvHsYmJEvMafX
 TtAMbJ/mY7WfJEV981DGq880kXmXrZ/aOpclwoGPTzFqdFq8PEtlxEF7vC12hkkttTJ4mdNv8j9
 1k/pZtD2YR+61OL9hGVtPm8aNlB9Dew1189gXVMM5E9fLxZeFwmZ9tObsD7JYAlWl/ETK3Snl8f
 bfD4os+o5BNLcSdyv+EzHZiBwWmh286ZdNL1qWQljiwiA==

Hi Sean,

Just like for the first version, I tested the full V2 series with the
configuration that originally triggered the build failure
(CONFIG_DEBUG_KERNEL=3Dn, CONFIG_KASAN=3Dn).

The kernel builds successfully on adm64, and I booted the resulting
kernel and started two QEMU/KVM VMs without any issues.

Tested-by: Jean-Christophe Guillain <jean-christophe@guillain.net>

Thanks again !

Cheers,
Jean-Christophe Guillain

