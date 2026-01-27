Return-Path: <linuxppc-dev+bounces-16307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC794D2D8E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jan 2026 10:10:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0h4f2vQpz2xjP;
	Tue, 27 Jan 2026 21:10:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.176.79.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769508658;
	cv=none; b=RTsEI8EJt3DvLcUXFo1hGvK6zYq/Rxra4jbIKQJFDPcZmMc8LDBk2pPJ9OIkD8knDXv2XI7mDpdoXHKSlcfc715q5IlXwrb51mCoeky3INqaUk40Bdr0uckTQiqnNOKS/5DWaO8KvpEix5PyJ+KQ4Jm3pd0aF2JgOKALsGqO1ISuK0Y9Hk8UOWahHs7pHLHd9HLvM8gzq1nyXwBY/0PDcPS4qX+D7Z1uhK1dqMYU+OeFT+2uVqr7bJU2Md8vVtqh6vdB1nzL1j1qZl7Futzh3hoYEKbl9/fScWRoF0pACEURaYhFBz1chTXudA0s79/l76j1Nl0QD5He8d8KD4ED3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769508658; c=relaxed/relaxed;
	bh=GebPFzdH5/TcOmRhG7eem2w9uuXkfKKUu1sG5WDhDU4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVlqBzIabSdSo2/7nTMtfzBwXfgk4ux+RSwR2SkWe54t59X3bQ2lGGGRpI0tCQp/EzTXdHFbV/V9U/AietLxnzM5o5zbvw6WM2Kklwpo0VRJE3cFVSH7vEOQ6mxK+yg0dMT1beKoO8ulJ8l2osVqyVP4TO+7ZxWKKcZPGu2H4dPTAhqQNd/84KY67A7N9NM8kh453WPGaCT6EMNKGUybYMAdgW4Q/HGpNmEs3iNsqMTu5Ybr2KrekXskqYvlFHG4ixH8KlmDVg6Cp1BPbCWJqafzOTFNGQ+i3zVt6hxvl3R3hyAKWuMRkadVaj/cstTCf9+5RdFox08HhUcgmOE/hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=lists.ozlabs.org)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0h4d3qC3z2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2026 21:10:57 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0h3q5wXLzJ46jd;
	Tue, 27 Jan 2026 18:10:15 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D28740585;
	Tue, 27 Jan 2026 18:10:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 10:10:50 +0000
Date: Tue, 27 Jan 2026 10:10:49 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <bhelgaas@google.com>, <kbusch@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <terry.bowman@amd.com>, <tianruidong@linux.alibaba.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v7 1/5] PCI/DPC: Clarify naming for error port in DPC
 Handling
Message-ID: <20260127101049.0000640d@huawei.com>
In-Reply-To: <20260124074557.73961-2-xueshuai@linux.alibaba.com>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
	<20260124074557.73961-2-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat, 24 Jan 2026 15:45:53 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> dpc_handler() is registered for error port which recevie DPC interrupt
> and acpi_dpc_port_get() locate the port that experienced the containment
> event.
> 
> Rename edev and pdev to err_port for clear so that later patch will
> avoid misused err_port in pcie_do_recovery().
> 
> No functional changes intended.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Seems like a good readability improvement to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


