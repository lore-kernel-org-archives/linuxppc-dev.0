Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0C7EDDE08
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 09:24:44 +1100 (EST)
Date: Mon, 17 Nov 2008 14:22:08 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Silence timebase sync code
In-Reply-To: <49889E01-9433-41BE-A6F1-66127856D482@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0811171421090.11673@t2.domain.actdsltmp>
References: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
	<49889E01-9433-41BE-A6F1-66127856D482@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Nov 2008, Kumar Gala wrote:
> On Nov 17, 2008, at 3:58 PM, Trent Piepho wrote:
>
>> It's over a dozen lines of output and doesn't appear to provide any useful
>> information.  Even after looking at the code, I'm in the dark about what
>> "score 299, offset 250" means.
>> 
>> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
>> ---
>> arch/powerpc/kernel/smp-tbsync.c |   12 ++++--------
>> 1 files changed, 4 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/smp-tbsync.c 
>> b/arch/powerpc/kernel/smp-tbsync.c
>> index bc892e6..b590135 100644
>> --- a/arch/powerpc/kernel/smp-tbsync.c
>> +++ b/arch/powerpc/kernel/smp-tbsync.c
>> @@ -113,7 +113,7 @@ void __devinit smp_generic_give_timebase(void)
>> {
>>  int i, score, score2, old, min=0, max=5000, offset=1000;
>> 
>> -	printk("Synchronizing timebase\n");
>> +	pr_info("Synchronizing timebase\n");
>
> I think its useful to leave this as a printk.

#define pr_info(fmt, arg...) \
         printk(KERN_INFO fmt, ##arg)

Isn't printk with no level tag the same as KERN_INFO?
