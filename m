Return-Path: <SRS0=5Snk=AV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC5DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2020 05:32:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D1C20720
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2020 05:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MECJoRc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D1C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B31s82K89zDrJY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2020 15:32:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f;
 helo=mail-wr1-x42f.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=MECJoRc/; dkim-atps=neutral
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B31g54SdtzDrG2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2020 15:24:01 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id r12so4522316wrj.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2020 22:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Eh22AL+ZrBA8xyIy9itm/0/DNb4G9ZozryqPyphXIIU=;
 b=MECJoRc/zW5hU3Oo7fI5cuJt3LnCqtPTZwAtiUJ1z6X8ud04HGzgWLSs7Cgqu4+Txb
 KZp+cHruCBin1woUvfGMBLyX0T5+eg7r9V0ioFUcDeTBZORx7TP0VYcQmfYAKQ1CfAPz
 3V6AJmM0QUEYrWxUCHd3as+5COD9wTYJH3Z1/WWDhlyMsYWXkybYRKx08NcGr+bf2YDk
 F0hXUb9hl1lQDPuc4CDwNLdzKjliS1F+pRCu1nlV7D/urOsvfoM1CwfrwCl0m03y7rkq
 Xejxq5kXlXAuB8jQ8SVveUwBcSu7Y3VdJyJHom3rqf4iRP9066T+Rzh6scJmmusDf/Xc
 pyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Eh22AL+ZrBA8xyIy9itm/0/DNb4G9ZozryqPyphXIIU=;
 b=IsQtKRBpTfYCOyzKzWmfUD6njcKN/KqYinyPOrEIqiI/7jFYTFRNBB6GSEhRRojT0u
 gg7gqNIyw7osKOlGily19JhCTSHuZGQj8gkm/7OI+YLrhA3lJra06d1gLq6HTc8qQD3X
 40ycFDA5rUynfZNxP8LHIu/TpNwuFN53CkUKQtT9O+DKVjr6AD8aGMJnDd7DA+cYOA0V
 An9YgL2pOl6DWSewEdKQVqH73SYDXifVSKFqshu3i8NrmJ23PNxkBB9dKb5irIo/9f27
 Z7n2Rz7LOXStTHlpL4LeC2GwADtvBNwr7Z3MC6EePlAC806H/FK5h+jeQqgKnaP03Cyn
 5PuQ==
X-Gm-Message-State: AOAM531cudsHGTLgoR0saW/cnKFlBp9aWw/SJqdYkLhwBCeqIxAg1Ygk
 eYTBNPQLTbATwGEvTNXxZA/GOlUQkiQ=
X-Google-Smtp-Source: ABdhPJwcOC01HvD10MtIKwnTj/+bP6lIe8QwBIeTI2eSJ2SFsOiSZEv87AF61D53nc/u3UiN6PVyug==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr71935886wrm.271.1594358634150; 
 Thu, 09 Jul 2020 22:23:54 -0700 (PDT)
Received: from 192-168-1-18.tpgi.com.au ([220.240.245.68])
 by smtp.gmail.com with ESMTPSA id 92sm9090941wrr.96.2020.07.09.22.23.52
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 22:23:53 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: PowerNV PCI & SR-IOV cleanups
Date: Fri, 10 Jul 2020 15:23:25 +1000
Message-Id: <20200710052340.737567-1-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Finally bit the bullet and learned how all the MMIO->PE mapping setup
actually works. As a side effect I found a bunch of oddities in how
PowerNV SR-IOV support is implemented. This series mostly sorts that
out with a few more generic cleanups along the way.

This is largely prep work for supporting VFs in the 32bit MMIO window.
This is an unfortunate necessity due to how the Linux BAR allocator
handles BARs marked as non-prefetchable. The distinction
between prefetch and non-prefetchable BARs was made largely irrelevant
with the introduction of PCIe, but the BAR allocator is overly
conservative. It will always place non-pref bars in the prefetchable
window, which is 32bit only. This results in us being unable to use VFs
from NVMe drives and a few different RAID cards.

This series is based on top of these two:

https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=187630
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=187688

Rebases cleanly on top of the first, but I haven't tested that one plus
this extensively.

Oliver


