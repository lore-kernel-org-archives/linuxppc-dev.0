Return-Path: <linuxppc-dev+bounces-28972-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3F9CA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 17:13:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzjWs4pTdz30St;
	Wed, 07 Oct 2026 04:13:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791306809;
	cv=none; b=D3yDDRMBUqsMPlhBoW40Skwr06GW/CbEaNEkrESrbmG3BB0TQJ1aAwGQKdbzIVHuXP8DZ9g3hLA5OhvBFA26bVd+SJ+7amfBJFOe8JMePIpWNceLUN1RHHLAA+PT6kx96K1RcHpwIxMbKjora48K0c3zBqOiaxY356qOnwIzdkyi0hBjLnqJc8HxptRrSsbsyOEKl49cW69P4UjofyO97M75HA2zwK+mzwb92ADInHREBOiQ8Ww7/6q1Vgla06wRc3JbXpCUl/B7E7bgc6ZEx6N7/MMU4FBOOLY3+Kby3lBF6xphZgpKgrV8hKdn02OhlgBuYceKpFFjDma3IHck1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791306809; c=relaxed/relaxed;
	bh=ByS3hT0nDIBDSSt77xeQRuOaYrar7ip6SzUCu2ZCV80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUrCHahl0ozaEK8UTfP3YQ2CzK1c3ZcNnGPWFBXuEH5olURUQr26SRTABwE+sDcj+Zd2eswof888GNrWuqGSfcwM/VFGa2lznxuQqDWlIUyeUowvZFlySMwtf6GyIRtzve/fCaCOd7dHLke7NEPuqLYFdVNqSzt102cWqJ70YQy1KS6EmMyRsXO1fLVZeqmn21b0bbqE0GYmZpzMAPBQLYytVEJY347+pVbf1qLP6Llr8sdVwUCVFDgaw1tSid1B9PUVUT8hhr0HfTlT2nkkU5ZAbnIT5GHyGvwGLtiNtJvfnrsJ3ymxAKtUpxmt7lVNVmrzCKRLyZ9IfFCwPLvxZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TxM0yQeg; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TxM0yQeg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzjWp2cJhz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 04:13:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791306806; x=1822842806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6hTp7abrUCBANrVeUZr7+9orxPXfXbaltmosY1LJSGE=;
  b=TxM0yQegx3JDOwfLypdz6eT9gsk5/ot1Eu3mtsv0gfEKpwz8bivUB5m/
   cr5cYYJmwRQblZwkAMhsSLGmDJq8fge8DPuVYyJ/vonExMuuL6Qn5HxYW
   akNheHkwNgmArVDkRkq/yHu1I8iDQPwuYrhLMLzg3NRfFLVr2J9ZhgGOH
   3R6/2HAO9FPwwcdHQiZuYTqnv2PhnrgBN7QI0iDBxjkDPtGjknI0/1zDl
   MIL1wcs6XRZ8wr7AxChT1ZPj2EvRcEWT3RHHOynlKy4iIVvtKbD6pd9PU
   aLzPuUb7yjLAsOUBYC/vYUuX9DOhFIGpRD9jMwRp6WGjkuZ5nRtt2ybN7
   g==;
X-CSE-ConnectionGUID: 9s2KgXteSX6upbElqk4HYg==
X-CSE-MsgGUID: 6MhLUm4hT4CgUN9C/bYOlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="117526838"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="117526838"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:13:21 -0700
X-CSE-ConnectionGUID: RISsF7C2Tba5ZlFsLqWc9g==
X-CSE-MsgGUID: 0BJZiU5xQMqTmvD1a68euw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="274994321"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:13:21 -0700
Message-ID: <eec2107f-2c08-44ad-98c8-2c92f7a31fd3@linux.intel.com>
Date: Tue, 6 Oct 2026 10:13:21 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI/AER: Document that aer_recover_queue() takes
 ownership of aer_regs
To: Priyank Rathod <rathodpriyank@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
 <20260928-b4-fix-aer-memleaks-v5-3-ba6b94c9c9a6@google.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-3-ba6b94c9c9a6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/2026 10:40 AM, Priyank Rathod wrote:
> ghes_handle_aer() allocates the AER register snapshot that it passes to
> aer_recover_queue() from ghes_estatus_pool.  aer_recover_queue() returns
> void, so the caller cannot tell whether the record was queued, and the
> AER code owns the buffer from then on and must free it on every path.
> 
> None of this is documented at the definition of this exported function.
> With GHES enabled, a new caller that passed a buffer from any other
> allocator would hit the BUG() in gen_pool_free_owner() when the AER code
> returns the buffer to ghes_estatus_pool, and a caller that freed the
> buffer itself would cause a double free.
> 
> Add a kernel-doc comment that describes the parameters and states that
> aer_recover_queue() takes ownership of @aer_regs, which must have been
> allocated from ghes_estatus_pool.
> 
> No functional change.
> 

Thanks, this matches what I had in mind. 

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Bjorn, I see you already applied the series to pci/aer. Feel free to
pick up the tag if it is still convenient.

> Suggested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Link: https://lore.kernel.org/r/4513e7d4-4e2f-42d8-8f0c-2f0e03815dee@linux.intel.com
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
> ---
>  drivers/pci/pcie/aer.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a6600801af6e..a58244e00bc4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1404,6 +1404,24 @@ static void aer_recover_work_func(struct work_struct *work)
>  static DEFINE_SPINLOCK(aer_recover_ring_lock);
>  static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
>  
> +/**
> + * aer_recover_queue - queue an AER error record reported by firmware
> + * @domain: PCI domain (segment) of the device that reported the error
> + * @bus: bus number of the device that reported the error
> + * @devfn: encoded device and function number, as returned by PCI_DEVFN()
> + * @severity: AER_CORRECTABLE, AER_NONFATAL or AER_FATAL
> + * @aer_regs: snapshot of the device's AER Capability registers
> + *
> + * Queue an error record received from firmware through APEI GHES.  The
> + * record is processed later from a workqueue, which logs the error and,
> + * for uncorrectable errors, attempts recovery of the device.
> + *
> + * Takes ownership of @aer_regs, which must have been allocated from
> + * ghes_estatus_pool with a size of sizeof(struct aer_capability_regs).
> + * The buffer is freed with ghes_estatus_pool_region_free() by the work
> + * item that processes the record, or immediately if the queue is full.
> + * The caller must not access or free @aer_regs after this call.
> + */
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs)
>  {
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


