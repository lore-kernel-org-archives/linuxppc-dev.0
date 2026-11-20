Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848D606A325
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySw2+zVY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1Tg2GxCz2xmh;
	Fri, 20 Nov 2026 14:46:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795146375;
	cv=none; b=LEDqq2L6H6jU0RMSIKCtjVLb9C4cXXxsMiPbJpZqt9z/2X5gGqfsbVNBlII2e+4g0LR8Oqz1wZTzDxMJGRPdb7xRlI2hIMgVsoTuPHye07OA+shSqqJEXmsMHCSV8X8dlGjCcPy77HGpuyUOHoYmJMaDA9junrufa6vyOTV378NJIN8/6QneQzXNrSaX79tLjgZrOfOcfc5qSI3HHnwyuASoIEZ0CM4bAF5t/J40FJ8qKtu6sVd7BGox9q002DgeNz2x9mxc7RTOw3HzONvm6yjEz8KGtTsiNnpsSpjtjL/Bxj3/Z3luo2Guqup6PgCl7OtpPphhncRgAPR3xjhiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795146375; c=relaxed/relaxed;
	bh=BLOg8atkDopv8yRViq7RL0BP5AVfcru44tPtNuP8ip0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=E+4jI3I1mUpugh/zvDuxh15xoGY6enUzj4WyYAB5CFyUy9mbVANvPPxnjgwMFbVAaEtrAMdsAiDjl07TETBjuA91mtYfJhPlm3UgVNk/2cKbJB/LgEwL3LjBLh+EbIQcjGBirzPh4Tvh1VLrnB+eY9NTcIUjqm3eusaxlEt2AHSeyfsLLk0kFE78aYShBbuyi+umcF/7ujlJ9Em2dNQjWMZ6r3ApLiCVWgO760Ow8uFFUtFJTOudvAyB2/8S5EIV2EDtf1Nf5xFQPCS69d75wf8u5MMob+w485ysMgMpfNFhW1+7EoBPSfDb3QQcPIFtLZ+s4WS1guQOywf/3EFrBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySw2+zVY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySw2+zVY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1Td6xGwz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 14:46:12 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-382c3c9671fso592814eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 19:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795146371; x=1795751171; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BLOg8atkDopv8yRViq7RL0BP5AVfcru44tPtNuP8ip0=;
        b=ySw2+zVYmsf3hlnya2orb+bi9ntcfedNRfzdLHhJofP4NUC0ATXEfgTDCU04y9oI0K
         MO6z5m8dgqKSHdgCC3K5+Uj+ehFzR3iR1PEGKw/s3iyLgYeFnp81uyd7Ok7Xs5knjoMP
         KV0h3hWQrM/q7VgGtbrmSBEQ462t4b4HYYnn8kdZJH22x0kP8UKir6AHLcAbEs/z4VoH
         wEgxgPF7sB9jRpPvvTDfdVkgVPpwnNY/fV4EyQpSnO61hc0HlaqnBVAJTTIdrKplVv1e
         F/VLI5hvuAbP8N5V9Y4osb000wIz1LU7AKMQJvl6f03FC4Lnq84v5x2j3yhs0dytUNLY
         Gnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795146371; x=1795751171;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLOg8atkDopv8yRViq7RL0BP5AVfcru44tPtNuP8ip0=;
        b=PMGZQKwJ3HH9BkDqOxTfVTkN4JeDGneU9k4GwWhfpGkbzcGXsKyTaVKtbpR9YRN8qM
         5UsMwvEw6a5wpR0OlQFD6t7gfjoZZldPiFC2n9quaI48wA5aXnew5QszxpO93SDlIyoW
         oXMUytotIDF7lQ73Qi11WPfNTBEhgJ0wKPxN1MUlVvFiS1DiwTaICNMhA4/A8ELO+clK
         pT1jOd67ZtPFgEMhSczMrz/6cGvUMCzpEs0FWGbYcuhJ5R02DW5eiuRzS14aRYxRsWba
         IubV6AibdfCmTUn+azM/a7Ic1jQnalwIbKQeaaYTcJSeoNxfIRCKpFi5jzmIscr2vO7H
         3E6A==
X-Forwarded-Encrypted: i=1; AL+hErECXVSUEACQQEClxmQJMniKXzurZyaQxZClUJATTZpuBWWdirwtx/i8HMyg5Xqv0JjKoqEZvK9DlWKNEXA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/3CUJIuyyHHs0s1I3xhD++UEZhuVz8lkSm27rNc8RUURnCNmqh
	VFXnColPf8XE8p/MbidYVog+wmI/J0/6IXGmwuBBsZgP2ltOYXk2LteD
X-Gm-Gg: AZFdTZc7C/cv+USBzEajximJTZI4ix4QtHCJK0FOAoCRz6aI1CcpknM70VQAjqANokF
	xdY79oHLR/N2Y4K/vKFgniAQP+CFpEYYazdI284vsI4FFpawJqF8Tr1Igv/xQ2ju4Q7daSQ/Y2V
	TFwYBbKuS6ij0Vl/RbGZ+kYDxtT3XFSjDgL7W7pCyj7cpXHKrYRYgJBjsNXortq+7zUa4NJAj+T
	QS4YGmKNtmXfQ4dezca/gMRs/kgwhtgyZhEthWlxEXjgIl93uvQc9kpcJSH3er5ujRNHtBVQ27u
	HSSlLELhhC2HqowjHQzuKhy6XfQ1+vrb7iEEzGhwHtOafT2y1i6+y9EgGMQgnHMAqxkbhEy7wUc
	KtsXLorlisuTNDj5lL7c4NkHJJktVqUmuBAv6nzZAj6Dk78WUIZQHz3anMfhN14khUcNlrBBF4u
	Y0ZROYE/3vAbXcDw871AcQMVHCehHkik4JYXY1G8ffrD/YWz3xnVsqoVYfvarb6TvYGKwTy63yb
	iYRBrES6aoY+fymR45iIrs1SVb7gBfN5gQGXJBbxCcpbeT3sivvUigl163MOBfBB4MOC+lNWOQX
	uX1UOiLeOJm5M+fUdPf+oMBz5i8XIGGtQMSRx7UxpP/p56zKaA==
X-Received: by 2002:a05:7301:6183:20b0:384:b2cb:5f76 with SMTP id 5a478bee46e88-3856fe5ebddmr1428480eec.23.1795146370720;
        Thu, 19 Nov 2026 19:46:10 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm2702820eec.25.2026.11.19.19.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 19:46:10 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, npiggin@gmail.com, chleroy@kernel.org, sshegde@linux.ibm.com, oss@buserror.net, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc: Fix missing of_node_put() calls
In-Reply-To: <20261119075827.45823-1-jyoti@linux.ibm.com>
Date: Fri, 20 Nov 2026 09:11:29 +0530
Message-ID: <1p8gkw46.ritesh.list@gmail.com>
References: <20261119075827.45823-1-jyoti@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

Jyoti Gupta <jyoti@linux.ibm.com> writes:

> Several PowerPC code paths acquire device tree node references but fail
> to drop them on error paths, early exits.
>
> Add the missing of_node_put() calls across PowerPC platform to ensure
> proper device node reference counting.
>
> These changes prevent device node reference leaks and improve overall
> resource management in PowerPC code.
>
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> ---
> Changelog:
> v1 -> v2:
>  - Rebased onto latest upstream.
>  - Dropped the powermac/smp.c hunk: there is no leak there. The loop
>   iterator drops cc on continue/advance and the existing code puts it
>   before the break, so the added of_node_put() calls were a double put.
>  - Added Suggested-by tag.
>  - Link to v1 - https://lore.kernel.org/all/20260930182304.341123-1-jyoti@linux.ibm.com/
> ---
>  arch/powerpc/kexec/file_load_64.c            | 1 +
>  arch/powerpc/platforms/44x/iss4xx.c          | 2 ++
>  arch/powerpc/platforms/44x/warp.c            | 1 +
>  arch/powerpc/platforms/85xx/mpc85xx_8259.c   | 1 +
>  arch/powerpc/platforms/86xx/pic.c            | 1 +
>  arch/powerpc/platforms/pasemi/setup.c        | 1 +
>  arch/powerpc/platforms/powermac/pci.c        | 1 +
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 4 ++--
>  8 files changed, 10 insertions(+), 2 deletions(-)

Mostly minor nits. Otherwise largely looks ok to me.

>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index bd80c5fb1b1f..8d4d6a51c046 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -204,6 +204,7 @@ static int add_usable_mem_property(void *fdt, struct device_node *dn,
>  	if (snprintf(path, NODE_PATH_LEN, "%pOF", dn) > (NODE_PATH_LEN - 1)) {
>  		pr_err("Buffer (%d) too small for memory node: %pOF\n",
>  		       NODE_PATH_LEN, dn);
> +		of_node_put(dn);
>  		return -EOVERFLOW;

Instead can we use goto out and use the common cleanup defined in this function?

>  	}
>  	kexec_dprintk("Memory node path: %s\n", path);
> diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
> index ef883d97fe15..ef92b4656d17 100644
> --- a/arch/powerpc/platforms/44x/iss4xx.c
> +++ b/arch/powerpc/platforms/44x/iss4xx.c
> @@ -74,6 +74,8 @@ static void __init iss4xx_init_irq(void)
>  #endif
>  	} else
>  		panic("Unrecognized top level interrupt controller");
> +
> +	of_node_put(np);
>  }
>  
>  #ifdef CONFIG_SMP
> diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
> index 6f674f86dc85..49afd60b1c30 100644
> --- a/arch/powerpc/platforms/44x/warp.c
> +++ b/arch/powerpc/platforms/44x/warp.c
> @@ -183,6 +183,7 @@ static int pika_setup_leds(void)
>  				printk(KERN_ERR __FILE__ ": Failed to get %s led gpio: %d\n",
>  				       led->name, error);
>  				of_node_put(child);
> +				of_node_put(np);
>  				goto err_cleanup_pins;
>  			}
>  
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_8259.c b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
> index cb00d596ad80..9b7283038892 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_8259.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
> @@ -52,6 +52,7 @@ void __init mpc85xx_8259_init(void)
>  	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
>  	if (!cascade_irq) {
>  		pr_err("i8259: Failed to map cascade interrupt\n");
> +		of_node_put(cascade_node);
>  		return;
>  	}
>  
> diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
> index 9ca36de23532..4cbcc16b1009 100644
> --- a/arch/powerpc/platforms/86xx/pic.c
> +++ b/arch/powerpc/platforms/86xx/pic.c
> @@ -58,6 +58,7 @@ void __init mpc86xx_init_irq(void)
>  	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
>  	if (!cascade_irq) {
>  		printk(KERN_ERR "Failed to map cascade interrupt\n");
> +		of_node_put(cascade_node);
>  		return;
>  	}
>  
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index 7a961f2a228f..a82855752e58 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -272,6 +272,7 @@ static __init void pas_init_IRQ(void)
>  	opprop = of_get_property(root, "platform-open-pic", &opplen);
>  	if (!opprop) {
>  		pr_err("No platform-open-pic property.\n");
> +		of_node_put(mpic_node);
>  		of_node_put(root);
>  		return;
>  	}
> diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
> index d71359b5331c..8bc56a70b4c8 100644
> --- a/arch/powerpc/platforms/powermac/pci.c
> +++ b/arch/powerpc/platforms/powermac/pci.c
> @@ -938,6 +938,7 @@ void __init pmac_pci_init(void)
>  	/* pmac_check_ht_link(); */
>  
>  #else /* CONFIG_PPC64 */
> +	of_node_put(ht);

After this reference to ht, I think we can drop __maybe_unused during ht
declaration. I guess it must be added since on PPC32 it won't get
used and so compiler could complain for an unused variable.


-ritesh

