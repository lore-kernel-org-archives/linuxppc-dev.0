Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4AA1DB7B99
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 21:49:33 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7LBldwY018396
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 05:47:39 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7LBnNif097970
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 05:49:23 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7LBnM6M032081
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 05:49:23 -0600
Date: Fri, 21 Aug 2009 07:49:19 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: [PATCH 1/2] powerpc/405ex: provide necessary fixup function to
	support cuImage
Message-ID: <20090821114919.GH2530@zod.rchland.ibm.com>
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
	<1250562484-16415-2-git-send-email-tiejun.chen@windriver.com>
	<20090820132644.GE2530@zod.rchland.ibm.com>
	<4A8E37F4.60806@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A8E37F4.60806@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 21, 2009 at 02:00:20PM +0800, tiejun.chen wrote:
>as I know. So I prefer to prefix with ibm405ex as you suggestion.
>
>>> diff --git a/arch/powerpc/boot/dcr.h b/arch/powerpc/boot/dcr.h
>>> index 95b9f53..ba41624 100644
>>> --- a/arch/powerpc/boot/dcr.h
>>> +++ b/arch/powerpc/boot/dcr.h
>>> @@ -153,6 +153,18 @@ static const unsigned long sdram_bxcr[] = { SDRAM0_B0CR, SDRAM0_B1CR,
>>> #define DCRN_CPC0_PLLMR1  0xf4
>>> #define DCRN_CPC0_UCR     0xf5
>>>
>>> +/* 405EX Clocking Control regs */
>>> +#define CPR0_CLKUPD     0x0020
>>> +#define CPR0_PLLC       0x0040
>>> +#define CPR0_PLLD       0x0060
>>> +#define CPR0_CPUD       0x0080
>>> +#define CPR0_PLBD       0x00a0
>>> +#define CPR0_OPBD       0x00c0
>>> +#define CPR0_PERD       0x00e0
>>> +#define CPR0_AHBD       0x0100
>>> +#define CPR0_ICFG       0x0140
>> 
>> You duplicated the #defines right below this.  Just change the comment for
>> the already existing defines to say "440GX/405EX Clock Control regs".
>
>I want to isolate 405EX with other 4xx for convenient maintaining code as my
>original. And although there are same offset as the register of 440GX, they are
>defined with different name on manual because of different design mechanism. So
>I hope we cannot be confused these when others track the codes.

That would make sense if #defines were something that really needed a lot of
maintenance, but they aren't.  They are essentially static once correct.  I'd
prefer not to grow another set of duplicate #defines.

Thanks.

josh
