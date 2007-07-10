Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95FA4DDEE6
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 23:11:28 +1000 (EST)
In-Reply-To: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B6D787C6-6EA9-4866-AC3F-EB75F6D433F6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Date: Tue, 10 Jul 2007 15:11:16 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> In older versions of glibc (through 2.3), the dynamic linker  
> executes a
> small amount of code from the data segment, which is not marked as
> executable.  A recent change (commit  
> 9ba4ace39fdfe22268daca9f28c5df384ae462cf)
> stops this from working; there should be a deprecation period before
> older glibc versions stop working.
>
> The problem has been observed on glibc 2.2.  While glibc 2.3 has  
> the same
> code, I did not see the problem; it may be that it accesses the  
> page in
> question as data before executing from it, and thus it is already  
> mapped.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

> Unfortunately, this didn't make it into 2.6.22, but it should  
> probably go
> into the stable branch...

Both .21.x and .22.x I suppose; if we care about glibc 2.2.x
at all still, that is.

So to make double sure, this doesn't warn on glibc 2.3.x?


Segher
