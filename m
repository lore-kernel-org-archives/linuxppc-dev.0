Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B4F90DDEE9
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 04:32:00 +1100 (EST)
Message-ID: <4790E2DF.90806@scram.de>
Date: Fri, 18 Jan 2008 18:33:19 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH/RFCv2] [POWERPC] Add support for freescale watchdog to
	CPM serial driver.
References: <478F4AE3.5090803@scram.de> <4790DC33.2070104@freescale.com>
In-Reply-To: <4790DC33.2070104@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood schrieb:

>> +void watchdog_poke(void)
>> +{
>> +    if (wdt) {
>> +        out_be16(&wdt->swsrr, 0x556c);
>> +        out_be16(&wdt->swsrr, 0xaa39);
>> +    }
>> +}
> 
> This should be a function pointer, to allow for other watchdog types.

Thanks for the comments. Stephen Rothwell also asked if the filename watchdog.c is too generic.
I think the pq watchdog is easy enough to keep it in the generic watchdog.c file, but the
function pointer definitely is the way to go. I'll resubmit.

Thanks,
Jochen
