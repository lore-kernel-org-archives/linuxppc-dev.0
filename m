Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 658091A0DFA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:47:21 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 23 Jan 2015 13:47:19 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6D8522BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:47:16 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0N3l7M547644760
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:47:16 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0N3kgT6002754
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:46:42 +1100
Message-ID: <54C1C411.2080703@linux.vnet.ibm.com>
Date: Fri, 23 Jan 2015 09:16:25 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] powerpc: Add helpers for LPCR PECE1 operations
References: <1421654727-31656-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1421982392.24984.9.camel@ellerman.id.au>
In-Reply-To: <1421982392.24984.9.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 23 January 2015 08:36 AM, Michael Ellerman wrote:
> On Mon, 2015-01-19 at 13:35 +0530, Shreyas B. Prabhu wrote:
>> PECE1 bit in LPCR is used to control whether decrementer can cause exit
>> from powersaving states. PECE1 bit is cleared before entering fastsleep
>> or deeper powersaving state and it is set on waking up. Since both
>> cpuidle and cpu offline operations use these powersaving states, add
>> helper functions to be used in both these places.
> 
> Thanks.
> 
> That isn't really much clearer than the original, so in the end I just merged
> your original fix.
> 
> I'll think if there's a bigger consolidation we can do that makes it clearer.
> 
> cheers
> 
> 
Helper could have been this :

#define   LPCR_CLEAR_PECE1	(mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1)

This perhaps would make it more clearer, but it will end up using additional mfspr here-

    static int fastsleep_loop(struct cpuidle_device *dev,
    				struct cpuidle_driver *drv,
    				int index)
    {
    	...
    
    	new_lpcr = old_lpcr;
    	/* Do not exit powersave upon decrementer as we've setup the timer
    	 * offload.
    	 */
    	new_lpcr &= ~LPCR_PECE1;
    
    	mtspr(SPRN_LPCR, new_lpcr);
