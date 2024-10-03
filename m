Return-Path: <linuxppc-dev+bounces-1745-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7FDCF857A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Oct 2024 10:40:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XK7VB1bwTz2yS0;
	Thu,  3 Oct 2024 20:40:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4190:8020::34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727952002;
	cv=none; b=huUuB7fuHK3QF/95OxA8Hgg61aZn8y3Z620VvTNVL2h3SpInQ81GX4nFVRLvYlNrZYgXLAr309E10bhp12bMLg880DLmdAwZ/fvspTZ3HrZS9SlpSfMd6OzEIJJzYI+mB3/pO800W2Kh1nZATTwfdtRMmsF/aS615iHKkkiJq3zqfL9cAqwutPgcvbwGgHYgwL39q/gbCOZj0puJoYgK8/3r+g0Xu1rOD378tDoy/YwKbYl7tMtbd20JsumnzdqnrwNQirwepLiPpOd20F5Rei0WKR8TSNyFriL3LkaasDZ9N9Zma4yDFU8XdQbZwa+fqfG9IelmeU6hJIkihb6MmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727952002; c=relaxed/relaxed;
	bh=v18gt+keD9qSiyRK0MiRPI22GpCNnnbi6g2wSA7DD/0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V7leCqk8zFM3PoC4F1jp94DQg2u7VmfZFHJ6Sq9I+PRscRIzSQISFgshH7AaSrp7/Ocv9qqsnvT8e4lQ9ph9TqBtoE/8t56aJIRhxmQva2SkPPjvpj2zjmEYQiig7LfvCQ78w2f72neFa0fk/ZxSG/2c7RAvEh+VjaPsuyIMbRHf8/YJ5MNRO+So9A7h5Q71c5m/ENBmnFNcGI0zVnX8T61if2I+RVoqeaIyIztItO+pbU9w82tGInwUwQJ4hwsvTAeplsmCP6Poee8zVfoahFVxxRRWZmOLCsXXxlK90J43oeGmXe7DejYe2o4YSp+0pV6CoDp5Zf3v3sa0XDL8Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none (client-ip=2001:4190:8020::34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org) smtp.mailfrom=orcam.me.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=orcam.me.uk (client-ip=2001:4190:8020::34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XK7V83x0Rz2yQn
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2024 20:39:58 +1000 (AEST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3464A92009C; Thu,  3 Oct 2024 12:39:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 27C8E92009B;
	Thu,  3 Oct 2024 11:39:48 +0100 (BST)
Date: Thu, 3 Oct 2024 11:39:48 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Matthew W Carlis <mattc@purestorage.com>, alex.williamson@redhat.com, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "David S. Miller" <davem@davemloft.net>, david.abdurachmanov@gmail.com, 
    edumazet@google.com, kuba@kernel.org, leon@kernel.org, 
    linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lukas@wunner.de, 
    mahesh@linux.ibm.com, mika.westerberg@linux.intel.com, 
    netdev@vger.kernel.org, npiggin@gmail.com, oohall@gmail.com, 
    pabeni@redhat.com, pali@kernel.org, saeedm@nvidia.com, sr@denx.de, 
    Jim Wilson <wilson@tuliptree.org>
Subject: Re: PCI: Work around PCIe link training failures
In-Reply-To: <20241002205521.GA270435@bhelgaas>
Message-ID: <alpine.DEB.2.21.2410031135250.45128@angie.orcam.me.uk>
References: <20241002205521.GA270435@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Oct 2024, Bjorn Helgaas wrote:

> If there's anything missing that still needs to be added to v6.13-rc1,
> can somebody repost those?  I lost track of what's still outstanding.

 I have nothing outstanding to add right away.  Thank you for asking.

  Maciej

