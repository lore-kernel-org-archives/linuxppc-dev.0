Return-Path: <linuxppc-dev+bounces-21904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E80CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 13:05:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV9zL0w82z2yFK;
	Tue, 02 Jun 2026 23:05:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780405502;
	cv=none; b=kYe7ZLDOJoHbcYzfMGJ0a4ulqSwBfIuijqgFiXFYO8zIDagAX5B24V4lN2Pd+ZYCMozH4VcIXhL0KDQ9VHeTOCugTJWHPjUlhot11IUyez1IiXF9KJ8YEiqGCiLuB9Z7p3/gLoDZBYYz30s4Q4P3Vj7WM8OxNiSJKXSXBewP7vcQOYBcgMQ3VbSsWUprjNAiL236zeULP/04rwGlKgfKrLaXkxS9U6hER7Qj1Qmj2T7tjN141qtW8/rC/bZa2+ZKXaEQ2CWKzfRHHdgnZhEaJhBwIOEZ+ntQyg/c+hN89Yt9K4y09v6f9pKWwqpd+QKz/bX0tpldWyh7n7R70KVqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780405502; c=relaxed/relaxed;
	bh=H/8nMdqnIqVIuE86ZCCEmz0EQ1iXOszPXfKX9VZoGH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWdW5lpkl6GqgfpI86UJ1nTXeWH1HKAmR3PusieLHreX3wU3y7I30H+wvkOpDkyESc6DiT3Zq9PHSoI0f3Kz13gvqiAgMK+MdVu3ux44e/Ge3mxh6mMekgHblb1CLH53PkPe5L2zwUEjCtc3HQbOS8s+WwZXD1dUGNyLIdIgG19GQu89eSQRi5GWVbCujUueMpOoCwLXbIlitDm202lEfhYqzb/YvydvZKUT28uRRJXPYc2ZoLJey0TuggXc+eiI6cih+jcBAj9MpOMXgvwigqzCSX6K2zcF8t0QlhZHqa/sSn2MwCB8XqssA/KT+o+EQQvujg3rXHGD/XnGNSbxug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ifZKqIb0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ifZKqIb0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV9zH708qz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 23:04:59 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso106713175e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405496; x=1781010296; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/8nMdqnIqVIuE86ZCCEmz0EQ1iXOszPXfKX9VZoGH4=;
        b=ifZKqIb0V6Qk7lmCSJ7Ib+imxBZCbArfW8gRBpT1+KnPm0stcDNMXlzL4RXk2lS0hP
         W1sY1DYORg2IRwAwSGmr5a14UZ6/2tTYJZKM7P9k15p6LrH4RzRvK8dgiswsAmFk4Z/D
         BRPQu3laj9lBTRUarqg2/4ObBFFcDHPpj6S6R8qE5zfDFPsxNMe1in6c8d/zZ/QEDlWO
         YB3SeT+uQ6RXAhonz4WU9k27LI5HswsgqMep/e+ciKQekYKrjKt2EvBtqPM2QThWoqSD
         F2kbmSwNIdK1xh/7bedJx2kObm4G1JOtwwcGrv5XE4QROw9kON6PbavnNUqLDJc6jV55
         lUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405496; x=1781010296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/8nMdqnIqVIuE86ZCCEmz0EQ1iXOszPXfKX9VZoGH4=;
        b=n446tf1NZtdEOWmk6J4GvKnIDY2f054fNIDTfWFISZbIcGNUPZ2sIEKbLmhadlG/ZX
         Uw9LEllub+GTUcWWUNDNnkWef0LtuyEwKnz+hDFhbGilIK8zNDfe63WipOeucYYm/Lhg
         ORZlxe89Iha13vmQxB7Fmw5pzl8lOoAQ9mAxRMzsYuqm90VWvSi1TBq3x/W13ZyhKcpx
         SAgWYY1xJTbM0DCXoukzvVcxzxGXro/hY7EjqILKLPpq9fZ9SCF2DZMhSXdrN/yrLf2q
         LnrIShp2yWd4+YRDdO91RDmbFcoBkNwc0hFh72eoqjY11YbeIcST+XFxu4aKzX2H14x4
         ef+g==
X-Forwarded-Encrypted: i=1; AFNElJ85FCPwT/Toq45nogToyfJGNJO+YyK5B91xiMVsC+XdNcSQpazQ17p6Yljz6mP0sHK5wQ4mspYXX5gZCPE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5gOeMn1UfAK+uS62p/xKTzsvhtILBgqQRt9wfYVM1M5y2e+i8
	89RUYG/gt7iG6M48JmWkDkjLB3UyJtbwV1t+QqYy0A8WnA9LWG/F753P
X-Gm-Gg: Acq92OH7y62HHvg9Om/KgWqJFu130p9NaArlY3P0tuMoxuWfoX9dXDZyv0VwGPQm6ag
	+WorhASPNOa4jJIEHAueyN2pMpTWPki2dUej1yYAEVbhazbwCA8LmtOdivEqaDbi4z0wsEnfKRL
	DUAwcJ8v9lSnpLzYcTH1MFE2xwTz1m3+XgwrJGyVZFS96Bdo25wmwHffqkT0vC5gSVu43YH3Cl7
	mJ//jPcZP8ZRVX70Mjqnsqh/ug0eRuRoqXk3tdxhaN3tXhz1+rNDVof+1o/INqodxWXdzT7uQSG
	FM3eUuthJjYtZMqKixY4thUbISxzhrzaxSLispvkJ6yVmLox8x+He79GqtV3kVGaaDIPZXyFauw
	ryNgNvdt5BOwoQvVvYdTP9sL7moTlZlIDfEhO8y/8AcTAbOQlFVJNJZcyZ//Cna38YRzCNd+ITW
	tg5f7dcKYjF8E7r5tdIldIKwPeS49udwYFEwY9zfX6wGBlU4HFcXv/4KoobnGgN7OrWkaP0y5BR
	PNvbBFeDw==
X-Received: by 2002:a05:600c:8105:b0:490:b072:1be6 with SMTP id 5b1f17b1804b1-490b0721e0amr76565325e9.25.1780405495119;
        Tue, 02 Jun 2026 06:04:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b834esm33184301f8f.11.2026.06.02.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:04:54 -0700 (PDT)
Date: Tue, 2 Jun 2026 14:04:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, stable@vger.kernel.org, Petr Pavlu
 <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, Gabriel Somlo
 <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede
 <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Baron
 <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie
 <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, "David E. Box"
 <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Georgia Garcia <georgia.garcia@canonical.com>,
 kvm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, apparmor@lists.ubuntu.com,
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
Subject: Re: [PATCH 01/11] params: bound array element output to the
 caller's page buffer
Message-ID: <20260602140451.2e3e6622@pumpkin>
In-Reply-To: <ah699hwLxIIOZ0-7@ashevche-desk.local>
References: <20260521133315.work.845-kees@kernel.org>
	<20260521133326.2465264-1-kees@kernel.org>
	<ah699hwLxIIOZ0-7@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 14:26:46 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

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

The kmalloc() should be faster and I think has to be aligned.
There is another patch set to replace get_free_pages() with kmalloc().

Although all these 'show' functions should really head to using a safer
interface.
Although, at the moment, it is really difficult to find the ones that
are guaranteed to be passed a page aligned buffer.

-- David

> 
> > +	if (!elem_buf)
> > +		return -ENOMEM;
> > +
> >  	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> > -		/* Replace \n with comma */
> > -		if (i)
> > -			buffer[off - 1] = ',';
> >  		p.arg = arr->elem + arr->elemsize * i;
> >  		check_kparam_locked(p.mod);
> > -		ret = arr->ops->get(buffer + off, &p);
> > +		ret = arr->ops->get(elem_buf, &p);
> >  		if (ret < 0)
> > -			return ret;
> > +			goto out;
> > +		ret = min(ret, (int)(PAGE_SIZE - 1 - off));  
> 
> It's usually discouraged to use castings in min/max/clamp. Can we make ret long
> or do something different here?
> 
> > +		if (!ret)
> > +			break;  
> 
> > +		/* Replace the previous element's trailing newline with a comma. */
> > +		if (i)
> > +			buffer[off - 1] = ',';  
> 
> Can't we do this after with help of strreplace()?
> 
> > +		memcpy(buffer + off, elem_buf, ret);
> >  		off += ret;
> > +		if (off == PAGE_SIZE - 1)
> > +			break;
> >  	}
> >  	buffer[off] = '\0';
> > -	return off;
> > +	ret = off;
> > +out:
> > +	kfree(elem_buf);
> > +	return ret;  
> 


