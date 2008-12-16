Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 87FA6DDF29
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 05:44:53 +1100 (EST)
Date: Tue, 16 Dec 2008 21:44:51 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/83xx: Fix few build errors with
	CONFIG_QUICC_ENGINE=n
Message-ID: <20081216184451.GA6959@oksana.dev.rtsoft.ru>
References: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
	<6C14C18C-D709-4E69-8B47-C8A13380D713@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <6C14C18C-D709-4E69-8B47-C8A13380D713@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 16, 2008 at 12:18:07PM -0600, Kumar Gala wrote:
[..]
>> This patch implements traditional way of !QE case handling.
>> Alternative version is coming (w/o ifdefs in the board files).
>>
>> p.s. I don't know if it is 2.6.28 material...
>
> what's the state of this patch vs the alternate version?

Pros of the alternative version:
- No #ifdefs in .c files.

Cons of the alternative version:
- For this code (assuming QE=n):
        if ((np = of_find_node_by_name(NULL, "par_io")) != NULL)
		par_io_init(np);

  GCC can still issue the of_find_node_by_name() call. (I wonder if
  there is any way to tell gcc that particular function doesn't
  produce any side-effects so that gcc can optimize it away too).

It's up to you to decide which version you want to merge.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
