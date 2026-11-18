Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE0606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJkskdVo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV5zq6hF4z2xSl;
	Thu, 19 Nov 2026 03:05:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795017943;
	cv=none; b=HjboS3153KIbuC7yxy6Ugux8r9BUviBkkzqkPejPHh3vbghCoxMQ8/czqItBPqqOaasrbvsRLha/8T60lIu95GJNIKl9tktdcOEQoF/VR1p6U45PLmRlCHMhDO5j5qRYHOgFVBqLBcgI7NDiqZJMb4qgXvBNs2DOonkv53UV2l0dHMVADF3PT1PUjKJq+tLBmF1kp5DqdigTmyncwayiliKLgpnVrclzjfUlSLl6ORmijE0FTywAdoNZru5Sz6jybEWes1YIMvxi8mzsMoxXBQ0x/z/K9Kh29mi2y0xGw0fDkYYyuVVbmRe3hWpuFCuardcjpiTD4WscUofw1BxfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795017943; c=relaxed/relaxed;
	bh=Ae+3JeYiUrhjbpo8o0eXBbuZavQb3IPFMYoUFzPB4Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6msGhQGKkfy8EbFwayw6Kr0UK+6l36ILxolwZ9nbmB0s+Ryt+3RPGsUCSSfN3Hq4cU3LeTy5YiMqP2ygGCdMuEmNXWWdUiT0J+/jazJc3t8pfjVxZq0lJRujHhKyOFL8nokwI8P/PTHY327GJZIjtrl/yeRtD63XKm0Q5J5mw74FnAwG1WQQ+PJ7L0LEuoapuIUPqdVPA0yoOGWKqSduZGLRnyonwGIo2/uVLDJrnVcaQCpy/TZuvmMeZ3hucUh6sDoMlwrM24c4uUq7W4kgn0uIAl8m8GuHmxkV+44sxkZHlkyb/kdf1d42gd1RdU9eoC49jsgUZ9OlASSHJJOmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJkskdVo; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJkskdVo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV5zp4SSgz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 03:05:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795017943; x=1826553943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=81nQPe6DhZPapz5KdmrVwUtkk4R09Ot6YOuL6uNj16M=;
  b=eJkskdVoKC93AwwGU4lra4gQdeNLZUcfNCZOac1GODFrp4zSLX9aA6BM
   da/ZBGZeMKmuHsz+5dLeW/C2p+Xld7DWhwre/e9316HX4uMkaxyOUFen3
   c8BDJSyxsaohRkTzA+lWQI0nwemyOAYstKjVgoE1uY90vFDS/bUgBZoac
   ijwzWLhF3e9crRQO1HKtY4fY8H2ZLF8B3X8/wFEF2puw1am+zJvwWzdDB
   2nmAUs+A3NyoKowTo8/zrP5S+JZ0bu/Bi5BKvgTOIrDVNZ5TVe4gZVuLl
   Uh9pVH4uIV+6hUobSceo151yyucblgZoWy2V8yK6URyNJEbKbfCl7nW/u
   g==;
X-CSE-ConnectionGUID: +5ZyzLkNTte2XDSc7sPSow==
X-CSE-MsgGUID: pqy7pVjuQNuwDsdRgx3Vlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3847341"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3847341"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:05:36 -0800
X-CSE-ConnectionGUID: AVZ4HHyQTCWUBgdhxj6XZg==
X-CSE-MsgGUID: JKvDnjUSS8mEjic3oB+mZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="12116519"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:05:36 -0800
Message-ID: <5eb12731-208b-4be0-84d7-9131810b7842@linux.intel.com>
Date: Wed, 18 Nov 2026 08:05:35 -0800
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Darshit Shah <darnshah@amazon.de>,
 Jason Perlow <jperlow@gmail.com>, Riana Tauro <riana.tauro@intel.com>,
 Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>
References: <cover.1794997749.git.lukas@wunner.de>
 <2d0191cb7b92da82302f9d37b859e28ee6c9c85e.1794997749.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <2d0191cb7b92da82302f9d37b859e28ee6c9c85e.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/26 02:40, Lukas Wunner wrote:
> From: Yury Murashka <yurypm@arista.com>
> 
> pcie_do_recovery() only clears the error status bits of an error-reporting
> device if recovery succeeds, but not if it fails.  (E.g. because reset
> failed, drivers are missing pci_error_handlers or those handlers failed.)
> 
> One undesirable consequence is that the AER driver may subsequently
> identify a wrong device when searching for error-reporting devices in
> is_error_source(), due to stale bits on an unaffected device.
> 
> Avoid by clearing error status bits on recovery failure.
> 
> If recovery succeeds, Fatal Errors are generally cleared by a call to
> pci_restore_state() from drivers' ->slot_reset() callbacks.  If recovery
> fails, those callbacks may not have been invoked or they may not be
> implemented.  Hence clear Fatal Errors as well on recovery failure.
> 
> Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com/
> Signed-off-by: Yury Murashka <yurypm@arista.com>
> [lukas: drop cmdline param, rewrite commit msg, clear fatal errors]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Changes v1 -> v2:
>   * Clear Fatal Errors as well on recovery failure (Sathya, sashiko).
>  
>  drivers/pci/pcie/err.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 24a8a8263c2e..a450146fb285 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -289,6 +289,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	return status;
>  
>  failed:
> +	if (host->native_aer) {
> +		pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
> +					   PCI_EXP_DEVSTA_UNC_MASK);
> +		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_clear_fatal_status(dev);
> +	}
> +
>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
>  
>  	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


