Return-Path: <linuxppc-dev+bounces-19773-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342C2F41986
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:47:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwfWl5vhFz2yvL;
	Wed, 15 Apr 2026 21:47:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776237220;
	cv=none; b=U0GgW4tpvDbWBzmpSSFUqtaD7a/YcN2csCznF9UYz4H5+/SG+1OsKr2sSvOP61WStm0KTt5vBEgo55i3BF/n/FTXTiGskdcjST+RjP9FC+m/QKB3GpUZ/5SPv7bBmCw+kZqtFpX1qlFBuIoGZVfJM8MOtV6AiauMaLBLm/oGiFIr4Z7ztLilecMOjI/t+3BpF18Y5NoR2Nd8X54N1JMThO7NM1ScsWOVlfSC1ltnAIiEQ8nXkNlkBna/ERffGLVZvOjbudRkbG0+U9IJdb2UZWFdvdZD5nQlkkSWU+sEyCIMLincuUDk1hYXI0VaIyAygyyedZXlAokyJM0PAOIaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776237220; c=relaxed/relaxed;
	bh=jDTL+8sfEb7vDNVXNIhmyAI+hFhsia07/AFkCM6BNdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6DyftTznOqjw9kvrJJ25eHU2hY1jB5sY1uh7hBROIW1cd4+BdjLUqjZUhyDgOzyIFJtXSeXQKcXxvwdJqD56Sa6YFVzAo/ES78UHG2ypK06CUPxukFXANUqrRPMp4SH6THy4h1mEfH+Ru45OMe2FtirhWzL7tNWGyV8OupPcCqZ2ng8pz1cZjm96mabdCRZVg/VlV8RJqBNqmxJT2fy3WMtYtrT+wrAZxdRqMhkta+OHiMWCMWUaQJUBUbIG8bUupdGKg/2OG5yVgbxsLhy0f99Xuu6oaeJN/ETV7PSOKUsV7sn2ybc7v6eccUZNO+bMFQtwULC0KPkGGpLqO5u+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=fPcp3u5s; dkim-atps=neutral; spf=pass (client-ip=188.68.63.102; helo=relay.yourmailgateway.de; envelope-from=linux@leemhuis.info; receiver=lists.ozlabs.org) smtp.mailfrom=leemhuis.info
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=fPcp3u5s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=leemhuis.info (client-ip=188.68.63.102; helo=relay.yourmailgateway.de; envelope-from=linux@leemhuis.info; receiver=lists.ozlabs.org)
X-Greylist: delayed 452 seconds by postgrey-1.37 at boromir; Wed, 15 Apr 2026 17:13:36 AEST
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwXS05HHbz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 17:13:36 +1000 (AEST)
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fwXH94jv2z64WD;
	Wed, 15 Apr 2026 09:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776236757;
	bh=C5RXb3Sjd/HmzoErYe568YjOFdiqT6diMYrs4wtOWsE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fPcp3u5sljUrmjjFHVqupOHnqaWSbOvZvNImNfILmdPfrtBNJ0PplU5TcPnmJpabC
	 AtIwCe8zRfkhOmjxfcsO8Q+KfLGUZJn98WZD9NC8hV/4n1wshrGStnbGgasRaDGQRv
	 2xtGvrKZ2cFMhegwMZ2Tmr9brW4A5hjbtcOpZ9mDb1/Krf5EMtgmICxiY2ttfFkA4g
	 J4tUWOq/VlpH7jjhsUSe3DhwycrZVcWHAwo7FYSXxC6LDr1Qbt0LSQeJVcOzED+t81
	 ZtGoy856Au4I68H3IcZrYU8QvNOL8WtHbzsUw4fbAOo8JBCYX+NeJ3HPm+qblEDUeR
	 tSxVRA+bSjL4Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fwXH93z16z4xNs;
	Wed, 15 Apr 2026 09:05:57 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fwXH70m00z8sbB;
	Wed, 15 Apr 2026 09:05:55 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 507E5635DB;
	Wed, 15 Apr 2026 09:05:54 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6616a20a-93d7-48e2-976a-d5587088f2fb@leemhuis.info>
Date: Wed, 15 Apr 2026 09:05:52 +0200
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
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie:Support Product level reset.
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20260330063842.1121545-1-chandrashekar.devegowda@intel.com>
 <202603310744.5WIVh3e6-lkp@intel.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <202603310744.5WIVh3e6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177623675479.1883973.8741712713569291605@mxe9fb.netcup.net>
X-NC-CID: UJ6oDEpB8fD9jJz/zflE157Zb1heHwfPa/Sgew6FSERkwi5gJP4=

On 3/31/26 01:39, kernel test robot wrote:
> Hi Chandrashekar,
> 
> kernel test robot noticed the following build errors:

FWIW, a newer version of this patch hit -next yesterday and caused a
similar build error for me, but only on ppc64le (on Fedora, using the
rawhide config):

"""
> drivers/bluetooth/btintel_pcie.c: In function ‘btintel_pcie_acpi_reset_method’:
> drivers/bluetooth/btintel_pcie.c:2309:14: error: implicit declaration of function ‘acpi_has_method’; did you mean ‘acpi_has_watchdog’? [-Wimplicit-function-declaration]
>  2309 |         if (!acpi_has_method(handle, "_PRR")) {
>       |              ^~~~~~~~~~~~~~~
>       |              acpi_has_watchdog
> make[4]: *** [scripts/Makefile.build:289: drivers/bluetooth/btintel_pcie.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:548: drivers/bluetooth] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:548: drivers] Error 2
> make[1]: *** [/builddir/build/BUILD/kernel-7.1.0-build/kernel-next-20260414/linux-7.1.0-0.0.next.20260414.462.vanilla.fc45.ppc64le/Makefile:2147: .] Error 2
> make: *** [Makefile:256: __sub-make] Error 2
> + exit 1
""""

Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-ppc64le/10323070-next-next-all/builder-live.log.gz

Ciao, Thorsten


> [auto build test ERROR on bluetooth-next/master]
> [also build test ERROR on next-20260327]
> [cannot apply to bluetooth/master linus/master v7.0-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chandrashekar-Devegowda/Bluetooth-btintel_pcie-Support-Product-level-reset/20260330-190125
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> patch link:    https://lore.kernel.org/r/20260330063842.1121545-1-chandrashekar.devegowda%40intel.com
> patch subject: [PATCH v1] Bluetooth: btintel_pcie:Support Product level reset.
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260331/202603310744.5WIVh3e6-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603310744.5WIVh3e6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603310744.5WIVh3e6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/bluetooth/btintel_pcie.c: In function 'btintel_pcie_acpi_reset_method':
>>> drivers/bluetooth/btintel_pcie.c:2307:14: error: implicit declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-Wimplicit-function-declaration]
>     2307 |         if (!acpi_has_method(handle, "_PRR")) {
>          |              ^~~~~~~~~~~~~~~
>          |              acpi_has_watchdog
> 
> 
> vim +2307 drivers/bluetooth/btintel_pcie.c
> 
>   2280	
>   2281	static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
>   2282	{
>   2283		union acpi_object *obj, argv4;
>   2284		acpi_handle handle;
>   2285		int ret;
>   2286		struct pldr_mode {
>   2287			u16	cmd_type;
>   2288			u16	cmd_payload;
>   2289		} __packed;
>   2290	
>   2291		/* set 1 for _PRR mode
>   2292		 * Product Reset (PLDR Abort flow)
>   2293		 */
>   2294		static const struct pldr_mode mode = {
>   2295			.cmd_type = 1,
>   2296			.cmd_payload = BTINTEL_PCIE_DSM_PLDR_MODE_EN_PROD_RESET |
>   2297				       BTINTEL_PCIE_DSM_PLDR_MODE_EN_WIFI_FLR,
>   2298		};
>   2299		struct hci_dev *hdev = data->hdev;
>   2300	
>   2301		handle = ACPI_HANDLE(GET_HCIDEV_DEV(data->hdev));
>   2302		if (!handle) {
>   2303			bt_dev_dbg(data->hdev, "No support for bluetooth device in ACPI firmware");
>   2304			return -EACCES;
>   2305		}
>   2306	
>> 2307		if (!acpi_has_method(handle, "_PRR")) {
>   2308			bt_dev_dbg(data->hdev, "No support for _PRR ACPI method, falling back to FLR");
>   2309			btintel_pcie_reset(data->hdev);
>   2310			return -ENODEV;
>   2311		}
>   2312	
>   2313		argv4.buffer.type = ACPI_TYPE_BUFFER;
>   2314		argv4.buffer.length = sizeof(mode);
>   2315		argv4.buffer.pointer = (void *)&mode;
>   2316	
>   2317		obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
>   2318					BTINTEL_PCIE_DSM_DYNAMIC_PLDR, &argv4);
>   2319		if (!obj) {
>   2320			bt_dev_err(data->hdev, "Failed to call dsm to set reset method");
>   2321			return -EIO;
>   2322		}
>   2323		ACPI_FREE(obj);
>   2324	
>   2325		pci_dev_lock(data->pdev);
>   2326		pci_save_state(data->pdev);
>   2327		ret = btintel_acpi_reset_method(hdev);
>   2328		if (ret)
>   2329			bt_dev_err(data->hdev, "ACPI _PRR reset failed (%d),PLDR incomplete",
>   2330				   ret);
>   2331		pci_restore_state(data->pdev);
>   2332		pci_dev_unlock(data->pdev);
>   2333		return ret;
>   2334	}
>   2335	
> 


