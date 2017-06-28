Return-Path: <axboe@kernel.dk>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyPbV3rJhzDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 00:01:26 +1000 (AEST)
Received: by mail-pf0-x22c.google.com with SMTP id e7so34061023pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 07:01:26 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
From: Jens Axboe <axboe@kernel.dk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <20170628180456.30cb9242@canb.auug.org.au>
 <664cc88d-18a5-18c4-5bce-4d4352d15f4f@kernel.dk>
Message-ID: <2bd17edb-4a5b-5bf8-7074-1156a5249325@kernel.dk>
Date: Wed, 28 Jun 2017 08:01:20 -0600
MIME-Version: 1.0
In-Reply-To: <664cc88d-18a5-18c4-5bce-4d4352d15f4f@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/28/2017 06:43 AM, Jens Axboe wrote:
> On 06/28/2017 02:04 AM, Stephen Rothwell wrote:
>> Hi Jens,
>>
>> After merging the block tree, today's linux-next build (powerpc
>> allnoconfig) failed like this:
>>
>> fs/fcntl.o: In function `do_fcntl': 
>> fcntl.c:(.text+0x6d4): undefined reference to `__get_user_bad'
>> fcntl.c:(.text+0x730): undefined reference to `__get_user_bad'
>>
>> Probably caused by commit
>>
>>   c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
>>
>> On powerpc (at least) you cannot use get_user() to fetch anything larger
>> than "unsigned long" i.e. 32 bits on 32 bit powerpc.
>>
>> This has been discussed before (and, I think, a fix attempted).
> 
> Gah, thanks for letting me know. I'll test your patch and queue it
> up to fix this issue.

But put_user() is fine? Just checking here, since the change adds
both a u64 put and get user.

-- 
Jens Axboe
