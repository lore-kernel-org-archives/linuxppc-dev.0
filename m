Return-Path: <breno.debian@gmail.com>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F2DG1TmlzF1BP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 07:21:33 +1000 (AEST)
Received: by mail-qt0-f196.google.com with SMTP id y31-v6so13342626qty.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 14:21:33 -0700 (PDT)
Subject: Re: [PATCH] selftests/powerpc: Fix strncpy usage
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <20180621231856.GO16221@gate.crashing.org>
 <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
 <20180623011009.GX16221@gate.crashing.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <ed94efce-10cb-5ea3-7bdf-5e544cd25bf7@debian.org>
Date: Mon, 25 Jun 2018 18:21:24 -0300
MIME-Version: 1.0
In-Reply-To: <20180623011009.GX16221@gate.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi Segher,

On 06/22/2018 10:10 PM, Segher Boessenkool wrote:
>> -       strncpy(prog, argv[0], strlen(argv[0]));
>> +       if (strlen(argv[0]) >= LEN_MAX){
>> +               fprintf(stderr, "Very big executable name: %s\n", argv[0]);
>> +               return 1;
>> +       }
>> +
>> +       strncpy(prog, argv[0], sizeof(prog) - 1);
> 
> The strlen reads all of argv[0], which can be very big in theory.  It won't
> matter in this test file -- program arguments cannot be super long, for one
> thing -- but it's not a good idea in general (that is one of the problems
> of strlcpy, btw).
> 
> Best of course is to avoid string length restrictions completely, if you can.

Right, I was thinking about this problem and there is no motivation to have a
statically allocated and limited region.

I will send a v2 where 'prog' and avoid this restriction completely.

Thanks
