Return-Path: <linuxppc-dev+bounces-21500-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4CCCD5BB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 06:53:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPk3c0QB0z2y8t;
	Tue, 26 May 2026 16:53:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779778395;
	cv=none; b=Iyi7E4kqnpGDZAe2cs6YwT1/bwPo8cvwoLV5KAvN9egmFtAVALo4PbP0AWrATf4H+zo1bTduvh9VP+bqWaJjkI979ZoaRZXg2zYRba2VA80PupndLWdSgb/Z3wQ4iUF5rSk6+rJzMnSEEdZwh2cTKcX9FqhLZugmvmScBxHc1cFgLxv/yOgzC1PnuVJ+CceHQ7HAMQeAUDTBTk2K93gX1YYThocTrJZr8UE5HRxeAz+MslVY9iKkdaZA2VqbGmxZsG0durXC+WDZr/ttsJyBjSbp6MXRVWXVF+U7fsRmQ58s0ZFPNuckD5hFbdSa79ICmZEc9xorLK+UjsTrz8khGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779778395; c=relaxed/relaxed;
	bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSauHC5Elo1AKTLgq4QRmGrfYqjIhOTUoO1+xr6dsOH0Y/go5fhMAR558Y+iIBlOd0gS7FdLUTI1f2ei5TBVXFAxUQ//buwlq1Q1TSVumkhHAWNzNPEIrp/DuH3fZdzJ80Tczx3nTtBRPfQv+psAhuhQZcan5afqB8GnDPpuRvRCUYXBG3vPHZhKR7il3NTYoUmaXkKPY42+oHdPU5SZ0+1UgGYIgmvyramPse4sumULHlG6zXzNLa2M6Q+K1SZFuiR3nWk5Bs2kGfTSR6GFSyXhm5MZgaakgRIgKBvRhSRnv4bvbMbxxlvnvcrV60Dcunk1GzvMpizXIVDh4a+TZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DzM86LMf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DzM86LMf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPk3Z26cGz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 16:53:13 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-44e1860558fso6501815f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 23:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779778389; x=1780383189; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=;
        b=DzM86LMf+EPgoFRy6d3PfGgghRr3PQiBbTKR4ZQLYZOhQGZJUAq4sm5DSlhC15iOU2
         fHJ0WGfsIwXkOn5yr7fAnFTJbXuat7nLaAeeNd0SAEa2XZp/4ZqKLtKBxHlKD4i25YP9
         zY9gMyySqk0pGi/7/xpZhdfvFwRiK8CEvHsixasv6ETkFbf82Zs/DlRo0Ohk72wKseFu
         EO5X0Xf1YOGG1Yb1jUox5lf+KlgzBJODflgpTDHteksPNe0XzHWUHAfCZf/EvqTkEyd4
         KNwrGsc65UGyIAa7eHpsciQrSho2mn9YKEaRkGv0D7lkOrhBzS9RaGa8yAWNfUtraRD8
         k8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778389; x=1780383189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=;
        b=sWEY9P6xr7+egFAyx4FseNGthkA1085Y/XgfbJojDVG3nPJExOJw8WgqFPeT8vfkHN
         r9BF35AM+nHf9+TI6064Qa/rKoEKaIxabeII1SWvB9h7IeHtpizoe3qdC1KeKwTMwVHM
         3meaiogvY3BPUMTyPKw5fYaZuNhIW+xCY1bXMSAlptWxs+purrdQQjX3eG1QH0AJnK6A
         O+MkelVxR9vo9Ve9NONuwvaTln8b5xxkMn3ACGuCY27bsz9bEBvhOLToWoEwpdFKswiu
         wkWjsZkEPRbVERH94af6uS8H6NfKCiHK7PKrSbuSOEXIucpHAiU9mWHd7nItvzwzn6Wo
         tTfg==
X-Forwarded-Encrypted: i=1; AFNElJ+QpIR+UKlrq5YMTLvKofocVW9mgMj4pd/UTG5/VKoQDXinxt/XsjeBFP4ANZwFWrtteRbjwSWf5toUzYQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzPYsmjJd0ui1eKAlsSPok8lAOPMVNMgYS1p+8CipW4IIzbkgK2
	QgfX20dsd3t9UoP8bv0MD665uIp4G8yJxQBJ38DQWNS8WUUb2+jB/HOfghPVNdm4bHI=
X-Gm-Gg: Acq92OGtCn2MjhnvX4asud8/UCm58VZAug3g3oH0m9fTN+IhPOCELzgPV4kaa+NQvRu
	thjbA04fpwi1RkfxvH7LyhCnsN3ru/shcHl2DxTk0ppMFzLluBKKcON8QZd07nmA+J/euyiDIDZ
	BWKH5u9+ivM7Y2xdLU8ncHdx7ytYyY+gntx+MOFO04STPnCKWX4JltqaUy7cmePThDhJ4N7AVz9
	vmcsKod0UPmlQoNjBeU7M6SQebygPwXfN368t27IOUSEjw1sXVFt1kgmXK9pHo+P9Y+bTXKSdLP
	6yvmfW5dc3WXRER3l2+XFYPfGLKgncdqzlOhhim8UjFChsg+6aZX9AXNrTgwSCd1WdCVpfEX6DH
	VqGsOucju0plCHE9Iy+c8EuPqdTZBnzz2yqAA4tMjiWnGEmR26+MTT6a7TXcAekGWIXrQ67YiQr
	+nWSGZ5/rtMMqa5/Hs1Aas+locGEFEPPed83RBc2JUAx/yWmgY1lsJZLZjC4l/SezhxjIRTSx52
	3zu7Ipn2ixjaKnQIoz8BVqS4PezrEQXTnlitz/8JkW9odSr0G+oJl8bWvK9S//QaoKXgGkcGe/V
	9HsY
X-Received: by 2002:a05:6000:2003:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-45eb38e4b46mr29516257f8f.38.1779778389230;
        Mon, 25 May 2026 23:53:09 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm33848641f8f.8.2026.05.25.23.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 23:53:08 -0700 (PDT)
Message-ID: <88c5ca1d-eeda-4023-bc7a-397b92780db9@suse.com>
Date: Tue, 26 May 2026 08:53:06 +0200
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
Subject: Re: [PATCH 00/11] Convert moduleparams to seq_buf
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
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Hi,
> 
> I tried to trim the CC list here, but it's still pretty huge...
> 
> We've had a long-standing issue with "write to a string pointer" callbacks
> that don't bounds check the destination (and for which the bounds is
> also not part of the callback prototype, even if it is "known" to be
> PAGE_SIZE, which sysfs_emit() depends on). Both moduleparams and sysfs
> use this pattern. As a first step, and to test the migration method,
> migrate moduleparams first.
> 
> There are 2 "mechanical" treewide patches that are handled by Coccinelle:
> - treewide: Convert struct kernel_param_ops initializers to DEFINE_KERNEL_PARAM_OPS
> - treewide: Convert custom kernel_param_ops .get callbacks to seq_buf via cocci
> 
> The last treewide patch is manual, and may need to be broken up into
> per-subsystem patches, though I'd prefer to avoid this, as it would
> extend the migration from 1 relase to at least 2 releases. (1 to
> release the migration infrastructure, then 1 release to collect all the
> subsystem changes, and possibly 1 more release to remove the migration
> infrastructure.)
> 
> Thoughts, questions?

This looks reasonable to me. I added a few minor comments on the patches
but they already look solid.

-- 
Thanks,
Petr

