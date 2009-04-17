Return-Path: <glikely@secretlab.ca>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id EA6CBDE0FB
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 16:44:32 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so781182qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 23:44:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49E81CED.1000704@monstr.eu>
References: <49E81CED.1000704@monstr.eu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Apr 2009 00:44:16 -0600
Message-ID: <fa686aa40904162344y67115e50lf48c174501120b30@mail.gmail.com>
Subject: Re: Proposed prom parse fix + moving.
To: monstr@monstr.eu
Content-Type: text/plain; charset=ISO-8859-1
Cc: ilpo.jarvinen@helsinki.fi, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 12:08 AM, Michal Simek <monstr@monstr.eu> wrote:
> Hi All,
>
> I have got email from Ilpo about prom_parse file.
> I take this file from powerpc. Who did write prom_parse file and take car=
e about?

Posting to the linuxppc-dev list is sufficient to start.  There are
several people who may be interested.

> BTW: What about to move prom_parse file to any generic location as we dis=
cussed in past?
> Any volunteer?

I'm kind of working on it.  More specifically, I'm looking at
factoring out fdt stuff into common code (drivers/of/of_fdt.c). But I
haven't made a whole lot of progress yet.

> -------- Original Message --------
> Subject: [RFC!] [PATCH] microblaze: fix bug in error handling
> Date: Thu, 16 Apr 2009 23:05:53 +0300 (EEST)
> From: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>
> To: monstr@monstr.eu
> CC: microblaze-uclinux@itee.uq.edu.au
>
> While some version of the patches were on the lkml I read
> some part of the code briefly through but my feedback got
> stuck into postponed emails, so here's one correctness
> related issue I might have found (the rest were just
> cosmetic things).
>
> I'm not sure if the latter return needs the of_node_put or not
> but it seems more likely than not.

Yes, it does.  This change is applicable to
arch/powerpc/kernel/prom_parse.c too.

>
> Not even compile tested.
>
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>
> ---
> =A0arch/microblaze/kernel/prom_parse.c | =A0 11 +++++++----
> =A01 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel=
/prom_parse.c
> index ae0352e..d1174bc 100644
> --- a/arch/microblaze/kernel/prom_parse.c
> +++ b/arch/microblaze/kernel/prom_parse.c
> @@ -927,20 +927,23 @@ int of_irq_map_one(struct device_node *device,
> =A0 =A0 =A0 =A0/* Get size of interrupt specifier */
> =A0 =A0 =A0 =A0tmp =3D of_get_property(p, "#interrupt-cells", NULL);
> =A0 =A0 =A0 =A0if (tmp =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(p);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0intsize =3D *tmp;
>
> =A0 =A0 =A0 =A0pr_debug(" intsize=3D%d intlen=3D%d\n", intsize, intlen);
>
> =A0 =A0 =A0 =A0/* Check index */
> - =A0 =A0 =A0 if ((index + 1) * intsize > intlen)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if ((index + 1) * intsize > intlen) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Get new specifier and map it */
> =A0 =A0 =A0 =A0res =3D of_irq_map_raw(p, intspec + index * intsize, intsi=
ze,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0addr, out_=
irq);
> +out:
> =A0 =A0 =A0 =A0of_node_put(p);
> =A0 =A0 =A0 =A0return res;
> =A0}
> --
> 1.5.6.5
>
>
> --
> Michal Simek, Ing. (M.Eng)
> w: www.monstr.eu p: +42-0-721842854
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
