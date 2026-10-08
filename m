Return-Path: <linuxppc-dev+bounces-29059-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAC8CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 13:58:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0s6B5NZ2z2xwM;
	Fri, 09 Oct 2026 00:58:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791467922;
	cv=none; b=M6iPgZFS0vOns71GCTwomUBJkGnBLZSzSF7aUyxHXK4jZsogYMNIYxSa/pjXrfth4pV1FqX39dqXCpqntlmXhEB1/NhIUwtphK3qOHwylvIvUXoFMNmUUL028VY+URp9wOc/VF1tikmw+TEWGHX+Ou0K67ewWUkOGLYmEtg6+dmRI4Bi/uG9aMjbgdHxSUfSrf+xDJ725X0GIJzS0C9PjRkcIR5N7KBzGeMC4P4zT9RP79fTHTIpBlItSZZFuuQU/Xwk41YZqttpg3PAjbFs/5qWdcTS8WEDIGTN5V7boHCRg0zIlwm/E2sv3dqJHbN2vaEStaBLJkUyN1ba+vMrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791467922; c=relaxed/relaxed;
	bh=6vZ8Ejj8aZrBU856Cgb+Aq9cC3Vyu+mZba06VVhY2u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2S7geTow2K7LL6+1bLJ7uLETjiG+p3PKHslGDuta08ql4CS3ILZXR+YjesIE/9A5RiZXwRqwYsflkTgnZ7bfdC40m8S2wwoQKUrkKah+pUcdc9BE+jc7HGZyJvR/p0Wb9nqbemI1DkrA/CHgJEjfrgJjTyBSQRgWc/ALYZtXfvkh1ygzrpigCrDPfIF5fi82eIfIgFYNOmBV6WMkHMBbdgxchlHe8mW+dJ+8fzi14t/qkNRrXucbKmQRLDQPsCQUmODQsyKZIswcKTtsa3jnobrsOumQfQDfl1IM2YCPdmwzznPNdYac8o+tTOk50UeLU40HX9tp3hcDiG2NkwA/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=N2MldErZ; dkim-atps=neutral; spf=pass (client-ip=13.77.154.182; helo=linux.microsoft.com; envelope-from=jeffbarnes@linux.microsoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=N2MldErZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182; helo=linux.microsoft.com; envelope-from=jeffbarnes@linux.microsoft.com; receiver=lists.ozlabs.org)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0s696MQQz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 00:58:41 +1100 (AEDT)
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.167.115.14])
	by linux.microsoft.com (Postfix) with ESMTPSA id E381620B7166;
	Thu,  8 Oct 2026 06:57:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E381620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791467832;
	bh=6vZ8Ejj8aZrBU856Cgb+Aq9cC3Vyu+mZba06VVhY2u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2MldErZ7BuYtSeyaXTL/+JFoAjR43/8BqyXcXYCQCRU7mBNoqNY7iCRa66+DhoJX
	 rFz+UuSy554Glphg6bl8DrPa++tx9SgytfynLo4JgRkwm+R9oDAJDTHXXPDjmikCuz
	 cuG6NT1cQr9USDmP+24a9RJLxq2CC5ohAg4F2O/I=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-pci@vger.kernel.org
Cc: Frank.Li@nxp.com,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	roy.zang@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Revert "PCI: layerscape: Change default error response behavior"
Date: Thu,  8 Oct 2026 09:57:47 -0400
Message-ID: <20261008135747.76755-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
References: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
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
Content-Transfer-Encoding: 8bit

Hi,

Gentle ping on this fix. Please let me know if any additional changes
or testing are needed.

Thanks,
Jeff

