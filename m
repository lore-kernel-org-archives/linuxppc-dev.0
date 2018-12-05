Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81707C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 02:09:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8F22081C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 02:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RzfK8pdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8F22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438hxV3yjTzDqYJ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 13:09:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RzfK8pdF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=khilman@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="RzfK8pdF"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438gR26WgjzDqYJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 12:01:15 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id 64so9092702pfr.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 17:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=VJ4Xggx/M5TuF1a8xLngAs7VDg7Kg/bcesHAhVDONtY=;
 b=RzfK8pdFyLksbusmB8e3SXki8e8zPkdYAZia4U+Tfeln+wY1bkAbPX4QFzku5ofR0Z
 LRAeQft8ftzAr+g0BBTfKC2aWvMEk9rXQU/AYN9hwdmvi9R7rkggzbslm5r7fJzn5WKM
 4T/iz9GtYAkwZY3iFlD3lgTgmkv+4RbZzRPfugFpSXAmsvtp5DW8t04rYfE5SECxCua6
 z3DldOYh4Y3mZgcUQDboEHQu7sXT0BwfCjk8M4frTt/A4/8Gjiy5j9SwA7A/VsnfVZSH
 Yzu5eMgUlqXbYXPc/jy6Er3rBV1nBNTE+AyuqJFRsOeDpwKNPOedbeVKxpoeAdoYcwyb
 5zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=VJ4Xggx/M5TuF1a8xLngAs7VDg7Kg/bcesHAhVDONtY=;
 b=tFns1Se8nOqUz+0eyzB65TEl7eN3LGoOv6kTBZYob009wCkjcOex5v90b3/IgjdYFE
 F4plcMvN+FTu8Koc8o0TRwy1sBQ8OmjiwCe7pgR1x5ANnM/hXYj4+DAgL3J4Drp9rcvg
 ezC3dr85XLuzA/qMmKQ/2d91eB8s0457fz2s2o51Z5ZN1xxugramZgizvhW/moPnV7wj
 avy9Xiq4KTsQUj03WmnRm73GWFC2EfzarlENe1mp98rmCNoysIGUcSp+aT3wDiXv78gF
 ZqG4AFlTm9h/22K4uejeYMZ/UUYRnTdnjHD/CEt/SaHcWBLncWGVyfB99X+kgytjbD4+
 dcaA==
X-Gm-Message-State: AA+aEWZVackkm6sqR9aP3SQi6LUNp/9UjoMFjDMxLxC6im4n89zrC7DQ
 U5gfLPruX6XfFSuxN1w872aGLw==
X-Google-Smtp-Source: AFSGD/XucL5NZBkNTnqI9hosWyuzrKRTkweZcEuw0ajmO8GnUu/pgA/O0jxAl3OIKVAVP93NXQy9/w==
X-Received: by 2002:a63:f658:: with SMTP id u24mr18745008pgj.267.1543971672921; 
 Tue, 04 Dec 2018 17:01:12 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 e128sm25594123pfe.67.2018.12.04.17.01.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 17:01:12 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move 'amlogic,
 meson-gx-ao-secure' binding to its own file
In-Reply-To: <20181203213223.16986-14-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-14-robh@kernel.org>
Date: Tue, 04 Dec 2018 17:01:11 -0800
Message-ID: <7hr2ewbxd4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 05 Dec 2018 13:06:59 +1100
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rob Herring <robh@kernel.org> writes:

> It is best practice to have 1 binding per file, so board level bindings
> should be separate for various misc SoC bindings.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
>  .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
>  2 files changed, 28 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt

Acked-by: Kevin Hilman <khilman@baylibre.com>

But this isn't really related to the schema series is it?  If you
prefer, I can just queue this one separately via my tree.

Kevin
