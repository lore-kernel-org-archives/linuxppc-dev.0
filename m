Return-Path: <linuxppc-dev+bounces-21480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16B1CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 16:19:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPLgN5T6dz2xfB;
	Tue, 26 May 2026 02:19:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779725968;
	cv=none; b=cUn87ZY6s1/zGnacx5NqlQn8RHqzPtK3zFnGsB7gLkn6lalQ9XKqeoRfOPkDQ4J/0GEDH1woIqDBG+sn0Q2Axgu6wauqJ0SMfABAvaArgbl2QUpUiD7uqDd80WIgDrmLGTVr8KRMqpZ0iJ6id/DRFGr4MxKmT4gec5ezbqHbL+tdwQ/SDw10wlHORcRTJw423ZUBQq0fQtzcNBhT266EkCuYqUdA9dbQWwSgyzCODH5ObAzkYi+duujP8bCbpMLpezkFlLPH4St7ykKdd0u6pjotw43wztSKvaSGMbK69tjtI2kjMYxD6FSsWB/tSKosr1EEYRCAksi0FxHM6NDsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779725968; c=relaxed/relaxed;
	bh=6YA+/JJXQ9abERc/NViF0XyaL5qdJ2pUb4chRkVwshY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NN9dZkoNzyA0W1oX+Rh+R8hcT/OVDCL259ovIav6a/ewjvbK/hR8LMPHujvlBD5QiNx0fOJv8BLOePf3t548HEYwwWDndU80/WuZ59s+he92VQOKLAE4MTL76lngxxL53UNAht3UWCuaKrGIipa1q5ApB/o3Q8ra6N38Z56Tra8m0clFcWX1tGwyxWb8sxidMnTPXX9QZeKzJigLVj/W1uhFS4y3DRmLpdIeVor0J4X3eEqLVXw72g9Uajv+e+5uWkwKAizvsXPNyNuYC4kRejADES8bN05GO9GBsKvJWNyyX11uvSAMp2FFMcqfPUGeKIqeSkwcPP11WLoELn33Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KaTpMUr/; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KaTpMUr/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPLgM2nQvz2xbN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 02:19:26 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-48fde648a71so63301375e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779725963; x=1780330763; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YA+/JJXQ9abERc/NViF0XyaL5qdJ2pUb4chRkVwshY=;
        b=KaTpMUr/60gvSOAczosrrHpOxt+cbbcwAwhb9immXjYMuP1g+Ec3fYYdmPklSfP6in
         ExRI7SV5d6y/j0C0W4y2IMugEVs1fEs9XpNEfxt7r7ZtflUJRdyiPTyAYBkfL7R4cABS
         9aLrbVFhhBsVB3MN/JEb2Z8+0qv32UkentG2L5pQpcB/oYIT48U80DYnmRpSwNkAzR9H
         o6IFYhYZugUkh0MYp6SncdVeTohu8Cwz/wqsZTGjD2+sTI0yyTFX1YggzbT7U9T80Eml
         1An+mMB9aBNPX1yO6tUmwL+JHGZQZ5oda29fCfCcmIxDrSLvWfmE4CfEFMRe7adx70gr
         DeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725963; x=1780330763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YA+/JJXQ9abERc/NViF0XyaL5qdJ2pUb4chRkVwshY=;
        b=m4IMhZu80k/YtoLM3hJM7uj76pVLeOgQnCt4HY58tuaZmL8pYh3ECl/7+Xz9xEHBfY
         /Z8Gu2nG/gXGUhXZ5wQ/NvCokDJWigYfcVujt0aVxSUwe87IajZ2dhNo1SyEJnHJ2YKK
         +9tzKWoeHfrGSRGhbmuAEDEhnzmGPoRCbzQek+bj5w0Rl+39nCoo76GDjUgUhP/2TlLA
         ODxDdy3eAIVWCStCscML/ElNZvM1EAQHQQftOOj+J2BPZ0hZ3PkXvaU5hL1pQcnTRcP8
         Kgsn10otXTkl44OnLnBclQ8DPNZPfZdAV/CdoBzbSOwnQfbpyRoCmxKe1/TOiP4adN7x
         VXJg==
X-Forwarded-Encrypted: i=1; AFNElJ/pNuQW4LxI635wxcrVAHP5+zlespd9rIMup1188+BbbC5+06hdGA/Zbx7ZLzIOpNnfIpUg5ifarsOmd8o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzoWElnE/t9927zr0w3WEalauM2hf7Vo2SoUfq6j1Ksk0SAhA5y
	Vq8LvHisW5J+SC+Sy7sZzN4ifl7FKoIy9sF0A7eYZzbB0qNWg+7fyScOM/ZzM3o611g=
X-Gm-Gg: Acq92OFK3K+YC8kTe0GgsKZq7fOOuY5tNeBb33nVoRFmNhJxEBPO74E4JqkNyOBNoiW
	hYaLz74vCJixAMCByybtfJRgYKOMCYfa6w+CoK6aca72DSEqW7WQw7YHRAiU6GKfqmIBMbea4dH
	kN8eM1JvmJnw7slo+w7JFs/C69TT3X7d/2XC8sCtf1Bi0+EQlLe2qi9LXxvbqvKEwwdJVK5l9Tx
	Msr2Js9x+3ZFFIvxJojEYV7hbeZUZULbrFvg99Y5QWxdsoJ45ElcCSggl9rQgLfLWnZVOr2WvRv
	Yj5AuuE9sLiokAHbos2Z7O9rWxv9kxEM1b8q3Zg12kXnNEkrzdo9RmcUklM7S39mZ+16JP94KsS
	r46MQ9Q9KddgoT6hPiPrPuA8ZBjZavNxV69gUu7QAz9HdqmmgTceZ9Pu5mgAETn0eFmZxbPDavj
	J8TtX8BVacszhoGWG6cp/4fWJPDmUzAd9OUmBcHe2R++l/O/cgfWJpMVtIW2wDwzB7ZHfTgJZ2y
	vs9lVbx6WnAKudBre3G8XtyOB/f8he3i7wkicJZHE5tB+IHkF30zw4b0CWFV2pr59nvYQ==
X-Received: by 2002:a05:600c:3b07:b0:490:f7c:b19 with SMTP id 5b1f17b1804b1-490420f67f5mr197977845e9.0.1779725963153;
        Mon, 25 May 2026 09:19:23 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49059cc9a91sm48939425e9.1.2026.05.25.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 09:19:22 -0700 (PDT)
Message-ID: <a4c7ccee-6189-4c74-bad8-57d1438c7d8d@suse.com>
Date: Mon, 25 May 2026 18:19:19 +0200
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
Subject: Re: [PATCH 06/11] moduleparam: Add seq_buf-based .get callback
 alongside .get_str
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
 <20260521133326.2465264-6-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-6-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Add a new struct kernel_param_ops::get callback whose signature
> takes a struct seq_buf instead of a raw char buffer:
> 
>   int (*get)(struct seq_buf *sb, const struct kernel_param *kp);
> 
> The previously-legacy .get field is now .get_str (char *buffer);
> .get is the new seq_buf-aware form.  param_attr_show() prefers .get
> when set, otherwise falls back to .get_str.  WARN_ON_ONCE() if both
> are set.  Return contract for .get:
> 
>   < 0 : errno propagated to userspace; seq_buf contents discarded
>   = 0 : success; length derived from seq_buf_used()
>   > 0 : forbidden; the dispatcher WARN_ON_ONCE()s and treats as 0
> 
> The default policy on seq_buf_has_overflowed() is silent truncation,
> matching scnprintf()/sysfs_emit() behaviour.  Callbacks that want a
> specific overflow errno can check seq_buf_has_overflowed() and
> return their preferred error.
> 
> No callbacks use .get yet; the legacy path is still the only one in use
> after this commit. A subsequent commit teaches DEFINE_KERNEL_PARAM_OPS
> to route initializers by type.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

