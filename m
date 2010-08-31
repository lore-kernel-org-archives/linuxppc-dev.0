Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/7] arch/powerpc/sysdev/qe_lib/qe.c: Add of_node_put to
	avoid memory leak
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1283075566-27441-6-git-send-email-julia@diku.dk>
Date: Tue, 31 Aug 2010 16:41:24 -0500
Message-Id: <7C2AF4A1-A33B-4D1F-859A-BCB48738D9D1@kernel.crashing.org>
References: <1283075566-27441-1-git-send-email-julia@diku.dk>
	<1283075566-27441-6-git-send-email-julia@diku.dk>
To: Julia Lawall <julia@diku.dk>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org,
	Timur Tabi <timur@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 29, 2010, at 4:52 AM, Julia Lawall wrote:

> Add a call to of_node_put in the error handling code following a call to
> of_find_compatible_node.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r exists@
> local idexpression x;
> expression E,E1;
> statement S;
> @@
> 
> *x = 
> (of_find_node_by_path
> |of_find_node_by_name
> |of_find_node_by_phandle
> |of_get_parent
> |of_get_next_parent
> |of_get_next_child
> |of_find_compatible_node
> |of_match_node
> )(...);
> ...
> if (x == NULL) S
> <... when != x = E
> *if (...) {
>  ... when != of_node_put(x)
>      when != if (...) { ... of_node_put(x); ... }
> (
>  return <+...x...+>;
> |
> *  return ...;
> )
> }
> ...>
> of_node_put(x);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
> arch/powerpc/sysdev/qe_lib/qe.c |    1 +
> 1 file changed, 1 insertion(+)

applied to merge

- k
