Return-Path: <jeffm@suse.de>
Received: from locomotive.unixthugs.org (locomotive.csh.rit.edu
	[129.21.60.149]) by ozlabs.org (Postfix) with ESMTP id 1E62667A2E
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2005 07:55:03 +1000 (EST)
Message-ID: <426EB698.9030108@suse.de>
Date: Tue, 26 Apr 2005 17:46:00 -0400
From: Jeff Mahoney <jeffm@suse.de>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
References: <20050426211019.GA11579@suse.de>
In-Reply-To: <20050426211019.GA11579@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] make gcc -O1 in fs/reiserfs optional
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> Jeff,
> 
> you added this EXTRA_CFLAGS= during 2.4 development, I think the broken
> compiler was gcc 3.2 on SLES8. Can we turn this -O1 into a .config
> option?

Hi Olaf -

Yeah, the initial problem was that the anti aliasing[*] code when -O2
was enabled was being way too cautious and ended up allocating something
like 6k on the stack in do_balance(). It was observable elsewhere, but
not so problematic.

My ppc box isn't booting right now. If you've verified that newer
versions of the compiler don't blow the stack in do_balance(), I'm not
opposed to it.

-Jeff

[*]: I think that's the right term - I'm not a compiler developer :)

-- 
Jeff Mahoney
SuSE Labs
