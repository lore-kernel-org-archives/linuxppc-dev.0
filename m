Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9318AB6F71
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Jan 2012 08:03:14 +1100 (EST)
Message-ID: <4F076187.2080308@freescale.com>
Date: Fri, 6 Jan 2012 15:03:03 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl> <4F04BFEA.1050009@freescale.com>
 <4F05C8C2.9070401@aimvalley.nl> <4F05EA6B.9040902@freescale.com>
 <4F06FCBC.4090302@aimvalley.nl>
In-Reply-To: <4F06FCBC.4090302@aimvalley.nl>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/06/2012 07:53 AM, Norbert van Bolhuis wrote:
> On 01/05/12 19:22, Scott Wood wrote:
>> On 01/05/2012 09:58 AM, Norbert van Bolhuis wrote:
>>> thanks for your response.
>>>
>>> not setting MSR_POW gives same result.
>>
>> OK, so you're not getting an interrupt regardless of low-power state.
>>
>> Check whether the interrupt is getting masked during standby preparation.
>>
>> Does the interrupt handler run when you're not trying to enter standby?
>>
> 
> 
> The GPIO/UART interrupt nor the PMC interrupt are being masked during
> standby
> preperation.
> The GPIO/UART interrupt works fine in "operational" mode.
> The PMC interrupt I do not know, is it possible to to get PMC interrupt
> without going to standby or deep-sleep ?

The PMC interrupt is mainly of interest when running as a PCI agent, to
be notified when the host changed the desired suspend state in config space.

What changes from operational mode to the test where you omit setting
MSR_POW?

Try dumping SIPNR/SIMSR and GPIER/GPIMR/GPDAT at various points.

-Scott
