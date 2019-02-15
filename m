Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438B4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:04:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C4B21934
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6JX4v60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C4B21934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440w5N6b8MzDqbt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 12:04:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6JX4v60"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440vl92YydzDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:48:37 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id i130so3957628pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lJkkalXG+sJ8Jqo8PwEC43RUL3xtY7qMCP6M5UNqVMo=;
 b=N6JX4v60G7sNsK7tQxUWOjCCHzMt0Sz68HEQcbrcEu476qydInrkIgARzUk1K/tRH2
 db4lKixslY09bueO++cgz68IoPOe3jg/zo7g0skQZKXmqYXSFu1Z3jVkPqD0JgnLVmE9
 xR/8moYMj4AFyZvpge0w1TYcuKrbVu5nML/FrkLialAJB1WZ7Y1HcPcWY6IJ8TBB3DBy
 nLkJdkUreDaqdchsj1cvaWXe8YxeIsWUVnoMPXw2ltV1VUkRtCwJUk0YPY14nY4nt5gl
 48ZbE/hPvbkIdbPfruNQH0ttsI8d9b29/nzUgLM06vS9aRBy9cMZJFG9D0mpAcAb85Lw
 2rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lJkkalXG+sJ8Jqo8PwEC43RUL3xtY7qMCP6M5UNqVMo=;
 b=czuKgQavat+f2SYQnZPxwPELziFO754T/k7dhwd6XFpHaLhLVCBx3O5RTdAUX/qad2
 NXRvu9AmNJnHKnMv2wY3vZpZ7qIH1WDCreOf51UCt8Smr/EVdIZkqYho6VkW1WyhAmly
 GFse9pP1Z6aML9tcr/PBLAYogVI2smuO0cp73uZFT9w5vDDzCYZJAe3COJ6M6ZTsd649
 z9l9jGtLm3uCzHDF89LuHR0rD1vz76Y+ca3uDso3L7zAbgjUYmyQcNLZYyZAXJh02FZN
 3vxrK5LPB1yka5ZWsAprzZhIrRv3H/aSa5YOn9vMs6wLwdAS8qI7EmFXltTqnogFCGfU
 xZiw==
X-Gm-Message-State: AHQUAuYHUFI4o+vx9A6u1NS+NZN3vmvNemzsVr5A3HaL1qrsxxITdWEX
 fQspXYsWd2aXQrkDp7Ekht38IeXo
X-Google-Smtp-Source: AHgI3IYJFUWajsZO/AsFH7GSxm1QI4hhKAL+fMmAVgW0YrK4VJsXuIGDAoS4aTUfK64EwkAmh+ykCw==
X-Received: by 2002:a63:580f:: with SMTP id m15mr2680998pgb.342.1550191715443; 
 Thu, 14 Feb 2019 16:48:35 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v26sm4993751pfg.62.2019.02.14.16.48.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:48:34 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/7] powerpc/eeh_cache: Bump log level of
 eeh_addr_cache_print()
Date: Fri, 15 Feb 2019 11:48:14 +1100
Message-Id: <20190215004817.19961-4-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215004817.19961-1-oohall@gmail.com>
References: <20190215004817.19961-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: sbobroff@linux.ibm.com, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

To use this function at all #define DEBUG needs to be set in eeh_cache.c.
Considering that printing at pr_debug is probably not all that useful since
it adds the additional hurdle of requiring you to enable the debug print if
dynamic_debug is in use so this patch bumps it to pr_info.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/eeh_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 5c5697cced41..9c68f0837385 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -114,7 +114,7 @@ static void eeh_addr_cache_print(struct pci_io_addr_cache *cache)
 	while (n) {
 		struct pci_io_addr_range *piar;
 		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
-		pr_debug("PCI: %s addr range %d [%pap-%pap]: %s\n",
+		pr_info("PCI: %s addr range %d [%pap-%pap]: %s\n",
 		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
 		       &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
 		cnt++;
-- 
2.20.1

