Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DBF49B6F75
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2011 01:19:02 +1100 (EST)
Subject: Re: [1/4] powerpc: Revert show_regs() define for readability
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1ADB010A-A48C-4E71-91E0-94D60A3E676F@pobox.com>
Date: Mon, 31 Oct 2011 09:18:57 -0500
Message-Id: <F8FBC967-70A0-47F4-9BB8-3E16CCEC6565@kernel.crashing.org>
References: <1317905621-5537-1-git-send-email-galak@kernel.crashing.org>
 <1ADB010A-A48C-4E71-91E0-94D60A3E676F@pobox.com>
To: Jimi Xenidis <jimix@pobox.com>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 28, 2011, at 2:40 PM, Jimi Xenidis wrote:

> 
> On Oct 5, 2011, at 9:53 PM, Kumar Gala wrote:
> 
>> We had an existing ifdef for 4xx & BOOKE processors that got changed to
>> CONFIG_PPC_ADV_DEBUG_REGS.  The define has nothing to do with
>> CONFIG_PPC_ADV_DEBUG_REGS.  The define really should be:
>> 
>> #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
>> 
>> and not
>> 
>> #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>> 
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> 
>> ---
>> arch/powerpc/kernel/process.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index 8f53954..a1b5981 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -657,7 +657,7 @@ void show_regs(struct pt_regs * regs)
>> 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
>> 		printk("CFAR: "REG"\n", regs->orig_gpr3);
>> 	if (trap == 0x300 || trap == 0x600)
>> -#ifdef CONFIG_PPC_ADV_DEBUG_REGS
>> +#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
>> 		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);
> 
> I'll be needing "|| defined(CONFIG_PPC_BOOK3E)" added to this please.
> -jx

Under what platform is CONFIG_PPC_BOOK3E set and CONFIG_BOOKE is not?

- k
