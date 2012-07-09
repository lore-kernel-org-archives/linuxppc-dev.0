Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 330972C01FA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 02:43:17 +1000 (EST)
Message-ID: <4FFB0A17.2030501@freescale.com>
Date: Mon, 9 Jul 2012 11:43:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/mpic: finish supporting timer group B on
 Freescale chips
References: <1341823542-15654-1-git-send-email-Varun.Sethi@freescale.com>
 <58A5C37E-E2AA-4135-8419-9070FAFE84A2@kernel.crashing.org>
In-Reply-To: <58A5C37E-E2AA-4135-8419-9070FAFE84A2@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2012 09:12 AM, Kumar Gala wrote:
> 
> On Jul 9, 2012, at 3:45 AM, Varun Sethi wrote:
> 
>> Previously, these interrupts would be mapped, but the offset
>> calculation was broken, and only the first group was initialized.
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> ---
>> arch/powerpc/include/asm/mpic.h |    5 +++
>> arch/powerpc/sysdev/mpic.c      |   58 ++++++++++++++++++++++++++++-----------
>> 2 files changed, 47 insertions(+), 16 deletions(-)

Varun, where's your signoff?

>> +	if (mpic->flags & MPIC_FSL) {
>> +		u32 brr1 = _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
>> +				      MPIC_FSL_BRR1);
>> +		u32 version = brr1 & MPIC_FSL_BRR1_VER;
>> +
>> +		/*
>> +		 * Timer group B is present at the latest in MPIC 3.1 (e.g.
>> +		 * mpc8536).  It is not present in MPIC 2.0 (e.g. mpc8544).
>> +		 * I don't know about the status of intermediate versions (or
>> +		 * whether they even exist).
>> +		 */
>> +		if (version >= 0x0301)
>> +			num_timers = 8;
>> +	}
>> +
> 
> Why don't we do this just via the device tree?

Then we'd have to change existing device trees (again), and in general
there's no reason to put it in the device tree if it's discoverable via
hardware version registers.

-Scott
