Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D179C3A59E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 05:44:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEB62089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 05:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7HOIcOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEB62089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NXp60xy7zDqdX
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 15:44:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7HOIcOF"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NXm60Q03zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 15:42:59 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id x15so10589589pgg.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Sep 2019 22:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=/vKI/xtQQlEFNhFbyn9evKm0aZnte8W4Hq+F88vuIdI=;
 b=E7HOIcOFXmqv1o8xG/+0CQv7Cb20qBLrKhBcpvho4TGNzUhwZJ2/dwDBI2YO6UHYpC
 pT8jGuqien6kU5G94FYeaZSNLz3c1lLlH3oKONHZQDCQMZwj+NfP0fQ8HSG/DyN6bqia
 AR7QscQrEQeVb3lOyEr8lXu0RGvU+dhsw67soFeVQZdRnfxIXYmKrOzXJMQ04GjXwE86
 b9rEQYxDJuncEXcCo8GmQ0jwdD8BYjvW1LNgqxk52E8pX5XQGg15N+p/2oCBVT19841h
 qPKthatg1oVRC5XP1Fu+ASx1LVu8sOIsh2244fsw/TUHSrHQC5kWIMdZmMHdcL9Gtk9h
 rg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=/vKI/xtQQlEFNhFbyn9evKm0aZnte8W4Hq+F88vuIdI=;
 b=r1M03EsPaywaY6ZZlVzimW8KnyNKCa2IkIlvVfKzJSZqXi8p3bSwmC4E1O8hvDYQE3
 CevAar1WRIUiQNwH1toLWJm+O6kuyiO5pEmiOkZR7lWzfsuk8yy/ctZv51rvK0BxndZb
 pVREeYqrKrnrsAsxuIIvF5Kd7ZcTakemqQofQbaorBEfLYL3Ehij4Cxr4tKCHUHPU9mq
 +lZ5GwBhntP/bs+yuKJBuLAJViXngDWuiv6w9w39hKlv8Jk7FEhPtErMh7mvC5xqLscC
 ZaiLMyGYu7bLPw6eo+7SE/SB+T7g3GEH9kb8u84Dq5BxiswZkv4DRtSu7e6wCk2FNiu2
 plCw==
X-Gm-Message-State: APjAAAUE/EuHprM83H92ept0YIdoKRHyFIqaGZ87MfyzJf7WK0NevPkk
 lsFBucHwh942jTNS/2uBYgU=
X-Google-Smtp-Source: APXvYqycDvwzhznYAgJsQ1bBhLESqy4XeRJ7wlvJq1+JUK0lZ1bSVQ0c71FiPGuNvgra0pyHGZrPLA==
X-Received: by 2002:a62:e802:: with SMTP id c2mr8693508pfi.212.1567575776084; 
 Tue, 03 Sep 2019 22:42:56 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id b5sm29335714pfp.38.2019.09.03.22.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 22:42:55 -0700 (PDT)
Message-ID: <1edd23fd93386d8a69bc9280329b2d7c819155d4.camel@gmail.com>
Subject: Re: [PATCH v5 16/23] PCI: hotplug: movable BARs: Don't reserve
 IO/mem bus space
From: Oliver O'Halloran <oohall@gmail.com>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>, 
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 04 Sep 2019 15:42:50 +1000
In-Reply-To: <20190816165101.911-17-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
 <20190816165101.911-17-s.miroshnichenko@yadro.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-08-16 at 19:50 +0300, Sergey Miroshnichenko wrote:
> A hotplugged bridge with many hotplug-capable ports may request
> reserving more IO space than the machine has. This could be overridden
> with the "hpiosize=" kernel argument though.
> 
> But when BARs are movable, there are no need to reserve space anymore:
> new BARs are allocated not from reserved gaps, but via rearranging the
> existing BARs. Requesting a precise amount of space for bridge windows
> increases the chances of adding the new bridge successfully.

It wouldn't hurt to reserve some memory space to prevent unnecessary
BAR shuffling at runtime. If it turns out that we need more space then
we can always fall back to re-assigning the whole tree.

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c7b7e30c6284..7d64ec8e7088 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1287,7 +1287,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  
>  	case PCI_HEADER_TYPE_BRIDGE:
>  		pci_bridge_check_ranges(bus);
> -		if (bus->self->is_hotplug_bridge) {
> +		if (bus->self->is_hotplug_bridge && !pci_movable_bars_enabled()) {
>  			additional_io_size  = pci_hotplug_io_size;
>  			additional_mem_size = pci_hotplug_mem_size;
>  		}

