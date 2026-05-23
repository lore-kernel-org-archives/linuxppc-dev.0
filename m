Return-Path: <linuxppc-dev+bounces-21421-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6BCCD5BBF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 00:46:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMk3C2KG9z2yH4;
	Sat, 23 May 2026 10:45:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779497159;
	cv=none; b=Qo9Rj2hIT2l40ZSbJzURe75ShE09qXEf5cZmoAMcIKOosqAJ2HP5GOiKo+J6i7i67Ueoh6ENOEcPbB4iRqJdwamqUgMCZCF0QJWXHZq3aMjRexVUgD3r4HRbLqid9va38WMQt3wVIWwbahG/UyAyuI/PPGxY1ikv4QxPZkB++Zi23BAURCq9BjGwXbDoyTTIW02M9EJouMyQSX1NZfcJMzWZZXTRwWq7BtNXi7htrt4M8/Ia5ZwJ1CcSRDowjhL57UUHkwXHhEnTAAkAwbMBD/wrf0cM5vwLl1Eny8W7eXs6+PLG5zsq9wY/S6phJUPWArjnaSbAC57hjXdnBhpyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779497159; c=relaxed/relaxed;
	bh=Z9Ii4kFnGASPrJVUv4pLJyz9ASaQSsUSFT2aMNSnQpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjJx/bHe4gKY9SDXME/S7MXtEZEJKk5a50zpzUFr+7r2Ua4VVUESLKlBCl6MQK+hX9ZbkEJUB1fv/szgJwvyJIZ+X5/uHTLgmLiRj4M0TfBbtevh6Clmu7N5Hhornea5uKKMxzCPlYmyBJ1vLwUEijColcmX+GIHD/h89xungJUx3KeNtgEe9EXyOe8ZJ8M4MflShe6sgAyczbUJhmzAIZDixWM+MaPTxBH+fqP7XLeCpJBP0OeoZP3o5AOIhPUvgPcShJIokVtYd5S9kNdyMT8CkJaRKWYbBFSJwl3ZZCeHzB7ZLdOxkG+Uzxawk+V6fan+jkfuhFq3A0S5EGcEkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYrP9ADM; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sj@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYrP9ADM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sj@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMk3B1Frxz2yH3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 10:45:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B5E3542A04;
	Sat, 23 May 2026 00:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8D01F000E9;
	Sat, 23 May 2026 00:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779497154;
	bh=Z9Ii4kFnGASPrJVUv4pLJyz9ASaQSsUSFT2aMNSnQpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AYrP9ADMMstpZMK07X7RJX7Vi+LssxAckCYKP0qcdmy4tA9a9uGeNKXekQFeMbDY2
	 LDBidZU8qfyCeiIO2lTcwcq4IenY+1Wd9qlBghobsMk+v2M/w+YRP79CHe0dVbDprH
	 6m4cKDcu9eoRxsj9K8pW3klTEaPK47F9haaWHiA44qhhUhE1d+q0p7agQTc1CqKY7Y
	 TIm3cavZyfg5Ocnp8Ulrf7LvNxFf6kEk1G4wZqQ5n3xAgZSAUkznMwff7nIEvl1Awg
	 MCkN/vkTJiTtDyoIlmLFKVmTKKTBPE0rS5dN7mvUamAdq3cIcL7ggZ6AdKA3393vQz
	 kGvcVXqs9FgPQ==
From: SeongJae Park <sj@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	kvm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 09/11] treewide: Convert custom kernel_param_ops .get callbacks to seq_buf via cocci
Date: Fri, 22 May 2026 17:45:43 -0700
Message-ID: <20260523004543.86540-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521133326.2465264-9-kees@kernel.org>
References: 
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
Content-Transfer-Encoding: 8bit

+ damon@lists.linux.dev

On Thu, 21 May 2026 06:33:22 -0700 Kees Cook <kees@kernel.org> wrote:

> Using the following Coccinelle script, convert struct kernel_param_ops
> .get callbacks from "char *" to "struct seq_buf *" when the only write
> to the buffer is via a final call of scnprintf(), snprintf(), sprintf(),
> or sysfs_emit().
> 
> Since seq_buf_printf() will return -1 on overflow, and struct
> kernel_param_ops .get callbacks are expected to truncate without error,
> we must ignore the return value from seq_buf_print() and always return 0
> (as the length is calculated in the common dispatcher code).
> 
> @@
> identifier FN, BUF, KP;
> expression FMT;
> expression list ARGS;
> @@
>  int FN(
> -               char *BUF
> +               struct seq_buf *BUF
>                 , const struct kernel_param *KP)
>  {
>         ... when any
> (
> -       return scnprintf(BUF, PAGE_SIZE, FMT, ARGS);
> |
> -       return snprintf(BUF, PAGE_SIZE, FMT, ARGS);
> |
> -       return sprintf(BUF, FMT, ARGS);
> |
> -       return sysfs_emit(BUF, FMT, ARGS);
> )
> +       seq_buf_printf(BUF, FMT, ARGS);
> +       return 0;
>  }
> 
> No struct kernel_param_ops initializations need changing since
> DEFINE_KERNEL_PARAM_OPS already routes the pointer to .get or .get_str
> via _Generic based on the function signature, so converted callbacks
> are automatically moved from the .get_str to the .get callback.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
[...]
>  mm/damon/lru_sort.c                           | 14 +++---
>  mm/damon/reclaim.c                            | 14 +++---
>  mm/damon/stat.c                               | 10 ++--

For the above DAMON changes,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

