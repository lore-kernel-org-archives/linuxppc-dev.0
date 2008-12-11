Return-Path: <m.fortini@selcomgroup.com>
Received: from averell.mail.tiscali.it (averell.mail.tiscali.it
	[213.205.33.55]) by ozlabs.org (Postfix) with ESMTP id 4D34ADDF65
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 09:07:20 +1100 (EST)
Message-ID: <49418CE4.6080109@selcomgroup.com>
Date: Thu, 11 Dec 2008 22:57:56 +0100
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RESEND] [PATCH] ADS5121 Fix: put dummy byte to enable fixing
	EOF bug to first place in order not to break some drivers\nUse
	ALARM	interrupt to avoid waiting for data to come in
References: <49400F56.2040008@selcomgroup.com>	<20081211093517.31741578@zod.rchland.ibm.com>	<49415E59.7000301@selcomgroup.com>
	<20081211134635.1badd234@zod.rchland.ibm.com>
In-Reply-To: <20081211134635.1badd234@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I rechecked it and I should have taken away all the only-whitespace changes.

The diffs are from the ads5121 branch from Denx.

Regards,
M


Josh Boyer ha scritto:
> On Thu, 11 Dec 2008 19:39:21 +0100
> Matteo Fortini <m.fortini@selcomgroup.com> wrote:
>
>   
>> This patch is to avoid breaking some drivers, in my case the ADS7846 
>> touchscreen one, which use 1 char messages.
>> If you put the dummy byte after the 1 char message, you get part of the 
>> answer to the message in the rxbuf of the message, which is thrown away.
>>
>> The solution is to put the dummy byte before the message, so that the 
>> slave doesn't respond.
>>
>> It also optimizes the interrupt handling, by using the alarm function of 
>> the FIFO, to wait until the rx FIFO has received enough bytes, instead 
>> of waiting until the tx FIFO is empty.
>>
>>
>>
>> Signed-off-by: Matteo Fortini <m.fortini@selcomgroup.com>
>> ---
>>  drivers/spi/mpc512x_psc_spi.c |   50 
>> +++++++++++++++++++++++-----------------
>>  1 files changed, 29 insertions(+), 21 deletions(-)
>>     
>
> This still seems to be whitespace corrupted.  Also, that file doesn't
> even exist in any upstream kernel I can find.  What tree did you diff
> this from?
>
> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>   
