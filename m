Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 097EFDE093
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 05:36:41 +1000 (EST)
Message-Id: <3BD17695-2826-43CC-98A0-16F3E33EDC43@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080429183559.GE6561@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Date: Tue, 29 Apr 2008 14:36:32 -0500
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<20080429183559.GE6561@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2008, at 1:35 PM, Scott Wood wrote:
> On Tue, Apr 29, 2008 at 08:56:56AM -0500, Kumar Gala wrote:
>> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
>> +#ifdef CONFIG_SMP
>> +#define SMP_ADJUST_GLOBAL_DBCR0						       \
>> +	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT);				       \
>> +	lwz	r9,TI_CPU(r9);						       \
>> +	slwi	r9,r9,3;						       \
>> +	add	r11,r11,r9;
>> +#else
>> +#define SMP_ADJUST_GLOBAL_DBCR0
>> +#endif
>> +#define HANDLE_DBCR							       \
>> +	/* Check to see if the dbcr0 register is set up to debug.  Use  
>> the     \
>> +	   internal debug mode bit to do this. */			       \
>> +	lwz	r12,THREAD_DBCR0(r12);					       \
>> +	andis.	r12,r12,DBCR0_IDM@h;					       \
>
> Can we use assembler macros rather than preprocessor macros to get  
> rid of
> the backslashes?

what's an assembler macro look like?  I don't believe we use them  
anywhere else.

- k
