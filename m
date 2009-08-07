Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9358CB7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:27:11 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F00FEDDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:27:10 +1000 (EST)
Message-Id: <FD045DD8-3932-4BA0-9AB9-C2405F601C45@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Julia Lawall <julia@diku.dk>
In-Reply-To: <Pine.LNX.4.64.0908062203380.19100@ask.diku.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 1/3] arch/powerpc: Add kmalloc NULL tests
Date: Thu, 6 Aug 2009 21:26:59 -0500
References: <Pine.LNX.4.64.0908062203380.19100@ask.diku.dk>
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


On Aug 6, 2009, at 3:04 PM, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
>
> Check that the result of kmalloc/kzalloc is not NULL before  
> dereferencing it.
>
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> expression *x;
> identifier f;
> constant char *C;
> @@
>
> x = \(kmalloc\|kcalloc\|kzalloc\)(...);
> ... when != x == NULL
>    when != x != NULL
>    when != (x || ...)
> (
> kfree(x)
> |
> f(...,C,...,x,...)
> |
> *f(...,x,...)
> |
> *x->f
> )
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>
>
> ---
> arch/powerpc/sysdev/fsl_rio.c       |   18 ++++++++++++++----
> 1 files changed, 14 insertions(+), 4 deletions(-)


applied to next

- k
