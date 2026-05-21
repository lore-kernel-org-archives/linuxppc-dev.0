Return-Path: <linuxppc-dev+bounces-21334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77975CD5BB7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 13:59:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLqlt65c0z2xn3;
	Thu, 21 May 2026 23:59:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::54a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779371978;
	cv=none; b=RWxNqoNTp2EcY1nWfGGW1HYvbIe7fgydgIPHaXR0Sv6681jnM14RvAfONV0GUZknQpAI3Ff0Me2oWvM3aCvRAK2qYMbAJUkUowhwRs+h73pnYFbSSIfTKxiFJXx9SSli1T+UbE+3YXwG39TaShY7DUWLLOZzK099Nxd5aW7L+Dng1Lww1ADpY6XnPZSXAStDqz1IN14IFDuHr/mguNy9zLR32+DZaHlgM7a2emzTlIM77hCW9TzOdTWbcUE7BmvIQsQMK7s+WDCxi3reOirux5l7FgYNZ59m/DzGujBz0cDp1VU9VZpVjrMMFlsA82JoxS576eYDzfYrO0187tIFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779371978; c=relaxed/relaxed;
	bh=tqeEG6FXEKElqAGUt/Z2qfbIbuB++N7b4Fh1Zt6D5dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hTZnq5Al5nrXU6M/A5r5W78yN1EDUyZmEZzP68Xd7074Kqx9FZ9RJvAxNnF7kgaipblKwqGXKVk5oWQyVQD1H2B1EBxEOXwZ6TG3aPlF4flfyhz9BHKdER1wX80tuBk8C71wO0pBYrttq6vIp+cjYKF6B7odgpiHoeCUwNeFMeizw7pwKYO0MZP/Pi9ImgypKr4r01zp8YjLIL5/cAsn9rQvnInQInJkZRe5WppesL1Kon+yhJsEf01qOipE5fXydb8W0ysR+nnvEifY2eC2zf0rPeQ9IyBtkvidCo5P7cKhdA4TRToHxlfgwMRXd3cfJRCntHm/iznHMnf/HCRVDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bi3dkZ3H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3xq8pagykdhgoawjfyckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bi3dkZ3H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3xq8pagykdhgoawjfyckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLqls5RnJz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 23:59:37 +1000 (AEST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c829366cf25so9100257a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779371975; x=1779976775; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqeEG6FXEKElqAGUt/Z2qfbIbuB++N7b4Fh1Zt6D5dk=;
        b=bi3dkZ3HJCmebLWkNE7KaHbj72stNfJYksGfQv/oBIgURvMvXRpWvIEX6Mqv8DTVy2
         DWnWzYvTlGueCN3mrUp1mI5NNpdTxIgn6OpDwx0J/6Qogf06mwJ4xpd1K2AWap7lKkGI
         SH7he6F1YKvKE+GOCoH4LJUnzjs47iJZvfSkS6U4uHhSpw/e/HBKdOhrAMK8ojBFrNFI
         iyiQJfzDTDYipRxgblmG2I8vBGygyo5ZYOymcUJcGmrBZ+flWoEsinSpE1Adrf/KPiHn
         z7XLKuXDRAo6yeQvbLugSHe4zm4gfxERSN+vYcDnu4Zyynmus+1FAUnuvDXfUIbwDkgR
         67AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371975; x=1779976775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqeEG6FXEKElqAGUt/Z2qfbIbuB++N7b4Fh1Zt6D5dk=;
        b=joMdubm7Rls5a+P9cHEcLohiNVEd9/g0n7DbVl9SDr1ZeULNNbDHflJLv+2jGgxzth
         z+02weSi8PmGIgQEkDbWoWH7gm90jhdv08RVf51gs8hvY9Y1++cCuCsEwIUlJoAgzvqe
         w6Q7DGP/oVu7QxzTYBKRfpwLLNSPj28ppjW+gNTrHeQ7m1/CRp5hpTuzh9h3Zdffp7K7
         v+KtaSWKmHfyAeWhybQeYBVnn5h21sWw+oCRGtd1O4p0RR9pfzQussnB6oxfjQNIsOQU
         Cg9BRLBz3IVSgD9XdarmpdjtGPrFbkjETN+0iGgjUfYdacl48CXqoC4LzJR7k0ZvR6s0
         BLhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2xa8c4hY/bTAagEFsJy4Al2zFY5GF+mmN06C2ea7bzpFWDwJy1+u5GZCB23uE+y/8nzRMBxiKatj0VQI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxo1yY8QXQbKnx490gaZYfHvia2dhGSjxsoOEvT6pM3oid06eNc
	incqPODAiP9X8T49Sz95BiPLd8SUuui0NXMqTgiCkAk1QMK1hsXrI2Z321e0J8Ufm+mhHQCjmrh
	1+13G8A==
X-Received: from pge1.prod.google.com ([2002:a05:6a02:2d01:b0:c79:83b3:cdf8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431a:b0:39c:a78e:dba9
 with SMTP id adf61e73a8af0-3b308ac1b14mr3725831637.40.1779371973881; Thu, 21
 May 2026 06:59:33 -0700 (PDT)
Date: Thu, 21 May 2026 06:59:33 -0700
In-Reply-To: <20260521133326.2465264-4-kees@kernel.org>
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
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-4-kees@kernel.org>
Message-ID: <ag8PxTTi5NxT51EW@google.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Eugenio =?utf-8?B?UMOpcmV6?=" <eperezma@redhat.com>, Jason Baron <jbaron@akamai.com>, 
	Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
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
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Kees Cook wrote:
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

IMO, "OPS, GET, SET" is more intuitive, especially since that's the order used
by DEFINE_SIMPLE_ATTRIBUTE and DEFINE_DEBUGFS_ATTRIBUTE.

