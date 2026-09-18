Return-Path: <linuxppc-dev+bounces-27750-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D84CC982D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 18:16:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmgmH3nkvz2xft;
	Sat, 19 Sep 2026 04:15:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789755359;
	cv=none; b=BKSWOvTNJwxtUxiw5LgD1NtvwpWnfbWz2ITDUf6eRtP+bKv41ewr8J/uV208H3f4+aiKfXnZVpVNU0QXklthQbgu21+v6qqkdBtTf0LS9NDpBxgdPdTIg0058snpdPedVa3CwzFBkT6kiBeAbD6ZAUKDzAJpeF0XXnmOpHUcsG74eIWJ3+IYmfoLlMb29HTHtrrwKIVEggZ5VrEf0sGb1058tO+1MqvE3NoTaWPZeV4WwTRUlxOeiPZKKNDjLx/TssgvNxOgvSSPS6Dm3jGCYGII3gnhgS+aa8w1yzTuY8NVwkIYKUqRZp6yiHdYEvqui36HQluy7I6GyJD5Y+bh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789755359; c=relaxed/relaxed;
	bh=OW/egmM7mt/va5mQ7VY7PztEIbg4lcAaL2bbHrTbTPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iE6/5K8CHsufdW31QK6nenB/4oc4Ke5LFv86zhmEbhNc0d18qrvYQCmiSQX6wASX9z7qlKCi9wCauRFwg0hkjg7ixuCnSidFd1wgoAsRK1pipGvZr2NR3hCcflYW7iRj1XITgkfOKVL7hEjy7BrHHR64hys+PlMqYntyEVf33FNJGOpOGwLWrmKcfZ3+Xa/wOzuQ8Rf/scRweQE4TsicchjxrHDsPdvQo7aV5ORCKFlet4D4E4RHTx4YZuswNBoQgIZGvjBkY4VjJVyGJbx/a5KlwSqLxPeueK+VmggYGJsR//zDLX+At1Ne1sEXqw0jHZMlX5hxGS+U4DxdaiSLqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PYboRvbT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=323-tag0kdowfohvcrdfwmobyuccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PYboRvbT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=323-tag0kdowfohvcrdfwmobyuccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com [IPv6:2607:f8b0:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmgmG2nfHz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 04:15:57 +1000 (AEST)
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-cc52c1b829fso1283271a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789755355; x=1790360155; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OW/egmM7mt/va5mQ7VY7PztEIbg4lcAaL2bbHrTbTPE=;
        b=PYboRvbTTGDXpGis+8GsnHVCO/9YIpvm3lTqiGi7irf2yDLXOMpXCHhUGUa30wWNWp
         88Nfc1lG312ETD0PCo1HkHhGypJ+kbsGY4SM8e4ErQKBF61+5B2MhQa6LmrnXQaQqEW6
         bcApR690nWltGKy51cGryRyU8zGciZFcbkqF+6NMhjw+dnp/48PvBHEdwHJMOJEO9T2D
         RuxXc3rpQe3RrI54X/lg2jUzcR5u47vrLe+549VI0oIIAJIrbwD9nQ0XB5yYsEO5kXUX
         IRkLTUvzj2AjT/GtxjH67SMU/q878ahxPF9C5wMN9RQ6kAsoeX2PzidVCzCd3MzZndas
         /IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755355; x=1790360155;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OW/egmM7mt/va5mQ7VY7PztEIbg4lcAaL2bbHrTbTPE=;
        b=YGyu/U06Jdh+PLoUHVGVd/M/Eql51bz/PyKlmfo1WTmULJ2GtMS0CAcftbZs9FB6Pl
         X3uz65w6IWqywVtotOPzrBFchBSNv+F5NFQEa+40i7iz0ZQ1tXVSGxi9QLcLGlFgLJ7n
         a+FQs59gGl49BuAGryvJqJKudjWmfRqzKOtYSP9iPAFO8+HdCbsDXC8Bz47R98nZrhE1
         SSiQ7+T0oRZv7w8GpbINF0p1dTQQvlXKetVHh2LwBCIruGU0K62+fSkRWby21XxKbhG8
         OuwE3E7n5l/gHu0czghgXsSdW5xxUaHCCv8BGv0nobZ/gKh0bfdyZbwC9DM3Vo4MlxMg
         JPvA==
X-Forwarded-Encrypted: i=1; AKwUvBxiyZlt39N9m4/fil5v/YkdcRJeRm0ccBFdACK3IEuz/w+p/PDYjvYPiAQVFRXkbHH3/ZFTyekCzUnp8sw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lXIL5K5onKU0v8wk+ZCzrSyGxAKnwgh/xc3l/skXMy8Ht09QxA
	zNkRZIOMt1prNkyM7ZDZ4i6t2TtLx1g3ou1zoDMGBV8na7Ey5XsuQNIMCSgl+UjJmPDjB6LeXXH
	L1cWmhJSaQBe6WJgO4nZrz9IpU6BubZ4zdA==
X-Received: from pjbiw4.prod.google.com ([2002:a17:90b:4204:b0:39d:a2e8:6890])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d40e:b0:39e:6c6a:656f with SMTP id 98e67ed59e1d1-39e6c6a6787mr605040a91.50.1789755355148;
 Fri, 18 Sep 2026 11:15:55 -0700 (PDT)
Date: Fri, 18 Sep 2026 18:15:54 +0000
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
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
Mime-Version: 1.0
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918181554.132414-1-rathodpriyank@google.com>
Subject: Re: [PATCH v4 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="UTF-8"

[+cc Kuppuswamy, Jonathan, Ilpo, Dave - you have reviewed most of the
 recent aer.c changes, so adding you here]

Hi all,

Adding the reviewers who have been active in drivers/pci/pcie/aer.c, as
this series has not had review feedback since v1 (3 Aug).

Short summary: ghes_handle_aer() hands a ghes_estatus_pool allocation to
aer_recover_queue(), which returns void, so ownership sits with the AER
code. Two paths drop it without freeing - kfifo overflow in
aer_recover_queue(), and a dequeued record with no matching pci_dev in
aer_recover_work_func(). Under a sustained error storm this drains the
pool, which then breaks GHES hardware error reporting system-wide.

v4 adds the Fixes: e2abc47a5a1a tag and Cc: stable that earlier
revisions were missing, and is rebased onto v7.3-rc3+ (applies cleanly
to pci/next as well).

Review feedback very welcome - happy to respin in whatever shape you
prefer. One open design question I would specifically like an opinion
on: patch 1 frees the buffer inside aer_recover_queue(), which bakes the
ghes_estatus_pool ownership assumption into an exported symbol. The
alternative is to make aer_recover_queue() return int and let
ghes_handle_aer() free its own allocation. I went with the former
because aer_recover_work_func() already frees unconditionally to the
pool, but I am happy to switch if you consider the exported-API
contract cleaner.

Thanks,
Priyank

