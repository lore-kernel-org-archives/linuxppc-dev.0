Return-Path: <breno.debian@gmail.com>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41C1Xp1910zF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 00:43:53 +1000 (AEST)
Received: by mail-qk0-f195.google.com with SMTP id y4-v6so3784121qka.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 07:43:53 -0700 (PDT)
Subject: Re: [PATCH] selftests/powerpc: Fix strncpy usage
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <20180621231856.GO16221@gate.crashing.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
Date: Fri, 22 Jun 2018 11:43:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180621231856.GO16221@gate.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Segher,

On 06/21/2018 08:18 PM, Segher Boessenkool wrote:
> On Wed, Jun 20, 2018 at 07:51:11PM -0300, Breno Leitao wrote:
>> -	strncpy(prog, argv[0], strlen(argv[0]));
>> +	strncpy(prog, argv[0], sizeof(prog) - 1);
> 
> 	strncpy(prog, argv[0], sizeof prog);
> 	if (prog[sizeof prog - 1])
> 		scream_bloody_murder();
> 
> Silently using the wrong data is a worse habit than not checking for
> overflows ;-)

Completely agree! Thanks for bringing this up.

If you don't mind, I would solve this problem slightly different, as it seems
to be more readable.


-       strncpy(prog, argv[0], strlen(argv[0]));
+       if (strlen(argv[0]) >= LEN_MAX){
+               fprintf(stderr, "Very big executable name: %s\n", argv[0]);
+               return 1;
+       }
+
+       strncpy(prog, argv[0], sizeof(prog) - 1);
        return test_harness(dscr_inherit_exec, "dscr_inherit_exec_test");
