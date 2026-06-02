Return-Path: <linuxppc-dev+bounces-21903-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1D3CD6E60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 12:33:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV9HM4p4nz2xy3;
	Tue, 02 Jun 2026 22:33:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780403631;
	cv=none; b=aK7SBEEht62l3NZNU0RjiWyZdoA4IfUsWcpsQfYyvyahQ45q1ebQj79ehLe9QrIRloFXD+y7AkWBGUrWmvjm1vgHpffmZBl+rYUXVaTDXo1VEdZXSy09jmWcjigrkHESYzP+E0U0MBsZK8zjbeQNALd79mIiTy4uVAswu6Wa5edJ8+RirAVkBCNc69G1lV+eAUgiPeQEja0n8fyZQfiuy8lfZJNI6HETs77fNe3fXfpPtp4fwtRDbEtMm6zEgJqwZXJypoPj5SaUD1hP51amIsNGQAeu1JHcqAa6pB343r1XJAAPhGjMdUGkwS/w8ntr6JR5x9Ods6UmNN2ismJZag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780403631; c=relaxed/relaxed;
	bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKw3NqKApY6tv/7b/HLnCYZcIarxbhT672vovMrBujP7yORSW3LaTSKn/f0sN5/kMswboNjV8UOPp3n1Sb7Iks11JYhkIxMBbyuenQ+/HQkDUan/a6rl1jq+F/eYtRkE3IkgTVerZYEx2ZJBKeRHLjsEcYdxB5QaiKG1z3g6cTGBtPphkBnLUoCcf4aO1jjoGZtQuIkpuOl5QAp0SSLMP9sodtM2Z/BVA4asj/0mBjsal6igAitQ7tsWeUupOyuDkuTIiAKGub0S4agR3Y9QEkcjHIt4fGxxSAHeXzBdBMiUlK/QyHrKCR8F2dKSEjHnXm8Za8Bf28PxT/cO+QV0pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pD32zQjS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pD32zQjS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV9HL0CJFz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 22:33:48 +1000 (AEST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-5175b6c4e19so15977701cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780403626; x=1781008426; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=pD32zQjSMdGqOztiWgD0N2j6OGg6XK78KLhKR2NKbyVogEUjz25cMgfPiY29IfGfKU
         kYML7gVr1drxR3VrefOR7vEnUKm8VXJHZZ7Yjaifi/WhL+MBR3AVuGKdpKMCYYG8JVCI
         mEQehgpA86aMYjeYTEPL3cS0MrzAHl8/fKLZ8AjN/thm/IJ2+wFIKCmi9FDTmSfNJXBz
         yHKwHStqPcgUVUtmoRtpJOWc3x61vL0urCt7EPKWdalwD+a8vpTiHmUXG9Y7Mck+o1Lu
         vUgf8dK4xQhOOrvYDgNeMTrq2quBr3pVJbT4Mec8rn51MdZLW6wnK9GYSE1i2Er2bjJk
         TMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403626; x=1781008426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=D9EXKGTpn4FLTmNiaeD7Fo9krVVtWOhKAeFvmTXbIbRGZwP5/aifWkuibEom8HwTN5
         FqGH8bTAXKZjJNzKn8ooQqU5z5wTIfhSqKrXPt13r19mMcdZeNbrC+Su80F8Zt21jEoQ
         M9ub5hznX/y911pii4klC79IJiZ6CwJP/+bwGrEXUGvqCo41DLIv+7N6QPJQi83Fmzkz
         /iKHJGRrP0raWyr2PFm21O6o4yjJZ1fqKl76tkkfXvTllnrcowKlLby0nzQx1ks5aBZD
         4SBHJuieOOy1g20rQz0XZyZ/Il+Oh46C043o4Ey4Imw45oUWXAmDvjk+jxT5bs3yL6zk
         J1bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uezKRdqcKc5iALGjsSkQl3YqrxiPxTqWviy0HpGOHo4EvWIgV3lL8szZh6OurpS7QS6niLp9FMfRGITI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxtivenvcKtln0O5aYIuCNEW6TW786hWDVyKCCotkDZr6mi1tn+
	6g4ua8DJJZPBTEyvF+DQjSIn2d1PDO9vNSjUuMa/g/K4a4X1MaFfrpdY2KlD6ycEtzY=
X-Gm-Gg: Acq92OGeOLmCZE4hwvro8GEdpzUsJ2Y9UApeC9uvc7ocDKP/lpKOi90/IW6hgjMJv7K
	cNauRuO1gU1RF1vxHjdoOMAJB/qB3hUz1GEB5aAEg8pc7I4hOXxmH3v9EGVJ9fjmUZxjH5Liuor
	a950o9sCByRM0ynekb64f25fDL9OKOO5Im/M8ChUAEHSrGwpDR/zeJ8Qb/RnBNJRO3A2GXi5sgV
	Y6I2dAE9tPohB1MD/NFfPOqRAtIlnxJfzoR1pg9tvulQpzMBtEVkNn+HFWzX7d6LgkoFOmq23T0
	UFE7fdQkNQIKVA1pI1cJEGiNDyjGGB82bLlmCpRQWNXoxHxia6rmOQiQXQYFMYa9LMPpTCSrjjn
	QSRyhvnTKJrdfzwzLMuTItm3rvAdlYzp/cu4s69VHj0pIBb/wBWGzAuhztBbPrrYDyYA0ca0EKb
	5wMYgQEI3nUIipnVSsDpX11ldOtTpnd7ehR9eKbgx9kvYYuM9CeUgPw9pVudaEwJmnzTNHpegaA
	dlnk5p4QBKvHO8t
X-Received: by 2002:a05:622a:190a:b0:509:2527:d789 with SMTP id d75a77b69052e-5173a5c05ecmr228232631cf.6.1780403625864;
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741d6a240sm78686221cf.18.2026.06.02.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUOJU-00000003m5x-3DKO;
	Tue, 02 Jun 2026 09:33:44 -0300
Date: Tue, 2 Jun 2026 09:33:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, stable@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's
 page buffer
Message-ID: <20260602123344.GG2487554@ziepe.ca>
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-1-kees@kernel.org>
 <ah699hwLxIIOZ0-7@ashevche-desk.local>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah699hwLxIIOZ0-7@ashevche-desk.local>

On Tue, Jun 02, 2026 at 02:26:46PM +0300, Andy Shevchenko wrote:
> On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> > 
> > param_array_get() appends each element's string representation into the
> > shared sysfs page buffer by passing buffer + off to the element getter.
> > 
> > That works for getters that only write a small bounded string, but
> > param_get_charp() and similar helpers format against PAGE_SIZE from the
> > pointer they receive. Once off is non-zero, an element getter can
> > therefore write past the end of the original sysfs page buffer.
> > 
> > Collect each element into a temporary PAGE_SIZE buffer first and then
> > copy only the remaining space into the caller's page buffer.
> 
> ...
> 
> > +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> 
> get_free_page() (or how it is called)?

I thought modern mm guidance was to use kmalloc whenever possible and
not use get_free_page() unless you intend to use the struct page bits?

Jason

