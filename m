Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] drivers/serial/ucc_uart.c: Add of_node_put to avoid
	memory leak
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1283269738-14612-2-git-send-email-julia@diku.dk>
Date: Tue, 15 Mar 2011 10:51:23 -0500
Message-Id: <2452483F-04B7-4B44-B59D-94A9D18F5DA4@kernel.crashing.org>
References: <1283269738-14612-1-git-send-email-julia@diku.dk>
	<1283269738-14612-2-git-send-email-julia@diku.dk>
To: Julia Lawall <julia@diku.dk>
Cc: kernel-janitors@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 31, 2010, at 10:48 AM, Julia Lawall wrote:

> Add a call to of_node_put in the error handling code following a call =
to
> of_find_compatible_node or of_find_node_by_type.
>=20
> This patch also substantially reorganizes the error handling code in =
the
> function, to that it is possible first to jump to code that frees =
qe_port
> and then to jump to code that also puts np.
>=20
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @r exists@
> local idexpression x;
> expression E,E1,E2;
> statement S;
> @@
>=20
> *x =3D=20
> (of_find_node_by_path
> |of_find_node_by_name
> |of_find_node_by_phandle
> |of_get_parent
> |of_get_next_parent
> |of_get_next_child
> |of_find_compatible_node
> |of_match_node
> |of_find_node_by_type
> |of_find_node_with_property
> |of_find_matching_node
> |of_parse_phandle
> )(...);
> ...
> if (x =3D=3D NULL) S
> <... when !=3D x =3D E
> *if (...) {
>  ... when !=3D of_node_put(x)
>      when !=3D if (...) { ... of_node_put(x); ... }
> (
>  return <+...x...+>;
> |
> *  return ...;
> )
> }
> ...>
> (
> E2 =3D x;
> |
> of_node_put(x);
> )
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <julia@diku.dk>
>=20
> ---
> drivers/serial/ucc_uart.c |   67 =
++++++++++++++++++++++++----------------------
> 1 file changed, 35 insertions(+), 32 deletions(-)

applied

- k=
