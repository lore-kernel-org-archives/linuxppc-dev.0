Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C670C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:53:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CB62086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="EG+2p6NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CB62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42z1L959TTzF3N1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 18:53:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="EG+2p6NJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="EG+2p6NJ"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42z1HJ4ZgYzF3JH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 18:51:07 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id z23so2943795plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 23:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rn4xbEQHKNEKP+5VSJ5Li5mx+pCvlGtv4mQv+iLTkh0=;
 b=EG+2p6NJMtl0+QhICHBQBsHMdXo3HwuTWElMaERg3oqxE9QelZxFUw0E2Vjndi6t6N
 uSSdyTItIDJ4oQ7Mmqs0hOlDQQegnhc5BpFCdgRSrayf+hoMVXIndMixclcHd/B/GxOH
 NKWsX3JdUJZ1y85BQAg+arhb0rB5feh4pnTLZjv/UBYTveGvegZOohMa9rtycYNK24+i
 XMvcA+swoUKH5E0YA/NKDkX9ZIRSXKA4rd2C0dmgW/H4feBcIH3gziCh00gmn1td8slI
 waroxY10c3DgBHSwjj6KY5Dgp5XKYq+TZbTCl8vsZM9NYyhqDCtJYZy+jxAvMqvzmYeU
 yxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rn4xbEQHKNEKP+5VSJ5Li5mx+pCvlGtv4mQv+iLTkh0=;
 b=q3r1OoHMGH86waxx41I7KdkVc2WWJXr/nNFtQYBAtD904cCHNiiplpdmg2G4Fmn3T6
 eQ954yMmVC3ejmhcxqp4vX4bTa9A7AT4JaGWKWb6mc36WJSWM/+XR9EVf8DYiFzdZ3Ej
 q+0LkJVlBpr6NCmj8xcLqSw94VC99KaoNwQWYDZsBBvdd/31a10KOTZzO95wuusBPRys
 2wgxrS92atXptv+HfhZk+geCl9a/5WAUXcUhAZIwDvAZaM9umk2gcYaNYQDzeOvqkKNz
 Dq1QLNYTpnFCQx8WhnQ8yOZ3X6WdLvrelFUyK8nEClwvPBApG29eGLetKuvWV4fbhqGp
 Rsmw==
X-Gm-Message-State: AGRZ1gJAhdgGyjAlrCXb+X4IkItsKtrWdaQUYuL69QrlktVzVGFRbk8D
 4eGiKA54DgJ3os+rAU6Qeolf0Q==
X-Google-Smtp-Source: AJdET5e5M0zJJmv9nctoCEEppFViRrMU4Y9Soq9JRdj12at1gMtjgCfa2g28bsVbSq/+N/EPOum3nw==
X-Received: by 2002:a17:902:4683:: with SMTP id
 p3-v6mr21566620pld.215.1542613866210; 
 Sun, 18 Nov 2018 23:51:06 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id g136sm22151267pfb.154.2018.11.18.23.51.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Nov 2018 23:51:05 -0800 (PST)
Subject: Re: [PATCH kernel v3 11/22] powerpc/pseries/npu: Enable platform
 support
To: David Gibson <david@gibson.dropbear.id.au>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-12-aik@ozlabs.ru> <20181116052534.GD23632@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 xsFNBE+rT0sBEADFEI2UtPRsLLvnRf+tI9nA8T91+jDK3NLkqV+2DKHkTGPP5qzDZpRSH6mD
 EePO1JqpVuIow/wGud9xaPA5uvuVgRS1q7RU8otD+7VLDFzPRiRE4Jfr2CW89Ox6BF+q5ZPV
 /pS4v4G9eOrw1v09lEKHB9WtiBVhhxKK1LnUjPEH3ifkOkgW7jFfoYgTdtB3XaXVgYnNPDFo
 PTBYsJy+wr89XfyHr2Ev7BB3Xaf7qICXdBF8MEVY8t/UFsesg4wFWOuzCfqxFmKEaPDZlTuR
 tfLAeVpslNfWCi5ybPlowLx6KJqOsI9R2a9o4qRXWGP7IwiMRAC3iiPyk9cknt8ee6EUIxI6
 t847eFaVKI/6WcxhszI0R6Cj+N4y+1rHfkGWYWupCiHwj9DjILW9iEAncVgQmkNPpUsZECLT
 WQzMuVSxjuXW4nJ6f4OFHqL2dU//qR+BM/eJ0TT3OnfLcPqfucGxubhT7n/CXUxEy+mvWwnm
 s9p4uqVpTfEuzQ0/bE6t7dZdPBua7eYox1AQnk8JQDwC3Rn9kZq2O7u5KuJP5MfludMmQevm
 pHYEMF4vZuIpWcOrrSctJfIIEyhDoDmR34bCXAZfNJ4p4H6TPqPh671uMQV82CfTxTrMhGFq
 8WYU2AH86FrVQfWoH09z1WqhlOm/KZhAV5FndwVjQJs1MRXD8QARAQABzSRBbGV4ZXkgS2Fy
 ZGFzaGV2c2tpeSA8YWlrQG96bGFicy5ydT7CwXgEEwECACIFAk+rT0sCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJEIYTPdgrwSC5fAIP/0wf/oSYaCq9PhO0UP9zLSEz66SSZUf7
 AM9O1rau1lJpT8RoNa0hXFXIVbqPPKPZgorQV8SVmYRLr0oSmPnTiZC82x2dJGOR8x4E01gK
 TanY53J/Z6+CpYykqcIpOlGsytUTBA+AFOpdaFxnJ9a8p2wA586fhCZHVpV7W6EtUPH1SFTQ
 q5xvBmr3KkWGjz1FSLH4FeB70zP6uyuf/B2KPmdlPkyuoafl2UrU8LBADi/efc53PZUAREih
 sm3ch4AxaL4QIWOmlE93S+9nHZSRo9jgGXB1LzAiMRII3/2Leg7O4hBHZ9Nki8/fbDo5///+
 kD4L7UNbSUM/ACWHhd4m1zkzTbyRzvL8NAVQ3rckLOmju7Eu9whiPueGMi5sihy9VQKHmEOx
 OMEhxLRQbzj4ypRLS9a+oxk1BMMu9cd/TccNy0uwx2UUjDQw/cXw2rRWTRCxoKmUsQ+eNWEd
 iYLW6TCfl9CfHlT6A7Zmeqx2DCeFafqEd69DqR9A8W5rx6LQcl0iOlkNqJxxbbW3ddDsLU/Y
 r4cY20++WwOhSNghhtrroP+gouTOIrNE/tvG16jHs8nrYBZuc02nfX1/gd8eguNfVX/ZTHiR
 gHBWe40xBKwBEK2UeqSpeVTohYWGBkcd64naGtK9qHdo1zY1P55lHEc5Uhlk743PgAnOi27Q
 ns5zzsFNBE+rT0sBEACnV6GBSm+25ACT+XAE0t6HHAwDy+UKfPNaQBNTTt31GIk5aXb2Kl/p
 AgwZhQFEjZwDbl9D/f2GtmUHWKcCmWsYd5M/6Ljnbp0Ti5/xi6FyfqnO+G/wD2VhGcKBId1X
 Em/B5y1kZVbzcGVjgD3HiRTqE63UPld45bgK2XVbi2+x8lFvzuFq56E3ZsJZ+WrXpArQXib2
 hzNFwQleq/KLBDOqTT7H+NpjPFR09Qzfa7wIU6pMNF2uFg5ihb+KatxgRDHg70+BzQfa6PPA
 o1xioKXW1eHeRGMmULM0Eweuvpc7/STD3K7EJ5bBq8svoXKuRxoWRkAp9Ll65KTUXgfS+c0x
 gkzJAn8aTG0z/oEJCKPJ08CtYQ5j7AgWJBIqG+PpYrEkhjzSn+DZ5Yl8r+JnZ2cJlYsUHAB9
 jwBnWmLCR3gfop65q84zLXRQKWkASRhBp4JK3IS2Zz7Nd/Sqsowwh8x+3/IUxVEIMaVoUaxk
 Wt8kx40h3VrnLTFRQwQChm/TBtXqVFIuv7/Mhvvcq11xnzKjm2FCnTvCh6T2wJw3de6kYjCO
 7wsaQ2y3i1Gkad45S0hzag/AuhQJbieowKecuI7WSeV8AOFVHmgfhKti8t4Ff758Z0tw5Fpc
 BFDngh6Lty9yR/fKrbkkp6ux1gJ2QncwK1v5kFks82Cgj+DSXK6GUQARAQABwsFfBBgBAgAJ
 BQJPq09LAhsMAAoJEIYTPdgrwSC5NYEP/2DmcEa7K9A+BT2+G5GXaaiFa098DeDrnjmRvumJ
 BhA1UdZRdfqICBADmKHlJjj2xYo387sZpS6ABbhrFxM6s37g/pGPvFUFn49C47SqkoGcbeDz
 Ha7JHyYUC+Tz1dpB8EQDh5xHMXj7t59mRDgsZ2uVBKtXj2ZkbizSHlyoeCfs1gZKQgQE8Ffc
 F8eWKoqAQtn3j4nE3RXbxzTJJfExjFB53vy2wV48fUBdyoXKwE85fiPglQ8bU++0XdOr9oyy
 j1llZlB9t3tKVv401JAdX8EN0++ETiOovQdzE1m+6ioDCtKEx84ObZJM0yGSEGEanrWjiwsa
 nzeK0pJQM9EwoEYi8TBGhHC9ksaAAQipSH7F2OHSYIlYtd91QoiemgclZcSgrxKSJhyFhmLr
 QEiEILTKn/pqJfhHU/7R7UtlDAmFMUp7ByywB4JLcyD10lTmrEJ0iyRRTVfDrfVP82aMBXgF
 tKQaCxcmLCaEtrSrYGzd1sSPwJne9ssfq0SE/LM1J7VdCjm6OWV33SwKrfd6rOtvOzgadrG6
 3bgUVBw+bsXhWDd8tvuCXmdY4bnUblxF2B6GOwSY43v6suugBttIyW5Bl2tXSTwP+zQisOJo
 +dpVG2pRr39h+buHB3NY83NEPXm1kUOhduJUA17XUY6QQCAaN4sdwPqHq938S3EmtVhs
Message-ID: <c8dee175-d33a-232d-5237-9233b74e0697@ozlabs.ru>
Date: Mon, 19 Nov 2018 18:50:58 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116052534.GD23632@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 16/11/2018 16:25, David Gibson wrote:
> On Tue, Nov 13, 2018 at 07:28:12PM +1100, Alexey Kardashevskiy wrote:
>> We already changed NPU API for GPUs to not to call OPAL and the remaining
>> bit is initializing NPU structures.
>>
>> This uses a new QEMU capability which marks NPU-enabled vPHBs as
>> "IBM,npu-vphb" and initializes an NPU structure per vPHB.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/platforms/pseries/pci.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
>> index 41d8a4d..a50d5e4 100644
>> --- a/arch/powerpc/platforms/pseries/pci.c
>> +++ b/arch/powerpc/platforms/pseries/pci.c
>> @@ -29,6 +29,7 @@
>>  #include <asm/pci-bridge.h>
>>  #include <asm/prom.h>
>>  #include <asm/ppc-pci.h>
>> +#include <asm/pci.h>
>>  #include "pseries.h"
>>  
>>  #if 0
>> @@ -237,6 +238,8 @@ static void __init pSeries_request_regions(void)
>>  
>>  void __init pSeries_final_fixup(void)
>>  {
>> +	struct pci_controller *hose;
>> +
>>  	pSeries_request_regions();
>>  
>>  	eeh_probe_devices();
>> @@ -246,6 +249,9 @@ void __init pSeries_final_fixup(void)
>>  	ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
>>  	ppc_md.pcibios_sriov_disable = pseries_pcibios_sriov_disable;
>>  #endif
>> +	list_for_each_entry(hose, &hose_list, list_node)
>> +		if (of_device_is_compatible(hose->dn, "IBM,npu-vphb"))
>> +			pnv_npu2_init(hose);
> 
> I take it from this the NPUs are showing up with a compatible property
> that lists the normal PHB value as well as IBM,npu-vphb.  Since AIUI
> the NPUs act quite differently from other (real) PHBs this seems
> bogus.  Shouldn't they be probed separately?

First, bad naming, will think of better one.

"IBM,npu-vphb" is an extra compatible type for otherwise usual pseries
PHB. The  differences are:

1. Initialize an "NPU" (not a NVLink2 bridge but a proper NPU) per a PHB
for context manipulation for a GPU;

2. Kill the default DMA window.

When a GPU is passed to a guest, it looks like:

aik@u1804kvm:~$ lspci
00:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
Controller (rev 03)
00:01.0 Ethernet controller: Red Hat, Inc Virtio network device
00:02.0 3D controller: NVIDIA Corporation GV100 [Tesla V100 SXM2] (rev a1)
00:03.0 Bridge: IBM Device 04ea (rev 01)
00:04.0 Bridge: IBM Device 04ea (rev 01)

So there are:
- one "struct npu" associated with the pseries PHB (not presented in
lspci but there /proc/device-tree/npuphb0/ with link@0 and link@1)

- 2 NVLink2 bridges, presented in lspci.


-- 
Alexey
