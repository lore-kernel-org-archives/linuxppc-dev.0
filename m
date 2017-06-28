Return-Path: <axboe@kernel.dk>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyMst64mSzDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 22:43:46 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id q86so32957617pfl.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 05:43:46 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <20170628180456.30cb9242@canb.auug.org.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <664cc88d-18a5-18c4-5bce-4d4352d15f4f@kernel.dk>
Date: Wed, 28 Jun 2017 06:43:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170628180456.30cb9242@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/28/2017 02:04 AM, Stephen Rothwell wrote:
> Hi Jens,
> 
> After merging the block tree, today's linux-next build (powerpc
> allnoconfig) failed like this:
> 
> fs/fcntl.o: In function `do_fcntl': 
> fcntl.c:(.text+0x6d4): undefined reference to `__get_user_bad'
> fcntl.c:(.text+0x730): undefined reference to `__get_user_bad'
> 
> Probably caused by commit
> 
>   c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
> 
> On powerpc (at least) you cannot use get_user() to fetch anything larger
> than "unsigned long" i.e. 32 bits on 32 bit powerpc.
> 
> This has been discussed before (and, I think, a fix attempted).

Gah, thanks for letting me know. I'll test your patch and queue it
up to fix this issue.

-- 
Jens Axboe
