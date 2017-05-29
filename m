Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wblTj1cs2zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 15:21:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>, Nicholas Piggin <npiggin@gmail.com>,
 christophe leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 3/3] powerpc/8xx: xmon compile fix
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0000223@AcuExch.aculab.com>
References: <20170511151522.4772-1-npiggin@gmail.com>
 <20170511151522.4772-3-npiggin@gmail.com>
 <b84f2d89-fc2f-d25f-1871-8fcd7b133fcf@c-s.fr>
 <fdb9e787-e397-a46e-467c-066d51d73131@c-s.fr>
 <20170512104707.5393eaa1@roar.ozlabs.ibm.com>
 <87o9ug84ia.fsf@concordia.ellerman.id.au>
 <063D6719AE5E284EB5DD2968C1650D6DD0000223@AcuExch.aculab.com>
Date: Mon, 29 May 2017 15:21:44 +1000
Message-ID: <87o9uc6xw7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight <David.Laight@ACULAB.COM> writes:

> From:  Michael Ellerman
>> Sent: 26 May 2017 08:24
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> > index f11f65634aab..438fdb0fb142 100644
>> > --- a/arch/powerpc/xmon/xmon.c
>> > +++ b/arch/powerpc/xmon/xmon.c
>> > @@ -1242,14 +1242,16 @@ bpt_cmds(void)
>> >  {
>> >  	int cmd;
>> >  	unsigned long a;
>> > -	int mode, i;
>> > +	int i;
>> >  	struct bpt *bp;
>> > -	const char badaddr[] = "Only kernel addresses are permitted "
>> > -		"for breakpoints\n";
>> >
>> >  	cmd = inchar();
>> >  	switch (cmd) {
>> > -#ifndef CONFIG_8xx
>> > +#ifndef CONFIG_PPC_8xx
>> > +	int mode;
>> > +	const char badaddr[] = "Only kernel addresses are permitted "
>> > +		"for breakpoints\n";
>> > +
>> >  	case 'd':	/* bd - hardware data breakpoint */
>> >  		mode = 7;
>> >  		cmd = inchar();
>> 
>> GCC 7 rejects this:
>> 
>>   arch/powerpc/xmon/xmon.c: In function bpt_cmds:
>>   arch/powerpc/xmon/xmon.c:1252:13: error: statement will never be executed [-Werror=switch-
>> unreachable]
>>     const char badaddr[] = "Only kernel addresses are permitted for breakpoints\n";
>>                ^~~~~~~
>
> Try 'static' ?

Yep that works, will rebase this again ... O_o

cheers
