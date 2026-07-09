Return-Path: <linuxppc-dev+bounces-23919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01674C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 08:50:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwpZ03mDmz3c6n;
	Thu, 09 Jul 2026 18:50:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783587000;
	cv=none; b=P+rXdJDbG7ls7Z+1Y8WpqWw9VyyrralFkmfdvpRExFsTQpOy4geew32OlFzd2H+wikLBKppi6joKXeCJPJ1ljYMWbHl5BTj5anG3zQFiSZFwGF/M9epg6/KguI/VuLZ8Mc+cQ2axFU2825KW7bcVXU0fGM4I4gL684dqAR0kPiaym+oZ0rPhguQf0PW6t9n6rlob3bT1D0YXW1ZSsBPijOHUkjJM4pxRjJPWCRUQU0b7fITBes2n65SHLZTyckmZzd5hPa4qYPNv9xhEY6I8ktZuuBwft/k0dvqzaZMuP23q0L3PlzvIYa9+EfVC0c4dj8VA2ZieTUdlpR/nGifVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783587000; c=relaxed/relaxed;
	bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwG6xgsTRknpkjE+BCY09lEfi1T3mbq174scE1fTK6tVAQqGtDoBDLE2QS8gvnN+3NnUWkHDHnlRwM4ZmiWUlQFjOAsWAw+vqbxEw9mncd3aly0RBqXeoR/Q9/pddYmqHXiY+xUo/mZCk9YdHyKrsATxL23fQmfbIMJs7vkwjkJgCla6mnVBJTYYA4Zdd/q51cEvn/9qzvQ1fwNJRcQt8n+Gz7HHXL6fh1+g6IuEotwUCzfxpLqY9zFTww9iMZaLQ0UJ58dldmgoxqh3/Wfb5mt6YO5ho18Ygqt2plBnh+wTA7DdyPye3pCGxtGWt0DTkvv7NwdQOiJ99ydBoK3VXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.214.169; helo=mail-pl1-f169.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.169; helo=mail-pl1-f169.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwpYz1XhTz3cH9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 18:49:58 +1000 (AEST)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cae1a3a744so12395415ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 01:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586996; x=1784191796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=;
        b=YqjuMYBBSAG/CZ1ufFHP6rkmpeb20C7+hQ2oSHxnjh1ofkK0F2HxyzoHJuGhKr2Btg
         +g52bDuKLuVk6HDwcRJpz3/Ncwuq/bzZmS/WFnx5cClQGTKEyX4YflFCD90Ch58V2YRB
         6Nyp1D9ZtSOmiCCFc+I1TfylpAb9vXqmk5p3sjRnvYaWb87ssCYwB/oeI76cO8pqVcmz
         Mdax4klqWxIanV2zxx2D6Vz2/tqrdVfmuoYBXY7YJAZCe7tzizrM/I88LDmY9TO+fmIi
         U3aH2qr8iFwQ2JrgmL//aPApk1wKRyy1+m7FUn8JrpIs7yamlYi/kIaObLXynyczmBLP
         TTjA==
X-Forwarded-Encrypted: i=1; AHgh+RoyHMg8a4Jn2DHDASjDowylGaJuLk58ZdUyk45Psvn4UymKGVa7dRQB63t/qR9C+ohPccmoDk7C4F4fYTI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyu1EslYXWvQ0U325iukRU9XC/AxPKYtlyY//541xh+QU/SRnIF
	SeRJp0VmqD2WVKU8XIepcr6EKyYc8QxXl+wLmzkauCLw7br1ZSSgywc8suwdhcNEZOo=
X-Gm-Gg: AfdE7ckJ+uXEkFbBl380tpk8InKBcr6UvVCkNQgcIeIqGX8QguCPZkTuvi2mOOXE9LP
	NfwQnWDAN72fDz/h+etIMtdZoPoSFIdtK1lOGKcjBqPC1z9Gus0u+Wc2pizSIiWLcA+7MJus+nu
	gXFHhxtr8E7+vmoBHmExmX5i1su/QfznmILlN8gWd43hFhkoexdqt050W+xNsdfk5RNrVh4qY6q
	t0lhPprBnSm3eBJoJmRE8mrrfMmY/in82hc8KDgKsf3OM1bL1b7JNgWxMrUfDZz0ReY7J6GuG/h
	qEHRaGHP/Od56qiV6aZklalbIlIXLQVxYQsB0Kk+LL3/+MNzwI+/iWmLhvGYZW0jXOT8FJ4b6cX
	YWcob+rIJkq/poBjXfJXWjpsPmhWs/LAGroWF7B/OYBkGbSCsvh/eDWNF/kFTxrGZPteZpgvyIo
	JBB6J2HC5cvx1l77s/jOFRkSUJW0iFbOg1edIgI0SblKTNSvaRO9NGNQ==
X-Received: by 2002:a17:902:e5c5:b0:2cc:9a86:9c42 with SMTP id d9443c01a7336-2ccea47e1b2mr55735875ad.45.1783586995670;
        Thu, 09 Jul 2026 01:49:55 -0700 (PDT)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1eea1sm40692125ad.46.2026.07.09.01.49.55
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:49:55 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c999f162c9aso932136a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 01:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RribYxVrX0n/VvlEXzqRd5tYEKXPJ8htpnskp5hAYXaKW2h1yJq7Q/Cg/T7wJtux4rfhl7zcNLtf53OWp8=@lists.ozlabs.org
X-Received: by 2002:a05:6102:6895:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-744e03a337dmr3306957137.20.1783586528282; Thu, 09 Jul 2026
 01:42:08 -0700 (PDT)
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
References: <20260707181957.433213175@kernel.org> <20260707190254.280015701@kernel.org>
In-Reply-To: <20260707190254.280015701@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
X-Gm-Features: AUfX_mw8w2Kp5VuAYozzfDNS6gDbdKhQdYzfXsv-G72F3LS58UBytbGwOmplITc
Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
Subject: Re: [patch 12/18] ptrace, treewide: Rename ptrace_report_syscall_entry()
 to ptrace_report_syscall_permit_entry()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 21:06, Thomas Gleixner <tglx@kernel.org> wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
>
> Rename the function so the purpose is clear and make the return type bool.

>  arch/m68k/kernel/ptrace.c       |    2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

