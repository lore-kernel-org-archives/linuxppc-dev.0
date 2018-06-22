Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41C1jT6GlpzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 00:51:25 +1000 (AEST)
Subject: Re: [PATCH] selftests/powerpc: Fix strncpy usage
To: Breno Leitao <leitao@debian.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <20180621231856.GO16221@gate.crashing.org>
 <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <9cd93c1d-c067-3a18-bfd8-fef1ef443739@c-s.fr>
Date: Fri, 22 Jun 2018 16:51:21 +0200
MIME-Version: 1.0
In-Reply-To: <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/06/2018 à 16:43, Breno Leitao a écrit :
> Hi Segher,
> 
> On 06/21/2018 08:18 PM, Segher Boessenkool wrote:
>> On Wed, Jun 20, 2018 at 07:51:11PM -0300, Breno Leitao wrote:
>>> -	strncpy(prog, argv[0], strlen(argv[0]));
>>> +	strncpy(prog, argv[0], sizeof(prog) - 1);
>>
>> 	strncpy(prog, argv[0], sizeof prog);
>> 	if (prog[sizeof prog - 1])
>> 		scream_bloody_murder();
>>
>> Silently using the wrong data is a worse habit than not checking for
>> overflows ;-)
> 
> Completely agree! Thanks for bringing this up.
> 
> If you don't mind, I would solve this problem slightly different, as it seems
> to be more readable.
> 
> 
> -       strncpy(prog, argv[0], strlen(argv[0]));
> +       if (strlen(argv[0]) >= LEN_MAX){

wouldn't it be better to use sizeof(prog) instead of LEN_MAX ?

> +               fprintf(stderr, "Very big executable name: %s\n", argv[0]);
> +               return 1;
> +       }
> +
> +       strncpy(prog, argv[0], sizeof(prog) - 1);

You have checked before that argv[0] is not too long, so you should not 
need to use strncpy(), strcpy() would do it.

>          return test_harness(dscr_inherit_exec, "dscr_inherit_exec_test");
> 

Christophe
