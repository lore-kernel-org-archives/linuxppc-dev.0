Return-Path: <al.dunsmuir@sympatico.ca>
Received: from mtlfep03.bell.net (belmont94srvr.owm.bell.net [184.150.200.94])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41CB3w1KmlzF132
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 07:07:54 +1000 (AEST)
Received: from bell.net mtlfep02 184.150.200.30 by mtlfep02.bell.net with ESMTP
 id <20180622210147.SKDI8528.mtlfep02.bell.net@mtlspm01.bell.net>
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 17:01:47 -0400
Date: Fri, 22 Jun 2018 17:01:45 -0400
From: Al Dunsmuir <al.dunsmuir@sympatico.ca>
Message-ID: <56894976.20180622170145@sympatico.ca>
To: Paul Clarke <pc@us.ibm.com>, Breno Leitao <leitao@debian.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Fix strncpy usage
In-Reply-To: <12953a47-a6a7-5f70-a46c-c95f8c424d11@us.ibm.com>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <20180621231856.GO16221@gate.crashing.org>
 <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
 <12953a47-a6a7-5f70-a46c-c95f8c424d11@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, June 22, 2018, 11:15:29 AM, Paul Clarke wrote:
> On 06/22/2018 09:43 AM, Breno Leitao wrote:
>> If you don't mind, I would solve this problem slightly different, as it seems
>> to be more readable.
>> 
>> -       strncpy(prog, argv[0], strlen(argv[0]));
>> +       if (strlen(argv[0]) >= LEN_MAX){
>> +               fprintf(stderr, "Very big executable name: %s\n", argv[0]);

> "Very big" is an observation.  "Too big" indicates a problem
> better.  Or, more explicitly "Executable name is too long".

Or even better, display the limit that is being exceeded, in case that
value changes over time.  Something like.

-       strncpy(prog, argv[0], strlen(argv[0]));
+       if (strlen(argv[0]) >= LEN_MAX){
+                fprintf(stderr, "Executable name exceeds limit (%d): %s\n",
+                        LEN_MAX,
+                        argv[0]);
