Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp10.mail.mci.yahoo.co.jp (ybbsmtp10.mail.mci.yahoo.co.jp
	[210.80.241.184]) by ozlabs.org (Postfix) with SMTP id 8B4C467A6E
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2005 03:27:17 +1100 (EST)
Message-ID: <423073A9.70404@ybb.ne.jp>
Date: Fri, 11 Mar 2005 01:19:53 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Joerg Dorchain <joerg@dorchain.net>
References: <20050303124435.GA24233@Redstar.dorchain.net>	<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>	<20050304075703.GA15637@Redstar.dorchain.net>	<422FD24F.4070108@jp.fujitsu.com>
	<20050310072803.GR4017@Redstar.dorchain.net>
In-Reply-To: <20050310072803.GR4017@Redstar.dorchain.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: boot time scheduling hile atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Joerg:

> I came to the same idea. This explains as well why the i386 party does
> not notice the effect, as their first interrupt happen later (different
> HZ value)
> 
As far as I know, current HZ value for PPC is 1000
as same as i386 family.

Please see following:

-- include/asm-i386/param.h
   1 #ifndef _ASMi386_PARAM_H
   2 #define _ASMi386_PARAM_H
   3
   4 #ifdef __KERNEL__
   5 # define HZ             1000            /* Internal kernel timer 
frequency */
-- include/asm-i386/param.h

-- include/asm-ppc/param.h

   1 #ifndef _ASM_PPC_PARAM_H
   2 #define _ASM_PPC_PARAM_H
   3
   4 #ifdef __KERNEL__
   5 #define HZ              1000            /* internal timer frequency */
   6 #define USER_HZ         100             /* for user interfaces in 
"ticks" */
-- include/asm-ppc/param.h

FYI, Kernel preemption ought not to be taken place at this point,
because preemption count is a positive number.

According to my observation, the problem occur on second call of
proc_root_init.But I could not who call it.
IIRC,the value of LR(link register) pointed at the start of BSS.

Regards,



-- 
Takeharu KATO
