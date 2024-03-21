Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34957C54E58
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2024 21:16:44 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Vk54l/xI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V0yvG68HCz3vfc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2024 08:16:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Vk54l/xI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=javier.carrasco.cruz@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V0vW673nsz3dV6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2024 05:44:02 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a468004667aso196016366b.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2024 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046639; x=1711651439; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjH3xWAVxcLksXCnS4n7afqAXMFnAXHbQLt/fzJwwaQ=;
        b=Vk54l/xI0tZQTv2ysJaqcO6ZIc23g0nXw35HPTyNj3jIAxydArvzRML86hbu9jZwxY
         yf2QW7gwNwqIm38D99mwhpxG88Ep5IFpu04Mrh6ziazJjGN2f0lf4oHisdyVMXB5UlLC
         MQiOZr6KNdRNcNKi/dTuUjoMago9Nnb4x7T3CVHwR+y2dKanDaFsnRVPHOymZtwljCR9
         gmVB+yqbvQLK7i24+V2T+1HVKgC8ubTa/8aI6nq+HYAJPNjuFG2wILZnKVVsmmoPphtu
         I8gs7O0mEXbFL7c8JgWbTHgM2AYn0yPwC7+1Hk8yDZKf3pwEoadGXaxXs2ZIGTqUjUvP
         ybtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046639; x=1711651439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjH3xWAVxcLksXCnS4n7afqAXMFnAXHbQLt/fzJwwaQ=;
        b=mIkcPkwg7GJFOeMv7vIqfUH01pl5BUwBhvOkKbrcfDUBd+KnXUBNGoWQj7YsnQyn8E
         zvOr1qC1vE40toJ45dQeNnDf4z3LfJqqotm70B5b8aa1VjC2gchfXD2wfudNOFnC6pjR
         XfNYUaxLh1uH0RtczF2CatSvWX/C8CFbKCr9I4qSgTY2CnOJVpF3R0L4F5sau9H+TQNw
         EMLxGpAHPY7BDxph6UjwMzR5vNvv+CI2aDOk0hx/gLVixNVNmOlEkwtk6EssWFocYnGk
         3sr++c9taDj/qDJJos9ibRHu9KcGHCrBIZbfF8ePFCtloyNJnvrP29wfUd+s+QT+Sa0J
         zNQw==
X-Forwarded-Encrypted: i=1; AJvYcCXfSiwHZ9paZs9pK4ymjmJFD1rSn71pGfNmrOrzm9AguCQDOeK+e32L3+i0ia2N/tyB6WPrtVXN7BkbVwchs030+1EQTkMIHCywenaYjg==
X-Gm-Message-State: AOJu0YzY9W8a7XHkmisdtZWRtqwpGT/7xGLZj3J3YaVx7TLSxUQEqfSm
	9I7mLPu5pm69Df0vMbJ063fealNaT53K4t4y37MHoCHw8wexoeFG
X-Google-Smtp-Source: AGHT+IEyc+V2rYgEcWFTuNuI3kDNAkEe3lfiXa14/sba7m/sCsfv0r/xLVN623itYwLZeUtC/K826w==
X-Received: by 2002:a17:906:1387:b0:a46:c8e2:40f6 with SMTP id f7-20020a170906138700b00a46c8e240f6mr197265ejc.1.1711046639107;
        Thu, 21 Mar 2024 11:43:59 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00a4576dd5a8csm188627ejd.201.2024.03.21.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:43:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 19:43:44 +0100
Subject: [PATCH 3/5] dt-bindings: hwmon: pwm-fan: drop text file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-hwmon_dtschema-v1-3-96c3810c3930@gmail.com>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
In-Reply-To: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046632; l=541;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=WtXVHWYckALrs2tiGdx+CdxFz78VsyEPGAXNNvu5zss=;
 b=bQuEUQ397vzy8Jfx9LXE1DLb9HcUz0E9hVk1DYfWLzvdIqRa7kwMM7XS2iVsuxw1M9Jk1I4A/
 cv3JecbM8T4CRJR4jtV7jJtpUQW1Gt2GFqpZ8rXg2nQ+VqWzFO01uJK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=
X-Mailman-Approved-At: Fri, 22 Mar 2024 08:13:59 +1100
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
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This binding was converted to dtschema a year ago.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
deleted file mode 100644
index 48886f0ce415..000000000000
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has moved to pwm-fan.yaml.

-- 
2.40.1

