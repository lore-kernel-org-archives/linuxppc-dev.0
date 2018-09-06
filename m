Return-Path: <groeck7@gmail.com>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425M7r6HChzF3Cj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 10:36:24 +1000 (AEST)
Received: by mail-pl1-f195.google.com with SMTP id e11-v6so4091933plb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 17:36:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by demand
 based pte insertion
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
References: <20180828112034.30875-1-npiggin@gmail.com>
 <20180828112034.30875-4-npiggin@gmail.com>
 <20180905142951.GA15680@roeck-us.net>
 <20180906081802.210984d7@roar.ozlabs.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c4ca50a2-5f85-84bb-65e7-79621f5b4c0a@roeck-us.net>
Date: Wed, 5 Sep 2018 17:36:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180906081802.210984d7@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/05/2018 03:18 PM, Nicholas Piggin wrote:
> On Wed, 5 Sep 2018 07:29:51 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Hi,
>>
>> On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:
>>> Similarly to the previous patch, this tries to optimise dirty/accessed
>>> bits in ptes to avoid access costs of hardware setting them.
>>>    
>>
>> This patch results in silent nios2 boot failures, silent meaning that
>> the boot stalls.
>>
>> ...
>> Unpacking initramfs...
>> Freeing initrd memory: 2168K
>> workingset: timestamp_bits=30 max_order=15 bucket_order=0
>> jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
>> random: fast init done
>> random: crng init done
>>
>> [no further activity until the qemu session is aborted]
>>
>> Reverting the patch fixes the problem. Bisect log is attached.
> 
> Thanks for bisecting it, I'll try to reproduce. Just qemu with no
> obscure options? Interesting that it's hit nios2 but apparently not
> other archs (yet).
> 

Nothing special. See https://github.com/groeck/linux-build-test/tree/master/rootfs/nios2/.

Guenter
