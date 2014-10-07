Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FA3F1A01A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 23:35:43 +1100 (EST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EDEAE1400D5
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 23:35:41 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 7 Oct 2014 18:05:36 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7605A125805C
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 18:06:23 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s97CZpgL42926148
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2014 18:05:51 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s97CZUtC001297
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2014 18:05:31 +0530
Message-ID: <5433DE11.6060305@linux.vnet.ibm.com>
Date: Tue, 07 Oct 2014 18:05:29 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, peterz@infradead.org,
 akpm@linux-foundation.org, tglx@linutronix.de
Subject: Re: [PATCH V3 0/3] Add new PowerPC specific ELF core notes
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
 <53D0AD2B.4050004@au1.ibm.com>
In-Reply-To: <53D0AD2B.4050004@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, palves@redhat.com, oleg@redhat.com,
 dhowells@redhat.com, davej@redhat.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2014 12:22 PM, Sam Bobroff wrote:
>> Outstanding Issues
>> ==================
>> (1) Running DSCR register value inside a transaction does not seem to be saved
>>     at thread.dscr when the process stops for ptrace examination.
> 
> Since this is fixed by 96d016108640bc2b7fb0ee800737f80923847294, which
> is already upstream, you might want to rebase and re-test. It should
> pass and then you can remove the outstanding issues :-)

Sure will do that.

> 
>>     
>> Test programs
> 
> program
> 
> When I posted the patch I mentioned above, I was asked to move the test
> code into the powerpc kernel selftests so you may want to do this too.

Yes, I will add these ptrace related tests as tm/tm-ptrace.c test case.

> 
> Also, your test program covers everything mine did and more so you might
> want to remove mine if you do add this to the selftests.

The new one will be more ptrace specific, so wont remove yours which tests
the context saved DSCR value.

> 
>> =============
>> #include <unistd.h>
>> #include <stdlib.h>
>> #include <string.h>
>> #include <malloc.h>
>> #include <errno.h>
>> #include <sys/ptrace.h>
>> #include <sys/uio.h>
>> #include <sys/types.h>
>> #include <sys/signal.h>
>> #include <sys/user.h>
> 
> You should include sys/wait.h for waitpid().

Will do.

> status, i and flags are all unused.

Will remove them.

>> 			else
>> 				printf("DSCR FAILED\n");
>>
>> 			/* TM checkpointed GPR */
>> 			iov.iov_base = (struct pt_regs *) malloc(sizeof(struct pt_regs));;
>> 			iov.iov_len = sizeof(struct pt_regs);
>> 			ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CGPR, &iov);
>> 			if (ret == -1) {
>> 				printf("PTRACE_GETREGSET: NT_PPC_TM_CGPR failed: %s\n", strerror(errno));
>> 				exit(-1);
>> 			}
>>
>> 			if (iov.iov_len != sizeof(struct pt_regs)) {
>> 				printf("NT_PPC_TM_CGPR: Length returned is wrong\n");
>> 				exit(-1);
>> 			}
>>
>> 			pregs1 = iov.iov_base;
>> 			printf("-------TM checkpointed GPR-----\n");
>> 			printf("TM CH GPR[1]: %x\n", pregs1->gpr[1]);
>> 			printf("TM CH GPR[2]: %x\n", pregs1->gpr[2]);
>> 			printf("TM CH NIP: %x\n", pregs1->nip);
>> 			printf("TM CH LINK: %x\n", pregs1->link);
>> 			printf("TM CH CCR: %x\n", pregs1->ccr);
> 
> I get a compiler warning for these printfs: they should be "%lx".

Okay.

> 
>>
>> 			if (pregs1->gpr[1] == VAL1)
>> 				printf("GPR[1] PASSED\n");
>> 			else
>> 				printf("GPR[1] FAILED\n");
>>
>> 			if (pregs1->gpr[2] == VAL2)
>> 				printf("GPR[2] PASSED\n");
>> 			else
>> 				printf("GPR[2] FAILED\n");
>>
>> 			/* TM running GPR */
>> 			ret = ptrace(PTRACE_GETREGS, child, NULL, pregs2);
>> 			if (ret == -1) {
>> 				printf("PTRACE_GETREGS fail: %s\n", strerror(errno));
>> 				exit(-1);
>> 			}
>>
>> 			printf("-------TM running GPR-----\n");
>> 			printf("TM RN GPR[1]: %x\n", pregs2->gpr[1]);
>> 			printf("TM RN GPR[2]: %x\n", pregs2->gpr[2]);
>> 			printf("TM RN NIP: %x\n", pregs2->nip);
>> 			printf("TM RN LINK: %x\n", pregs2->link);
>> 			printf("TM RN CCR: %x\n", pregs2->ccr);
> 
> Same as above, I get warnings and they should be "%lx".

Okay. Will fix them.
