Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9B758B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:26:49 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F19CDDDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:26:48 +1000 (EST)
Message-Id: <44DC26BA-29CF-4DBA-8D9F-1AB950F8B861@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Julia Lawall <julia@diku.dk>
In-Reply-To: <Pine.LNX.4.64.0908021044330.15557@ask.diku.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 2/10] arch/powerpc: introduce missing kfree
Date: Thu, 6 Aug 2009 21:26:38 -0500
References: <Pine.LNX.4.64.0908021044330.15557@ask.diku.dk>
Cc: kernel-janitors@vger.kernel.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 2, 2009, at 3:44 AM, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
>
> Error handling code following a kzalloc should free the allocated  
> data.
>
> The semantic match that finds the problem is as follows:
> (http://www.emn.fr/x-info/coccinelle/)
>
> // <smpl>
> @r exists@
> local idexpression x;
> statement S;
> expression E;
> identifier f,f1,l;
> position p1,p2;
> expression *ptr != NULL;
> @@
>
> x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
> ...
> if (x == NULL) S
> <... when != x
>     when != if (...) { <+...x...+> }
> (
> x->f1 = E
> |
> (x->f1 == NULL || ...)
> |
> f(...,x->f1,...)
> )
> ...>
> (
> return \(0\|<+...x...+>\|ptr\);
> |
> return@p2 ...;
> )
>
> @script:python@
> p1 << r.p1;
> p2 << r.p2;
> @@
>
> print "* file: %s kmalloc %s return %s" %  
> (p1[0].file,p1[0].line,p2[0].line)
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>
> ---
> arch/powerpc/sysdev/ipic.c          |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)


applied to next

- k
