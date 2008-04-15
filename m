Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5FB49DE128
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 07:35:39 +1000 (EST)
Message-ID: <48051FBA.1000801@freescale.com>
Date: Tue, 15 Apr 2008 16:35:54 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: cbouatmailru@gmail.com
Subject: Re: [PATCH] fsl_soc: Factor fsl_get_sys_freq() out of the wdt and
	spi inits.
References: <20080415185234.GA10579@loki.buserror.net>
	<20080415213221.GA2646@zarina>
In-Reply-To: <20080415213221.GA2646@zarina>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
>> +u32 fsl_get_sys_freq(void)
>> +{
>> +	struct device_node *soc;
>> +	const u32 *prop;
>> +	int size;
>> +
>> +	if (sysfreq != -1)
>> +		return sysfreq;
>> +
>> +	soc = of_find_node_by_type(NULL, "soc");
>> +	if (!soc)
>> +		return -1;
> 
> Um.. can we finally decide on compatible for the soc nodes,
> and add there compatible matching from the start?

This is just a code reorganization; any change in what we match on 
should be a separate patch.

-Scott
