Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 2D5FBDE235
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 01:23:37 +1100 (EST)
Message-ID: <47273E6E.4030103@ru.mvista.com>
Date: Tue, 30 Oct 2007 17:23:42 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [POWERPC] Fix off-by-one error in setting decrementer on Book
 E
References: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
	<42A23BAB-6081-41CC-870C-7C7F094D69C3@kernel.crashing.org>
In-Reply-To: <42A23BAB-6081-41CC-870C-7C7F094D69C3@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Kumar Gala wrote:

>>The decrementer in Book E and 4xx processors interrupts on the
>>transition from 1 to 0, rather than on the 0 to -1 transition as on
>>64-bit server and 32-bit "classic" (6xx/7xx/7xxx) processors.

>>This fixes the problem by making set_dec subtract 1 from the count for
>>server and classic processors.  Since set_dec already had a bunch of
>>ifdefs to handle different processor types, there is no net increase
>>in ugliness. :)

>>This also removes a redundant call to set the decrementer to
>>0x7fffffff - it was already set to that earlier in timer_interrupt.

>>Signed-off-by: Paul Mackerras <paulus@samba.org>
>>---

> ...

>>diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
>>index f058955..eed64bd 100644
>>--- a/include/asm-powerpc/time.h
>>+++ b/include/asm-powerpc/time.h
>>@@ -183,6 +183,7 @@ static inline void set_dec(int val)
>> #elif defined(CONFIG_8xx_CPU6)
>> 	set_dec_cpu6(val);
>> #else
>>+	--val;	/* classic decrementer interrupts when dec goes negative */
>> #ifdef CONFIG_PPC_ISERIES
>> 	int cur_dec;

> Unless I'm reading set_dec() you are getting --val on booke.

    You meant "misreading"?
    Indeed the patch is decrementing count for *both* book E and classic CPUs 
now, and that slipped past my attention the first time.  The patch summary 
("Fix off-by-one error in setting decrementer on Book E") also looks stange -- 
there is *no* off-by-one error on Book E, and the description correctly says 
that we're fixing off-by-one on classic/server CPUs.
     Maybe I should even go and post my patch variant instead...

WBR, Sergei
