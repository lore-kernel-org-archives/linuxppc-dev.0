Return-Path: <linuxppc-dev+bounces-22749-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B574CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 20:56:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggbkC1sGTz2xHK;
	Thu, 18 Jun 2026 06:56:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781729779;
	cv=none; b=TADZkOXYdYvz6M2dLiChX9A3OOt3EGehRsgyjbTgPpxY7acQFiddKMCmAygV5ANzJD9ChNmWDVVWA3M09e13YhPpDRBcOcR0asHD6a3ZCMtCD4ZPThJ1Zxkadm8eGP/jSGZsiRmfFQu0KCH0c4FRS6Bl9lkPC4a8rtfGWDZkVpXndQUXU1N6MysHjx3nnP5LkM2f3E/rTeT2RDrimOdf2LFsLrJ0PYSW2HZ6kDs+eMlMrp+U+CAEzi/hFd160Bd5eEjP8oKK+H7jlAfRyD09gFyjbo0aRNAHMChgKiH4nsq7wycWzFPGl/ZA/HclXX0TSBrdDLxCE48/HvVVhgO5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781729779; c=relaxed/relaxed;
	bh=A1dicipAfT1NcihzDB7nuXRVGuGocmFyEPV9zA3acUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+f3W4l+R3w+BIW/XqmeSLFlm3dLmyy7KPXk+U1xPoq5EqCiMOvEIxG6O4nDy33hTK9VJb2vGXgh+zsYoaHyg3pxS9YhCwBVyzAGEUvhzu36EaArvNveAgOoikU/3PVNvoDBlJqR1in+vMehQJomIbHEpxeWokO/1R0nman0ZmmIMryCl2V7uOCSKYGjFOVo9MJm+mE+A60Z6p5ONGRokUy1KZ8aaE+v3TPHkzALnYIPUrVv5NW3Ry77S1kWGsgeAcYWHTj6p1viom7Z0KGwnFb3YsMxQmEL2Dtc1nilsWnA/BoCAdFPs57JtpSEKbfX5odeazv2pn2fb3v4ympdgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+JgIxG8; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+JgIxG8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggbkB0PjGz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 06:56:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D0C186001D;
	Wed, 17 Jun 2026 20:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093671F000E9;
	Wed, 17 Jun 2026 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729774;
	bh=A1dicipAfT1NcihzDB7nuXRVGuGocmFyEPV9zA3acUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C+JgIxG8rwASDaFmpA6Zh29sHsXjVxomoiRH3OhPa889meEEW3u5FNT+dBtjSW/hw
	 D6sNaxoXruVEdJRs2TCBxuP28EcnIXSc5VAkaakRwBoxec3mO22QwXPEm1o8g68Ynd
	 8T8I2IgLVzXJB6nmke5oXdYS2A9totgcEQtmZtRlGO3HONE15zQQ/88bLpmm74eGQi
	 DWjnBfcuUlDaTgEjHaexYiGs3ETfD/34gnzgEP8hZqrBB2wyy4XzJUiGfxVPSxD1H2
	 c194yBAZig9SafF4ckJpaak40F8YXNFSE9LJCbVAb2fsNOLIPxGH8mSNw03gXnsF9u
	 w4PgjTaHOYmEg==
Message-ID: <01cc3ac9-c89e-491c-86ed-4c4c90809075@kernel.org>
Date: Wed, 17 Jun 2026 22:56:00 +0200
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
Subject: Re: [PATCH 00/19] init: discoverable root partitions, a.k.a. an
 omittable "root=" cmdline option
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 linux-alpha@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
References: <20260615-discoverable-root_partitions-v1-0-39c78fac42e2@kernel.org>
 <20260617-irritation-rollen-wirst-7d636cbfec92@brauner>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260617-irritation-rollen-wirst-7d636cbfec92@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2026 at 14:41, Christian Brauner wrote:
> On Mon, Jun 15, 2026 at 06:08:56PM +0200, Vincent Mailhol wrote:
>> DPS [1] defines GPT partition type UUIDs for OS partitions and
>> attributes that control whether such partitions should be
>> automatically discovered. The specification states that:
>>
>>   The OS can discover and mount the necessary file systems with a
>>   non-existent or incomplete /etc/fstab file and without the root=
>>   kernel command line option.
>>
>> DPS is already implemented in systemd-gpt-auto-generator [2], which,
>> when embedded in an initrd, indeed allows automatic detection of the
>> root filesystem through its partition type UUID.
>>
>> This series adds this discovery feature directly into the kernel so
>> that people who are not using systemd or not using an initrd can still
>> benefit from it. The implementation follows the same model as
>> systemd-gpt-auto-generator:
> 
> I happen to co-maintain the DPS. It is userspace policy and complex
> userspace policy at that and does not belong into the kernel.
> 
> This also implements a really tiny portion of the spec. It deals with a
> lot more complex concepts such as automatic partitioning during
> installation, verity, LUKS, containers. This is really not intended for
> the kernel at all. I mean, it's great that this spec is being used but I
> do not want this in the kernel just for the sake of auto-discovery.

The implementation of a tiny portion is voluntary. If I can draw a
parallel, it would be the same as saying that the root= cmdline option
is a tiny portion of what an fstab can do.

Yes it does not manage the LUKS, containers and so on, the same way it
is not possible to directly boot those things directly from the kernel.

So, I don't think this conflicts with the actual userland
implementations, the same way you can add root= to your command line and
still have an initrd next to it.

I did not intend to write this as a replacement but just as a complement
to fill the gap of kernel with no initrd.

> The DPS is completely generic and can be implemented by tooling other
> than systemd (util-linux implements it and so does refind iirc). I think
> not wanting to use or build alternative userspace tooling for this is a
> really weak argument for pushing this into the kernel.

Well, I might explain to you where I come from. Time to time, I mess up
my configuration. When this issue is in a userland config file (e.g. bad
fstab), the recovery is always easy.

But when I mess up the bootloader firmware configuration (e.g. grub,
u-boot, edk2), the fix is always painful. I have to fight with a shell
with which I am not familiar with to figure out what the correct
configuration is.

And an initrd would help but:

 - it is still one more file to look for pass as a parameter
 - on some machine I do not have one anyway

I think it would have been very neet to have a method to boot a kernel
with zero config (understand here: no cmdline, no initrd) and I find out
that DPS could achieve that if just a tiny part of it were implemented
in the kernel.

For example, in edk2, I would be able to just browse the disk from the
"Boot from file" menu and select a kernel. Currently it panics because
no configuration is attached. With DPS, we could have it boot linux from
that menu. All in a graphical interface, with just up/down arrows and
one enter keypress.

And this is my motivation. This non LUKS root read-only part of the DPS
is the only piece which makes sense for me in the kernel. Not that I
don't *want* to implement it in userland, but just that it doesn't
achieve what would be helpful to me (and I guess others).

I thought I wouldn't be the only one in the world to see value in that
this is why I posted it.


Yours sincerely,
Vincent Mailhol


