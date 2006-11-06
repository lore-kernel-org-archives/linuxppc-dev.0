Return-Path: <kalle.pokki@iki.fi>
Received: from host32.eke.fi (host32.eke.fi [194.100.64.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1CAF67C2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 07:49:57 +1100 (EST)
Date: Mon, 6 Nov 2006 22:49:49 +0200 (EET)
From: Kalle Pokki <kalle.pokki@iki.fi>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
In-Reply-To: <20061106205543.43b2aacb@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611062237300.16727@host32.eke.fi>
References: <Pine.LNX.4.64.0611061523360.12023@host32.eke.fi>
	<20061106205543.43b2aacb@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 6 Nov 2006, Vitaly Bordug wrote:

>> This patch renames these the two existing resources, and introduces a
>> new one, "pram_base", which is a pointer to the parameter RAM. The
>> parameter RAM for SMC1 and SMC2 is put in the first 128 bytes of the
>> DPRAM. This memory was already reserved from the DPRAM memory
>> allocator for this purpose.
>>
> Well just one objection. pram_base should not be a device unless it applies to all the stuff of
> SoC family which is not the case.
>
> For this aim, I'd put what you need into the platform_data, or follow the same approach 8xx stuff having.

I'm not sure I follow you now. "pram_base" is not a device by itself, but 
it's just another resource in the PQ2 version of the SMC devices in the 
platform_data. So the resource is only present when it is needed, and for 
other platform devices that don't have this resource, the cpm_uart code 
does nothing (as it should not).

The only difference to the 8xx version is the new "pram_base" resource, 
and it is required with PQ2, right?
