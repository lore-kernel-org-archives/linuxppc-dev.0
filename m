Return-Path: <linuxppc-dev+bounces-21341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BE8CD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 17:45:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLwmH4nYxz2xS2;
	Fri, 22 May 2026 03:45:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779385519;
	cv=none; b=lSDaACQsEmHC/JUvoPpAZVWCZO67We90LipQKaLr1p96DAUuLAJBO5ouB1CaxIc+ns2Y7Rqe0LptR/Odb7SZ3jnJTAIRVooCzgOGV/Px1SwTzt9jkvb4QlH1wrZNPacshzqvVsMKUTxzZerjcabTsLoFWsi6UX7vso901XkNRGz4elnc8ykMRBh+eJs/bPaXb0n66feAcOp9p4S9xZktCJnxaVgGnZwheNQAAwF/weMBBZ+lPcPZv1uZTzTZI7wCnO46ODgBRYEdKgcOjlwGs/wmaXaS/UbJtBopMbYPgeyS9WA0UsDyKPTJVtIWMpuHgVkbSXssiPJFDOqRSOVRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779385519; c=relaxed/relaxed;
	bh=JkK65RDtR3mLEPhqVTmKcBBfGABseq6VrGC9TbyXzOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lIqHj0QJOBa4bkTFqarnrFWZHPAGqEXvmn8ssZG1cbThtk5ij1x5Zowi+SZyiDjfgV/Pv94cWdwMYM8frYYaKCQBkm9hhc35EMIFV2Lz7usiU41nDB0KxTWuyRagLn5k9oY/8wSWwQX+aTM13XBi4LbORipo6uBjgS27G1JksvJUhlMi4ezlZ+sFME2RoZfu3xwis8jJr3NEi4Bg6TYqdT/yBH7UPcNrxklFIfdOTyeKA4IbRDPh2NRD52E6ZdkZj467Lb2nzwYCkY3rI3gAgguZCZ3mIU7Ns+WaXS+6pvI+pPkP51R5psPXv3tFKrzmGTLhcGqc4WCjttA73spG6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AzUYfvyA; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AzUYfvyA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLwmD0x8Kz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 03:45:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779385516; x=1810921516;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sU3q4ei5VqXFeemg2pdBcbpXy8Z2qTRY4hHBwMHyr+A=;
  b=AzUYfvyAVlZqT/6CEnSHor0DxpVhaxIcRyHvaKCWTljiMEjeJf+vjp1m
   2RheqjjpweYamufvFApCvv8LW19/0grvVKOOGBz0eh1rrcAkzQl4AFzTA
   iDDOwyQLlQtkRRAyO5nHglWlBG2jQdfd9XUeI/0qGqPcnsjUgZdlzBk1J
   xCXfvNKCNJi25QYztbOZpbiBVjnJYonz1uCYh58fXwQ+uXGVaX0ET911i
   KbMUZrgn3DZPLhwHCDJfOEQKMkcZFNmG8YOOrJC+e8dcTB9WWRkIjqepA
   rH8mBGsVY0nyhrVwgD/HqiXFD9oZiJDQ/g+aeVcHN+nMWQtgiSbdDPPwe
   A==;
X-CSE-ConnectionGUID: AhLPbWh6RYKGnCPRqxC9Hg==
X-CSE-MsgGUID: jro1/nkPTzGXwCuxHcyUNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105773582"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="105773582"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:45:08 -0700
X-CSE-ConnectionGUID: sVvxl8W3QX2Yx8AK13BLJw==
X-CSE-MsgGUID: XZM0S5M8QcaTj4wM3UKoHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="236347421"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:44:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Petr
 Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, Gabriel Somlo
 <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede
 <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, Jason Baron
 <jbaron@akamai.com>, Jim Cromie
 <jim.cromie@gmail.com>, Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki"
 <macro@orcam.me.uk>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH 10/11] treewide: Manually convert custom
 kernel_param_ops .get callbacks
In-Reply-To: <20260521133326.2465264-10-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-10-kees@kernel.org>
Date: Thu, 21 May 2026 20:44:37 +0300
Message-ID: <5cd0c8dde3687d0aea765f2f21f5e1cd8ba83028@intel.com>
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
Content-Type: text/plain

On Thu, 21 May 2026, Kees Cook <kees@kernel.org> wrote:
> diff --git a/drivers/gpu/drm/i915/i915_mitigations.c b/drivers/gpu/drm/i915/i915_mitigations.c
> index 6061eae84e9c..99cb38f355b6 100644
> --- a/drivers/gpu/drm/i915/i915_mitigations.c
> +++ b/drivers/gpu/drm/i915/i915_mitigations.c
> @@ -95,33 +95,37 @@ static int mitigations_set(const char *val, const struct kernel_param *kp)
>  	return 0;
>  }
>  
> -static int mitigations_get(char *buffer, const struct kernel_param *kp)
> +static int mitigations_get(struct seq_buf *buffer,
> +			   const struct kernel_param *kp)
>  {
>  	unsigned long local = READ_ONCE(mitigations);
> -	int count, i;
>  	bool enable;
> +	int i;

I'm fine with what you have, and I can do these as a follow-up later if
it's too much trouble, but I suggest something like this:

	const char *sep = "";

>  
> -	if (!local)
> -		return scnprintf(buffer, PAGE_SIZE, "%s\n", "off");
> +	if (!local) {
> +		seq_buf_printf(buffer, "%s\n", "off");
> +		return 0;
> +	}
>  
>  	if (local & BIT(BITS_PER_LONG - 1)) {
> -		count = scnprintf(buffer, PAGE_SIZE, "%s,", "auto");
> +		seq_buf_printf(buffer, "%s,", "auto");

		seq_buf_printf(buffer, "%s%s", sep, "auto");
		sep = ",";

(In the printf the sep is just for future expansion, though I don't
expect one.)

>  		enable = false;
>  	} else {
>  		enable = true;
> -		count = 0;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(names); i++) {
>  		if ((local & BIT(i)) != enable)
>  			continue;
> -
> -		count += scnprintf(buffer + count, PAGE_SIZE - count,
> -				   "%s%s,", enable ? "" : "!", names[i]);
> +		seq_buf_printf(buffer, "%s%s,", enable ? "" : "!", names[i]);

		seq_buf_printf(buffer, "%s%s%s", sep, enable ? "" : "!", names[i]);
		sep = ",";

>  	}

	seq_buf_puts(buffer, "\n");

>  
> -	buffer[count - 1] = '\n';
> -	return count;
> +	/* Replace the trailing comma with a newline. */
> +	if (!seq_buf_has_overflowed(buffer) && buffer->len > 0 &&
> +	    buffer->buffer[buffer->len - 1] == ',')
> +		buffer->buffer[buffer->len - 1] = '\n';

Drop the above.

I.e. keep track of sep while printing to avoid removing it later.

BR,
Jani.

> +
> +	return 0;
>  }
>  
>  static DEFINE_KERNEL_PARAM_OPS(ops, mitigations_set, mitigations_get);

-- 
Jani Nikula, Intel

