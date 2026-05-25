Return-Path: <linuxppc-dev+bounces-21483-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9FFCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 17:10:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPMnw1wCQz2xfB;
	Tue, 26 May 2026 03:10:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779729012;
	cv=none; b=CrDFilGW6Ja8Cz01IH3U6SV+2jHw/8H2rb6PATfrtRlY5e4hHdedArwuoeqtC8ZairElGTTD4TFIHMXQ1ZzMcXe7ofoBXMgjV/HW2B/Y4mhmzTrckaWz6AKuwihqKfJcS+Kzlsk8lC3PcUnRJMKR70hlR90FGLEq8sPM07F9jmBxd6FY+7boQb0jfoJSDlecO00CipgUVVXct0hdvJiGdxbjY+3J6gRlpDCgoXT7GijQway8Avjh6YmY4C+cH/MDGVSKurb8Z6Z14Iv/8osnhj5CPWGUhcP+bKOIbNpR0sslLaDRV5tWsg7gRQn6fIvuSbZYxzQvzKXfmJkf788d7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779729012; c=relaxed/relaxed;
	bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+wVHTEEB2z2xtxBYoZ6WxWsZOMxJiENJS3r7NuPTJTUQ6qo5m8goy3gesS+pyebM0UHQLaQjNhnt9x7ViYlwFzue4dFvxLphF4okzUS4GHozd0kt3CiwlQ8NPj1bUM5QaldZkXm4+MG/c/ZPXNcf9su1+ACjr5vydxEW3rBseNjLHy4U3FSBB+G37yChg13fn9/ewLH81RYUSlej3/XQdryobCYnwhbI+DUodqH32jOzLUdPcpY1f7Ko+tElKQNylFcyPxG8lKGOKgRUin5EefcR/b5zxwnVUq1LEjFoB/HEEPSQIn4Q/j4IXEtOo5T88/mH+O2SOV3VKRuIV81hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BCnaoVMy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BCnaoVMy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPMnt1sqnz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 03:10:09 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so61593575e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779729007; x=1780333807; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=;
        b=BCnaoVMyIJ9rMctRD3ZP4XY5jjtuHzGC+pWJqXa4qIGxlIKGbYO5n/SD3L31Z8oh2d
         bPoFgrZc4k6IMeW5izaitn1LVZrwglslvUdFKzFlnhvY+MxboGadT9C7Yqz19pU7J9+G
         29On6Ewuw3cEoeLJDbeZswknNM6wrUnVxTgy9ECN64/fufzmsODgPhomxYzUsXzLDzFE
         yUWTlLVrmDedwT1AFdtW0y/14BDm5sCQVPIIcjSmc7cflIjfcNaslUuB6tB9BvskPIK4
         zbsSr8B2DkTM0MyxhmypLn1P77YYG26igLhp7GM5cz8epcIBHsQq4WF54a98c1tmd95f
         DIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729007; x=1780333807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=;
        b=EG1MHKCmZ7WZvZa+HgqsIWvUcPqFmUclPrzgMJNKILZ6swEOuHb1PbRPjbSVftXRzx
         gmaKgdkCE7NOgtoA2kTxzDaPepPG3ey6IwDoQVamII8MahM+3FjURvG0YA3ZIjv7rbZx
         b9/rrIGjm5C/z8oXKt8WrKUkM3SKsXLNSZTBjhBUuUBL+6BIdGP2nFHOHu9Lwa0k8wth
         fpyvN3ZZpCY35Hc9zpmb1WwflICB2Oe2Rvo5JiJVVNH3mEyOvknX2HceVM0CmKwIbU8b
         zj3N+asevikhU7Hgw8L6C5HEbY08RcyOwhcLnBT1a3ww3rh1CkSpPYdTP0lzLPXbl17Q
         k+Jg==
X-Forwarded-Encrypted: i=1; AFNElJ+E9qW9BUWMAPdHYupO0h0uONkRo9NcMnHYfNxikrfRcsxTRys+FHXPQpF52v/tY0dUPN6szVpIc/m98jU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzMB/Nfiu8ngdn/InVqD/vdLseEE/DGBF/RVRMlEpcmSRKebRA
	nCRzIwelx0qRSQkGWjVDTAAYEeBlfrpAC7hYFBaU6Abg2gK+GPw1xi6bj37dXNkszWk=
X-Gm-Gg: Acq92OGgg0jNs5WjsZs6bdUOfKVY276+NGaShVc/6blAjGTlvD+HMOnTWtiyWhZOJzE
	hBEOxsmZcigGoI1CPCyG2N5glFo+jp373x04j08bJDHn/bLOUpgpsnA3/mUzD4+Px2mSmHu+hLt
	AlOQ8qLb7iN4QlAibaB/2iOyu0A8Yh86X7TlCoFu+7NojSVdz2TwiCgI05xvV2b2cIRsu/jEmL0
	txJNNgZ8Ga4tV6o6rKDWFrWKCAzAie00vIs+25NlfhjvHzYW1/DG+I/5s3fZFl+BIo3vPw151n4
	Xn6gyoSOYdwJMWQ+uuJi2kbSBlFOKvKQTkrrFwIeq1VuWwcBSY765iDGeBUsGDHCjHE04U5Fmee
	7tvY6XMmd3pOOB963u8LoHvcgArL++U45JPwGYHz08VA//w+FWIiphsAFMz14cg+uejs45lJeIM
	ud0qVsSmcFI2HpgCJM3KiQOOQjSNDRa027XMa0rwEi/m4Nf1Wqduyi11ZmYeNwqxPdARnvfiKCn
	oa7c5hv4FDp3+YQzDI1YzgKsra5JGfv4qdPPCyqXpHbUQ6cJWZhBSFDEYdjJH7XprU7BDoFh61Z
	jGUOH+7zG1VxfoM=
X-Received: by 2002:a05:600c:35cf:b0:490:44eb:c1e5 with SMTP id 5b1f17b1804b1-49044ebc257mr277307095e9.31.1779729006482;
        Mon, 25 May 2026 10:10:06 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm456877405e9.1.2026.05.25.10.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 10:10:06 -0700 (PDT)
Message-ID: <a192eb5c-5d16-483d-862e-d937fa1b8269@suse.com>
Date: Mon, 25 May 2026 19:10:03 +0200
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
Subject: Re: [PATCH 08/11] params: Convert generic kernel_param_ops .get
 helpers to seq_buf
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
 <20260521133326.2465264-8-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-8-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Convert the generic struct kernel_param_ops .get helpers in
> kernel/params.c directly to the seq_buf signature, drop their legacy
> "char *" form, and refresh prototypes in <linux/moduleparam.h>:
> 
>   param_get_byte/short/ushort/int/uint/long/ulong/ullong/hexint
>   param_get_charp/bool/invbool/string
>   param_array_get
> 
> The STANDARD_PARAM_DEF() macro expands to a seq_buf body for every
> numeric helper. param_array_get() now writes element output directly
> into the parent seq_buf when the element ops provide .get; it only
> allocates the per-call PAGE_SIZE bounce buffer when the element ops
> still use the legacy .get_str path. The common "rewrite the prior
> element's trailing newline as a comma" step lives outside both
> branches so the two paths share it.
> 
> The non-core changes in this commit (arch/x86/kvm, mm/kfence,
> drivers/dma/dmatest, security/apparmor) are the small set of callers that
> directly invoke one of the converted generic helpers from their own .get
> callback (e.g. an apparmor wrapper that adds a capability check and then
> delegates to param_get_bool()). Because the helpers' signature changes
> here, these wrappers must move in lockstep. Each of them is updated
> to take "struct seq_buf *" and pass it through; param_get_debug() in
> apparmor also pulls aa_print_debug_params() (and its val_mask_to_str()
> helper, in security/apparmor/lib.c) over to seq_buf, since that is the
> only consumer. No other behavioural change is intended.
> 
> Custom .get callbacks that do not delegate to a generic helper (and
> therefore still match the .get_str signature) are routed automatically
> to the .get_str field by the DEFINE_KERNEL_PARAM_OPS _Generic dispatcher
> and are deliberately left alone here, to be changed separately within
> their respective subsystems.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> [...]
> @@ -453,36 +457,46 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
>  			   arr->num ?: &temp_num);
>  }
>  
> -static int param_array_get(char *buffer, const struct kernel_param *kp)
> +static int param_array_get(struct seq_buf *s, const struct kernel_param *kp)
>  {
> -	int i, off, ret;
> -	char *elem_buf;
>  	const struct kparam_array *arr = kp->arr;
>  	struct kernel_param p = *kp;
> +	char *elem_buf = NULL;
> +	int i, ret = 0;
>  
> -	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -	if (!elem_buf)
> -		return -ENOMEM;
> +	for (i = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> +		size_t before = s->len;
>  
> -	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get_str(elem_buf, &p);
> -		if (ret < 0)
> -			goto out;
> -		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> -		if (!ret)
> +
> +		if (arr->ops->get) {
> +			ret = arr->ops->get(s, &p);
> +			if (ret < 0)
> +				goto out;
> +		} else {
> +			if (!elem_buf) {
> +				elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +				if (!elem_buf) {
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +			}
> +			ret = arr->ops->get_str(elem_buf, &p);
> +			if (ret < 0)
> +				goto out;
> +			seq_buf_putmem(s, elem_buf, ret);
> +		}
> +
> +		/* Nothing got written (e.g. overflow) — stop. */
> +		if (s->len == before)
>  			break;
> +
>  		/* Replace the previous element's trailing newline with a comma. */
> -		if (i)
> -			buffer[off - 1] = ',';
> -		memcpy(buffer + off, elem_buf, ret);
> -		off += ret;
> -		if (off == PAGE_SIZE - 1)
> -			break;
> +		if (i && s->buffer[before - 1] == '\n')
> +			s->buffer[before - 1] = ',';
>  	}
> -	buffer[off] = '\0';
> -	ret = off;
> +	ret = 0;
>  out:
>  	kfree(elem_buf);
>  	return ret;

Since you're almost completely rewriting the logic in param_array_get(),
I suggest tightening it up a bit. The function could warn or return an
error when a kernel_param_ops::get/get_str() call adds a string that
doesn't terminate with '\n', specifically, when the call adds either
a zero-length string or a non-zero-length string that ends with
a different character (unless an overflow occurred).

The updated code silently stops the loop when a get call returns
a zero-length string. Similarly, handling of a string not terminated by
'\n' is halfway there because of the added check
"s->buffer[before - 1] == '\n'".

-- 
Thanks,
Petr

