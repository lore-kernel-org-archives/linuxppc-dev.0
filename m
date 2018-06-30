Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HZs55hKCzF1LJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 10:58:49 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5U0wiTS119019
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 20:58:47 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwtau2vqr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 20:58:46 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 29 Jun 2018 20:58:45 -0400
References: <1529979376-7292-1-git-send-email-linuxram@us.ibm.com>
 <87fu16xpul.fsf@morokweng.localdomain>
 <20180629060715.36xlai5mayyx6j34@lt-gp.iram.es>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Ram Pai <linuxram@us.ibm.com>, fweimer@redhat.com, mhocko@kernel.org,
 Ulrich.Weigand@de.ibm.com, bauerman@linux.vnet.ibm.com,
 msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/pkeys: preallocate execute_only key only if
 the key is available.
In-reply-to: <20180629060715.36xlai5mayyx6j34@lt-gp.iram.es>
Date: Fri, 29 Jun 2018 21:58:37 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8736x5yts2.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Gabriel Paubert <paubert@iram.es> writes:

> On Thu, Jun 28, 2018 at 11:56:34PM -0300, Thiago Jung Bauermann wrote:
>>
>> Hello,
>>
>> Ram Pai <linuxram@us.ibm.com> writes:
>>
>> > Key 2 is preallocated and reserved for execute-only key. In rare
>> > cases if key-2 is unavailable, mprotect(PROT_EXEC) will behave
>> > incorrectly. NOTE: mprotect(PROT_EXEC) uses execute-only key.
>> >
>> > Ensure key 2 is available for preallocation before reserving it for
>> > execute_only purpose.  Problem noticed by Michael Ellermen.
>>
>> Since "powerpc/pkeys: Preallocate execute-only key" isn't upstream yet,
>> this patch could be squashed into it.
>>
>> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>> > ---
>> >  arch/powerpc/mm/pkeys.c |   14 +++++++++-----
>> >  1 files changed, 9 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
>> > index cec990c..0b03914 100644
>> > --- a/arch/powerpc/mm/pkeys.c
>> > +++ b/arch/powerpc/mm/pkeys.c
>> > @@ -19,6 +19,7 @@
>> >  u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
>> >  u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
>> >  u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
>> > +int  execute_only_key = 2;
>> >
>> >  #define AMR_BITS_PER_PKEY 2
>> >  #define AMR_RD_BIT 0x1UL
>> > @@ -26,7 +27,6 @@
>> >  #define IAMR_EX_BIT 0x1UL
>> >  #define PKEY_REG_BITS (sizeof(u64)*8)
>> >  #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
>> > -#define EXECUTE_ONLY_KEY 2
>> >
>> >  static void scan_pkey_feature(void)
>> >  {
>> > @@ -122,8 +122,12 @@ int pkey_initialize(void)
>> >  #else
>> >  	os_reserved = 0;
>> >  #endif
>> > +
>> > +	if ((pkeys_total - os_reserved) <= execute_only_key)
>> > +		execute_only_key = -1;
>> > +
>> >  	/* Bits are in LE format. */
>> > -	reserved_allocation_mask = (0x1 << 1) | (0x1 << EXECUTE_ONLY_KEY);
>> > +	reserved_allocation_mask = (0x1 << 1) | (0x1 << execute_only_key);
>>
>> My understanding is that left-shifting by a negative amount is undefined
>> behavior in C. A quick test tells me that at least on the couple of
>> machines I tested, 1 < -1 = 0. Does GCC guarantee that behavior?
>
> Not in general. It probably always works on Power because of the definition
> of the machine instruction for shifts with variable amount (consider the
> shift amount unsigned and take it modulo twice the width of the operand),

Ok, thanks for confirming.

> but for example it fails on x86 (1<<-1 gives 0x80000000).

Strange, this works on my laptop with an Intel(R) Core(TM) i5-7300U CPU:

$ cat blah.c
#include <stdio.h>

int main(int argc, char *argv[])
{
        printf("1 << -1 = %llx\n", (unsigned long long) 1 << -1);
        return 0;
}
$ make blah
cc     blah.c   -o blah
blah.c: In function 'main':
blah.c:5:52: warning: left shift count is negative [-Wshift-count-negative]
  printf("1 << -1 = %llx\n", (unsigned long long) 1 << -1);
                                                    ^~
$ ./blah
1 << -1 = 0

Even if I change the cast and printf format to int, the result is the
same. Or am I doing it wrong?

>> If so, a comment pointing this out would make this less confusing.
>
> Unless I miss something, this code is run once at boot, so its
> performance is irrelevant.
>
> In this case simply rewrite it as:
>
> 	reserved_allocation_mask = 0x1 << 1;
> 	if ( (pkeys_total - os_reserved) <= execute_only_key) {
> 		execute_only_key = -1;
> 	} else {
> 		reserved_allocation_mask = (0x1 << 1) | (0x1 << execute_only_key);
> 	}

I agree it's clearer and more robust code (except that the first
line should be inside the if block).

>
> Caveat, I have assumed that the code will either:
> - only run once,
> - pkeys_total and os_reserved are int, not unsigned

Both of the above are true.

--
Thiago Jung Bauermann
IBM Linux Technology Center
