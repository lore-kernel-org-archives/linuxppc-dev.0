Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 10EB41A0358
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 19:39:48 +1100 (AEDT)
Message-ID: <54F967D0.5030209@c-s.fr>
Date: Fri, 06 Mar 2015 09:39:44 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 0/17] crypto: talitos - Add support for SEC1
References: <20150305164605.E65D81A241C@localhost.localdomain>
 <20150305182101.6db66e228f519476f0751c13@freescale.com>
 <20150306002831.GA30947@gondor.apana.org.au>
In-Reply-To: <20150306002831.GA30947@gondor.apana.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-crypto@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 06/03/2015 01:28, Herbert Xu a écrit :
> On Thu, Mar 05, 2015 at 06:21:01PM -0600, Kim Phillips wrote:
>> On Thu, 5 Mar 2015 17:46:05 +0100
>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>>> [15/17] crypto: talitos - Implementation of SEC1
>> ...
>>
>>> [16/17] crypto: talitos - SEC1 bugs on 0 data hash
>>> [17/17] crypto: talitos - Update DT bindings with SEC1
>> This patchseries doesn't apply, at least on top of Herbert's
>> cryptodev-2.6 tree, as of today:
>>
>> Applying: crypto: talitos - Implementation of SEC1
>> error: patch failed: drivers/crypto/talitos.c:655
>> error: drivers/crypto/talitos.c: patch does not apply
> Also the patches are coming in a random order.  Please send them
> one at a time to ensure proper ordering.
>
> Thanks,
Kim, I have now tried on top of cryptodev-2.6 tree, and for me it works 
(see below).
Do I clone cryptodev-2.6 from the wrong place ?
On that clone, the latest commit on talitos.c is commit 
5be4d4c94b1f98b839344fda7a8752a4a09d0ef5 "crypto: replace 
scatterwalk_sg_next with sg_next"

[root@localhost ~]# git clone 
https://www.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
Cloning into 'cryptodev-2.6'...
remote: Counting objects: 4043448, done.
remote: Compressing objects: 100% (682829/682829), done.
Receiving objects: 100% (4043448/4043448), 893.52 MiB | 258.00 KiB/s, done.
remote: Total 4043448 (delta 3330215), reused 4043104 (delta 3329977)
Resolving deltas: 100% (3330215/3330215), done.
Checking connectivity... done.
Checking out files: 100% (48971/48971), done.
[root@localhost ~]# cd cryptodev-2.6/
[root@localhost cryptodev-2.6]# git branch test
[root@localhost cryptodev-2.6]# git checkout test
Switched to branch 'test'
[root@localhost cryptodev-2.6]# git am 
/root/gen/trunk/submitted_patches/talitos/0*
Applying: crypto: talitos - base address for Execution Units and macro 
for ISR masks
Applying: crypto: talitos - Externalise specific SEC2 reset actions
Applying: crypto: talitos - Use zero entry to init descriptors ptrs to zero
Applying: crypto: talitos - Refactor the sg in/out chain allocation
Applying: crypto: talitos - isolate scatter/gather handling for ahash
Applying: crypto: talitos - Add talitos2.c to isolate SEC2 specific 
functions
Applying: crypto: talitos - Split talitos.h into 2 parts
Applying: crypto: talitos - Deport SEC2 error handling
Applying: crypto: talitos - Move reset/init helpers into talitos2.h
Applying: crypto: talitos - Move interrupt related macros in talitos2.h
Applying: crypto: talitos - Move hash chain handling into talitos2.h
Applying: crypto: talitos - Define compatible in talitos2.h instead of 
talitos.c
Applying: crypto: talitos - move sg_count() helper into talitos.h
Applying: crypto: talitos - Add a helper function to clear j_extent field
Applying: crypto: talitos - Implementation of SEC1
Applying: crypto: talitos - SEC1 bugs on 0 data hash
Applying: crypto: talitos - Update DT bindings with SEC1
[root@localhost cryptodev-2.6]#
