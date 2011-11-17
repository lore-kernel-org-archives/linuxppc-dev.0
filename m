Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id 36224B7266
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 08:12:10 +1100 (EST)
Date: Fri, 18 Nov 2011 08:12:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 3/4] poewrpc/83xx: headers cleanup
Message-Id: <20111118081200.ad9f082c24fed9268b4bdcee@canb.auug.org.au>
In-Reply-To: <1321541330-2330-3-git-send-email-dbaryshkov@gmail.com>
References: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
 <1321541330-2330-3-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__18_Nov_2011_08_12_00_+1100_MeLMAq0FdoRc9=9Z"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__18_Nov_2011_08_12_00_+1100_MeLMAq0FdoRc9=9Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Thu, 17 Nov 2011 18:48:49 +0400 Dmitry Eremin-Solenikov <dbaryshkov@gmai=
l.com> wrote:
>
> Drop lots of unused headers after board files merge/splitup

Please inly drop include files if nothing in them is actually used.  You
need to do this by inspection, not by compilation testing.  The problem
is that indirect inclusions change over time and also depending on what
CONFIG options are selected.  Just a few examples below ...

> diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platform=
s/83xx/km83xx.c
> index 65eb792..3b29e35 100644
> --- a/arch/powerpc/platforms/83xx/km83xx.c
> +++ b/arch/powerpc/platforms/83xx/km83xx.c
> @@ -11,35 +11,9 @@
>   * option) any later version.
>   */
> =20
> -#include <linux/stddef.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/errno.h>
> -#include <linux/reboot.h>
> -#include <linux/pci.h>
> -#include <linux/kdev_t.h>
> -#include <linux/major.h>
> -#include <linux/console.h>
> -#include <linux/delay.h>
> -#include <linux/seq_file.h>
> -#include <linux/root_dev.h>
> -#include <linux/initrd.h>
> -#include <linux/of_platform.h>
> -#include <linux/of_device.h>

Where is this file going to get its definition of "struct device_node" or
"of_find_node_by_name"?

> -#include <asm/system.h>

> -#include <linux/atomic.h>
> -#include <asm/time.h>
> -#include <asm/io.h>
> -#include <asm/machdep.h>

or "ppc_md" or "define_machine"?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__18_Nov_2011_08_12_00_+1100_MeLMAq0FdoRc9=9Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOxXigAAoJEECxmPOUX5FEpAEP/iwzIVAPo0dXRr1QBaz5Swj5
gJtZ0/P6mabBot1IjdQUGhZRN+aKubK28+DBy9Rl7ltkeC7KnUuDaq7uh5fypRC6
ydjN7mgNUiq8ucXcY6AR/N/rPquNtY51lZ0NhqW+MVsyqIbZMTytFUES646np4kU
ojc6kEylQmb+XYDOINNSY+JPogdIV/zrmfM8kzuLtLZ6ot+EgTz8Re5rqd/3l8xl
4NBq5TBLEqWaN0JLbiNiDnVmweX1VRq0+/ks0yi+zev7WgLQdxC9ZBZNR/DiOYSE
vtB48E1U4E+EVeC40oRbfsdaldlBTzqdX6Zx8K6pIvPcconIzUOIqkBfEqxyvmVM
oj0Pn87SHzgyIIqUfYnWw1mFoQ+pumKzzpoN5jN5u8nJtwtKS1Twx3ZsVftywsO0
yOocYHVbQtURz8T+9uZfAjTXzE33iX1Jcx72JFvX061nIZ6AajuHb0EYPE+iCTgi
DmG2oFzFwM9WkXuzzBrz4eutzg+WVrVnC93RuGwDpjZMCv9nvJTpmD9cxeSjTRjL
kJyuOY57Z4vhVYpL1hky35SQUJTq0EZYieMVn7gBxcXiVWYJViXJvYbiTIhLBlmk
gcWTj9PeL4QTEFEqERst/Nfog+vZmnB3mLUqnUFTa0MPokuULwePr5rRjlNzt9tZ
ndQTnpR8ep2aRKZEqXSf
=eyCa
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Nov_2011_08_12_00_+1100_MeLMAq0FdoRc9=9Z--
