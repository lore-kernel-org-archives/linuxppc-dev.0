Return-Path: <linuxppc-dev+bounces-4779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C276E77198
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2025 12:48:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YS9pD0dHgz3bWy;
	Tue,  7 Jan 2025 23:48:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736254116;
	cv=none; b=WlOkcoyAl1IErS7S59fQ7uwNU34guddgxcFE1nox55kgv30fXdKBPRW5ZVrLm4FfgZEB/HvAOLUVa+gjY3UCmJQG70AB42NynNf3BfekXaoBr+GV35ZIBTJmLd/Ns3okbN9E8Ws5UsTgcoAbGkeiVYYV583t+pGJLXzNvrUmjEdqWOT9tEr9O7JbFl92BZHrcJv19CE4tBNp9P3wDJiPpsAhDljKUChuTLgXYyzIDTEBUJm59T8IvYYmjVyzRWojuYhBRZkYHBH/o0VzzDHMYVWdcfY10NIXcB0vmxfz7XOmt3/Tpgz6qdAoZW4T6ju4sDYLyScTbqan9al08aeJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736254116; c=relaxed/relaxed;
	bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOuatrphzpWw6YCuWWA9Nnn0YaFfxzzGt0ZiwCCdSdB0PCu1ulqd5sP7SeHdNgZsIsgag0gSq9aX44WgrfBKIpXQePVtUiZeHZypjaX9iq3EJHckUrkH5xcYjKhUyetkzreZpQxnSE4Km8dJdDifw1p9mAT4qwDIFeJPd7CiEN+dhN06TZ2ZqupfjjyPUL1b8pogQtww/v35ui/GnES/N7FIwmTb3BwFLQ2O7lifxipUSIcL5JGbUGIakC2jnyyuPHlpzRXxNLlSFV4gmvJXh/6q/pJP/SjDxbiwZw15G8kZEvZjo8TYQiqyzjoXG5M6KqemgIL4JNMm6kLcj134Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=daynix.com; dkim=pass (2048-bit key; unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Vpxlbbd0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=lists.ozlabs.org) smtp.mailfrom=daynix.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Vpxlbbd0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=daynix.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YS9pC0908z3bxf
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2025 23:48:34 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-216281bc30fso6460815ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jan 2025 04:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254112; x=1736858912; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=Vpxlbbd01mVr2p+VGjEgHJW8/NEbYQ9n5OcaFiNfgUgS37Wqf9lr2hbzUFK8JegvS1
         2pJuw+1qlbtzPXcYSeAKKHS7L9chzKWauaYPeCp5Ys18W7wGnu3CYaZTicitChH6IdzQ
         zpxeQaTWcvO9kGGkCyOqa7LGyDWsylT9uUa8pjEoehZSsyO7qXst6Tni0UaKYQFb6+ai
         vaTwF+Sfnwm+C3loHod6nm7lNyGDpYqmrg4jpaSR7TiX0AhOWU+seHEwI71DCE+dshnx
         f8K19fF+x4sbaat0nMOmfKiMVXRjugR/lInMpgoRxtAOwafaBZbUORAiKvJPjZFFytBO
         tfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254112; x=1736858912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=pgA6t+boKhmZZ2zIHxMxtqJpqoQ5B3ohpOG8lRGGQJDtkWXJcIrUf+NS6+nu9KQAZw
         JoX5+iYqQKW9jhQp5xgurgNmUwjNHJc0s/yDg4RDNq1VJMAvhhB++gYbIicLsfohOa8j
         5a13Z7KdtoivdW1PJPoXYN7TRQsZnPWyZuF4OsCX0CLsx0swOCLex+9g/hOAFFPVl8Az
         rmy+52YVkpVY0lb8Azdy+5sW/TgsTUFMK1bxBufaqO9hf5dsudx1sobfpF0etUtuDtC8
         XOoZnHRh+LyQddQCq8VKa9YiuUmz6nRafU0Wlu7kKp47ywLF2oc+uzHJbz4cJ0bLPaKU
         8qog==
X-Forwarded-Encrypted: i=1; AJvYcCWs5OcLasrcJcKXPIEpWHzwYhSF05OrzXR+DPKdQRpASygMf+sw8omgGtFDwS/213c3ObVYaQIgz/9vODY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw19/+KElkak+0VAbluLsvgpP1dxwwjmWI1zms4nSAbPKWZcBoo
	VIvCztQ+8TkxGn1rENPO3Q8HuS3pPRalMFwrZFq/Dx5K7neyDA/1+NhulFAXsOE=
X-Gm-Gg: ASbGncuTox9RpbGyQbWI7paQHckspGEi+Fg46IBk/AUVsZXuFU6Jd4JONY58l3JTghD
	1gCx2tQR+kkUah4q3rybvIw8zmI8F3Ct7wgzuQC3hQnpkt9vZ0OXzDk+VuXG0NYRwzJDN2A+4JQ
	DgvNxbcDZ83krzJ7s78EzZN6ueVGJ2A4fTdkz4D//AWw/ybYfeXJ3DYsoUGiDSLZHJnoibEZZv6
	l7LoErwusiKHvrXkZa6zQ3pws/6bcWRwxiCdmR+N7K/I094wBBg3cfwQmY=
X-Google-Smtp-Source: AGHT+IEgGWm+TwbUeO+9N7FURX28AGtJrPEUj7uS49yO94eCRFf85XIQjkIdMNAyflZYWE42i4plAQ==
X-Received: by 2002:a17:903:22c6:b0:216:2474:3c9f with SMTP id d9443c01a7336-219e6f38177mr919043015ad.52.1736254112256;
        Tue, 07 Jan 2025 04:48:32 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dca02f72sm310596305ad.249.2025.01.07.04.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:57 +0900
Subject: [PATCH v3 6/6] crash: Remove KEXEC_CORE_NOTE_NAME
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-6-99cb505b1ab2@daynix.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
In-Reply-To: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

KEXEC_CORE_NOTE_NAME is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h       | 2 --
 include/linux/vmcore_info.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..c840431eadda 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -68,8 +68,6 @@ extern note_buf_t __percpu *crash_notes;
 #define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
 #endif
 
-#define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
-
 /*
  * This structure is used to hold the arguments that are used when loading
  * kernel binaries.
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 1672801fd98c..37e003ae5262 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -6,7 +6,6 @@
 #include <linux/elfcore.h>
 #include <linux/elf.h>
 
-#define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
 #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)

-- 
2.47.1


