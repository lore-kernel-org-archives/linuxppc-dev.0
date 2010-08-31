Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc/platforms/83xx/mpc837x_mds.c: Add missing
	iounmap
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1283111238-3129-1-git-send-email-julia@diku.dk>
Date: Tue, 31 Aug 2010 16:39:11 -0500
Message-Id: <D97B05D5-3ABF-4B47-97C7-A3EC629A1987@kernel.crashing.org>
References: <1283111238-3129-1-git-send-email-julia@diku.dk>
To: Julia Lawall <julia@diku.dk>
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 29, 2010, at 2:47 PM, Julia Lawall wrote:

> The function of_iomap returns the result of calling ioremap, so iounmap
> should be called on the result in the error handling code, as done in the
> normal exit of the function.
> 
> The sematic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r exists@
> local idexpression x;
> expression E,E1;
> identifier l;
> statement S;
> @@
> 
> *x = of_iomap(...);
> ...  when != iounmap(x)
>     when != if (...) { ... iounmap(x); ... }
>     when != E = x
>     when any
> (
> if (x == NULL) S
> |
> if (...) {
>  ... when != iounmap(x)
>      when != if (...) { ... iounmap(x); ... }
> (
>  return <+...x...+>;
> |
> *  return ...;
> )
> }
> )
> ... when != x = E1
>    when any
> iounmap(x);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
> arch/powerpc/platforms/83xx/mpc837x_mds.c |    9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)

applied to merge

- k
