Return-Path: <linuxppc-dev+bounces-28977-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED04CA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 21:45:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzqZC20czz2yjN;
	Wed, 07 Oct 2026 08:45:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1235" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791312153;
	cv=pass; b=WQaH5a5bONDoh4to07blFG7myPrU3yF4jKsbkSNkeXlBWesi0iJ1oWaSC3RKmnOxQ/v/lnhw7842YbJouhGlMVCJMBrX1j7smjHbhu6AwrqU2Pc7cjmr2ReVXJnSGccTaRE43t6+rsI8VCKJrmG3Y32GH5jbEIxFm7qZeOxys/TD3wHMFK+SaWnW0pThjc4zVU+FP00LG4d8vtQuazxn6GXuHkOq0wv2QBnmkbi9LDBgtTeNfr24Dto/AwZUu1JjognC1S73oed2E8J7eJ1CYht/QgkqhIi5ywEygGjh1pjnsD0g0+5ZuJD7d6VRBQS7IPqOE1DwKVZBFk/4FhA7YA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791312153; c=relaxed/relaxed;
	bh=lqvNoiYS5Y69wvqY92SOyBc105nfusymGn5er7L23A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/WZ3pgvs6edY7NW2kgbWeNIzzMDADrrM1cSiSj2ZzfplhR9de08eEjpWbgiw8UIYdR6LanvmiypMYW0Ag38cVtqwyjuD3ixJoGX/Dzce7M4lNAC/Y91QQcBJlnUBpuKPqOssT5lmj7I76D4x/59fuz2TRe1tdsUDMmlaL1ANt2QXSHa88T4utE/CRnISkQZUcYeEk7Q/O0BnGtNdktxQZrOevDKXxgCmoTH/UePXXKU+6WcuPALC7LBBxrPHq8BmrV783/0u5Uy64ZHKJeT2Au8YfqnjYNmYkuWkFyh/g0fascQy2y5fV9l8OWNKGOhB/Ved85Fqg5PZUsTIBcpZg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kx6adJz2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kx6adJz2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=jrhilke@google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzlVc3QtVz30St
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 05:42:32 +1100 (AEDT)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-143941c2aebso1231c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 11:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312150; cv=none;
        d=google.com; s=arc-20260327;
        b=qpwonMgpPgMj0eiem99CC8axhTNU/dngyiiUlPSn1+FTDk4mZeUn8HC+c43oSM1vhY
         f5IgJjcP+Xn7aX7UsGz6Q6dlmoDHjm9DxVR4BnoM89jYkiYtdnRR9iSGVRZPob/cq3U2
         6RSyQW0kqujWAdOCBPlsu+PcLfrmhYQp5huNxoNUC6zelUfbR+ArAX04xlkK67oce/VP
         i8xGhj07EmZAz5h9j/zxTeQim/fwgebK6BGkH01gfJ7sRJgCXf6HQy/zS+N/scAuLUFG
         94sBeeEEjXANj7CB7zhM988CU22kXM67qKMUM1UFJ+Faybp7QdnW2wjU4PbnQ/EtYPbg
         yE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lqvNoiYS5Y69wvqY92SOyBc105nfusymGn5er7L23A4=;
        fh=7sbLzi7ZL2RsmcIJBbuxP25D5p/s0yaIPfjsKlczDf8=;
        b=COd8Lvvv+tRqXKVLq5LF0sBgoDrI2UrUZS9g4Ti2Qovn//i1Mhjlx1VqZtHtn/f4bJ
         e9ErdLBSBCngfeHe8ZLksc0G4zEBsWPV7QSLKKMzljzd52qask83gI3FWcq+igMfwcRW
         nOVcrnTMHkDPBYfGvp/HV/kyPmU2ZLwr9YkZZJ9eXSFnZ8QEDPmznKy7H2xEFVkEnaa8
         B9p5MzZeYKGb4ObY7BbMOlqE2SS8E8tXSo8WEiJKd6mFG84YLvLn6ZLBraOXnBPWVl62
         gik0KxTV1eQ/0N83f4Ecd3pfudu5xuYsiMNNS7CB1PLQAE6mW+Rj8a2Hpihfb26Jwesl
         VSpQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312150; x=1791916950; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqvNoiYS5Y69wvqY92SOyBc105nfusymGn5er7L23A4=;
        b=kx6adJz2tiX+f50M44Sm1OW9g+y7vLx9FFJtsl3Lxv1U7qmDBdQwrMtaXTknwMIJhB
         sZD7R/9q9u5IqzYy28zjCO5cLQsT8x8xiMkPq9p/568SrbhZMtWwNc9SDf+L6B09gKq7
         pbPl3obDthm86sogyYtySufVhHoBdTusl97lzlq40XZYslBTRD3XCvAUv0N3MQp8hgaJ
         Ge2EskIhdf7Ha12aHThYALZgO3wh/locU360OCBlvRxmpKsS/88hYdrUG7YX+J3LCphI
         4LMm1ZojDNTl0rJxnjPTcRRqIZGn0vI+zr0CRq/EKoA/DFyrY0/vX2wSNDxWaPvl54qc
         PI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312150; x=1791916950;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lqvNoiYS5Y69wvqY92SOyBc105nfusymGn5er7L23A4=;
        b=EgR2UeseAPOaYKKtgh9kkROpzzeVkvm89/JBJyRqt7Kl5MjE7es62yxflkw3kvxFsS
         9BEaREIqT8J9WHaKKcknOP1geXhUWPzSSN0ZWf5JgeWXJxz858LdOeyDeQ5s1yEmMXIX
         e1zIyTv53qQWyNbdgqp8pjaLXHIXO6X1+uG/BFYyWUrkpnCR/Czt4uo7PiDywX/DTSe/
         WEm3BSDER3a60Ciu6Q7JUqRbwM3BhKxFIkwZ6AOj62vO5t/z+EwUSpCU4lCw+0xf7LTz
         gecSbEqPnhYpFwZ+Smsx1Xqg0+SyX+8WuOc3/L5d/xs0k6qKYd2lYHAxs1RxMccQz141
         dG+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxIjbHy4cNSyv2Z/bLm8sCaMmvuGoeJXF1M2b32Z7oVcwqYuu3Gi3+ZvdrU28IPNet1WhXVJaNNw3AgJuI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n27k7YsdWaI+oCMxfWzQVzkKghedbQjq2QJSOd3QdytGjeB308
	/cInQK2mftcZ9G6GOsZ7Wsuy4/tHBr58rvcp/oV/ipryxjwOUd+UTt1N8lx4pp0CBUW4Sbr279F
	NVXLIn5xaptXE6QvE65qEif/vDt6cM0USat3WPnM=
X-Gm-Gg: AYBFou2oaY50T99BUohqZxBXUN8I70qWBduMdrKVjpEAYDB36XfM5O6UdduQ58hzywI
	k6CDCH1oIrqdO/X7F2GU0JPsltPNpl/PTGWMKnKeMPBIreTkOk4oWzIAi9Ne115lrBRQstufms0
	y3FS5jcGJPm90GeXpC4HwTqZd+TBTzEyyo+r3lYKhil76FhIrCbX9QpLdhJ9EencHYMpr5Ht/Py
	yfXZNgjMFDLJvncGg4y4CihGAJuY3Bi5ZhSFUW1kxTb0oERA1A7yldOAmVzptGvTWII86ThX7jt
	g6CSqNJDwlzGbTAeZN9xL3Np8MSb+B1oNIyIbW3peVfeO9GEe45ignMcdsOapH8sDmcMjiMyon1
	XV+5vfsj0lRqxldqhBAggkv3awKM9/Jo/yHJv
X-Received: by 2002:a05:7022:ea86:b0:149:8916:defc with SMTP id
 a92af1059eb24-15d6b02a69amr459793c88.0.1791312149393; Tue, 06 Oct 2026
 11:42:29 -0700 (PDT)
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
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-15-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-15-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:42:17 -0700
X-Gm-Features: AclHuK8FvAbBzT1AuW5uRxJ-kZYYZwS_oOXm66BR8cKM-gGDFIVe-GGMjbHDU-s
Message-ID: <CAAdrzjsQ1v1LRCcikErDSy67=SNDiP5qvNTr8W=qjzXy_wUWag@mail.gmail.com>
Subject: Re: [PATCH 14/15] PCI: Save reserved capability registers in a single pass
To: David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 10:35 AM David Matlack <dmatlack@google.com> wrote:
>
> The PCIe capability is the one place where this is not a pure refactor.

Please add L1SS on Downstream Ports to this sentence because it isn't a pure
refactor either: before this patch, only the child wrote a Downstream
Port's L1SS slots, in pci_save_aspm_l1ss_state(). Now pci_save_caps()
also writes them whenever the port itself is saved.

- Josh Hilke

