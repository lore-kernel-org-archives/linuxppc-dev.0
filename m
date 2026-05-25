Return-Path: <linuxppc-dev+bounces-21473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07364CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 13:35:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPH1v4kmqz2xfB;
	Mon, 25 May 2026 23:35:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779716115;
	cv=none; b=S0B6iKqYng7tM7GJa/psN5jMRZZ60SSaw+Av9dYrsLwfXBdGnmFOvCj1II9a9dyANkdhMMrvv5F403UZYzeVK5l69nEj2QzMOhZOeIe12585Bs+zbDTiVI1lHfDoYnO0ATTSJ9Rd7h8zpMYAxQEqiNsrQDHPDs59e46oA7h8rY1KePGXJnNykYoSi/BKoUlPr7EvUruWtTCqIyHyYo6jya5/3Rgtqzxrl+j5qL3fF9GRBRcVx98HCTVe5w4Ks8zgb4ziY6uQ6/1/yhWe4sc5a/LpKJZL1KBmE+1v6Z07mKA329rMqXyksZXvQFRZKWkd29wj2NkQgtoI+C8TjpZGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779716115; c=relaxed/relaxed;
	bh=9XVHRPBSt9KXo5wrulw6nEDVPqzcFN/DF35DZwL4F0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6SF8XnxdvpM0MpPnzJnij+Vag8UBy2d9ayogPW1PZ+Adn+O8SslS3C2mgG/gM4lS++cZfdZaPicmZ/DFF/X71q1APD+9VCXJsnxvhUDrPbq/A4uZszpU93Xzz1+fyuUCOLL9gwGLkcfBBQ2iFBBSq1ANdZYcRYDBsVkiQ5Xs346ZS1YA0QLQYjLXEh5DgIxwQWRdGLJXUPKWg93zmOhxvYbO0ZZNFRl+OKGYY8Cs0eRzf38RBLMb1fskmUXPSMdID7PHD2DA9hfCb7DEULoYTuMozAQ8f3UUneNZYMgiyXjeZG9BSzr8rCUcmfbXg3rieoDS6lkhocjUZU60ObI6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AYVHjWBf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AYVHjWBf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPH1s6YXxz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 23:35:13 +1000 (AEST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so6960714f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779716110; x=1780320910; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XVHRPBSt9KXo5wrulw6nEDVPqzcFN/DF35DZwL4F0c=;
        b=AYVHjWBfT1Mk8dvz2o+m5ITeDbisDdp7bjYI9jlh2wl9DowwICdOagvFpWY2qnP4Gt
         EgGZ6GndEP1WeF/8phIck7w9JNjj0Hnb0mQXr1Sme67W86yVDlB5kan4PpmFEzCrUSSN
         9+yKO5uHIO9k4g6/xg82Pz1EbaNyuj4vnmxKFGAMST3HaCUhyXLsDjOLWuIKKG5WqYFa
         zb1i0LdEgzXJk4Swu9dP/MvENZAMwokmB+tSz1l6IbUuRPCfK10Wg02snKBr6MiQd4yR
         T1UEic+JCnCZt8KJrTC9WW3CJDY9Tdhkc0rqNRH14I2PZv5L1V7BPo3W6oYK1buZtdBb
         R2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779716110; x=1780320910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XVHRPBSt9KXo5wrulw6nEDVPqzcFN/DF35DZwL4F0c=;
        b=RJvvP7f0YMDHk+2lbCVN6MrPQoe2c0TO7VNpxdmLZ92079E3yVrXZtSyDDhnKK4atU
         pVxRzjrkOxv9J9ZnIJ31JkYh+3eMEp/bqbAWZUcAu99hfFMcoKBqwScr7oDyERRZ0ggX
         a81NtdR4oMreuWaFSFUuGRKDcK9Yhx7NctbsZrLlOaHXMuuqLhRUT0y8gd4U4mQesvER
         1A+0ME0cgAuQ4awFFQW50HGTjPdbybwauH2Dv1+LiKCWz/MkgixPgiad7SfWJpkAIr+C
         m3qRR6y7Qo58aXdH8nv/hSHthaCMzKfoySPzcPqgPNa1tWkspyW337Ul9tO5Lx5T55hp
         eQzg==
X-Forwarded-Encrypted: i=1; AFNElJ/gx3nnK/v+u4HdRvN315hHMlZUavoDPjVOSe1NUBldRASyGhsFmTP1JRxmh99Hhnvrs5TZJ/wTIBCcdq4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzXudM/zuX4LdbF53Ps5kD1cJgUYdbdYFmTG4VChsS5HL33uYxs
	fFEMi8h4DOH3wjdAcD54bLBcF6g5gPjSx3SEtcJfrkw7eeXWyRnTRyC56mpkrUpIvVM=
X-Gm-Gg: Acq92OHe1xvO71K3q7Q/Tt1Kps7mXvQMvQaQJcSajS1duw5oQsUHNwuQzBNuXEpbnoz
	WwIO2nj1/R8HmDTXvvpQWa3ed4mkXQ4qFOKR6NfSSVxm+Zxo62hwyrRgq4T4AzUKSF6SlZ8qfz4
	2vfjYbpIkl+kv35vdJDwLFGM5KoiFECpXTBPWJPhcHAdt1nc4bEo5j8Mc4RHkb2IqSx0fq63Uwv
	z5RLD1Airg+XndvqgQw/h7xTXVweYwDzK6vdgantalDLcZ28sVceOc4DQ77V+bbR1bszl8Xa4ec
	sa1JmMxiClVUz4LWAIXjSNi9+xsp8xB49EBWHuwgTeE2wRJhWSlkDOvwlYA7tuWUwOv2atyq/a0
	t3M5h7XTkDiAl8lph1hs3lrI6+WsHrqlIWCCPRDlsdkUQXZnp2jfmAJyXEtAQCsLUQJmNiqSb+o
	6Tllcbhgh0tphtkJRM+RSj4uRk0UC+UNJlVyyemWq4AubIehJ7d6Yp+IrjHbmABT2nIHRj9wSXi
	+23ziVeDWE9h4l3qG550h7Tarn7mZC25DnaGANMX7k1JwszY2aiEdKWPoMHLVxzn8x8AA==
X-Received: by 2002:a05:6000:2008:b0:45e:8cdc:4ee8 with SMTP id ffacd0b85a97d-45ea3128ccdmr31052715f8f.6.1779716109692;
        Mon, 25 May 2026 06:35:09 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb9asm29456456f8f.27.2026.05.25.06.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 06:35:09 -0700 (PDT)
Message-ID: <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
Date: Mon, 25 May 2026 15:35:06 +0200
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
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-4-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-4-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Using Coccinelle, rewrite every struct kernel_param_ops initializer that
> sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> for example:
> 
> @@
> declarer name DEFINE_KERNEL_PARAM_OPS;
> identifier OPS;
> expression SET, GET;
> @@
> - const struct kernel_param_ops OPS = {
> -       .set = SET,
> -       .get = GET,
> - };
> + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> 
> Using the macro for initialization means future changes can manipulate
> the struct layout and callback prototypes without having to change every
> initializer.

Nit: For consistency, I suggest also converting the few remaining
kernel_param_ops instances that specify only .set and no .get, such as
simdisk_param_ops_filename.

-- 
Thanks,
Petr

