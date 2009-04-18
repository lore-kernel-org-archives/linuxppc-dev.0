Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id BE000DDFB4
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 15:35:58 +1000 (EST)
Received: by gxk1 with SMTP id 1so2438525gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 22:35:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.0904180057290.2522@wrl-59.cs.helsinki.fi>
References: <49E81CED.1000704@monstr.eu>
	<fa686aa40904162344y67115e50lf48c174501120b30@mail.gmail.com>
	<49E87D25.8090001@monstr.eu>
	<Pine.LNX.4.64.0904171601020.10088@wrl-59.cs.helsinki.fi>
	<Pine.LNX.4.64.0904180057290.2522@wrl-59.cs.helsinki.fi>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Apr 2009 23:35:42 -0600
Message-ID: <fa686aa40904172235u2e39f52jee3f7274cd4bd00b@mail.gmail.com>
Subject: Re: Proposed prom parse fix + moving.
To: =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 4:07 PM, Ilpo J=E4rvinen
<ilpo.jarvinen@helsinki.fi> wrote:
> On Fri, 17 Apr 2009, Ilpo J=E4rvinen wrote:
>
>> On Fri, 17 Apr 2009, Michal Simek wrote:
>>
>> > Grant Likely wrote:
>> > > On Fri, Apr 17, 2009 at 12:08 AM, Michal Simek <monstr@monstr.eu> wr=
ote:
>> > >> Hi All,
>> > >>
>> > >> I have got email from Ilpo about prom_parse file.
>> > >> I take this file from powerpc. Who did write prom_parse file and ta=
ke care about?
>> > >
>> > > Posting to the linuxppc-dev list is sufficient to start. =A0There ar=
e
>> > > several people who may be interested.
>> > >
>> > >> BTW: What about to move prom_parse file to any generic location as =
we discussed in past?
>> > >> Any volunteer?
>> > >
>> > > I'm kind of working on it. =A0More specifically, I'm looking at
>> > > factoring out fdt stuff into common code (drivers/of/of_fdt.c). But =
I
>> > > haven't made a whole lot of progress yet.
>> > >
>> > >> -------- Original Message --------
>> > >> Subject: [RFC!] [PATCH] microblaze: fix bug in error handling
>> > >> Date: Thu, 16 Apr 2009 23:05:53 +0300 (EEST)
>> > >> From: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>
>> > >> To: monstr@monstr.eu
>> > >> CC: microblaze-uclinux@itee.uq.edu.au
>> > >>
>> > >> While some version of the patches were on the lkml I read
>> > >> some part of the code briefly through but my feedback got
>> > >> stuck into postponed emails, so here's one correctness
>> > >> related issue I might have found (the rest were just
>> > >> cosmetic things).
>> > >>
>> > >> I'm not sure if the latter return needs the of_node_put or not
>> > >> but it seems more likely than not.
>> > >
>> > > Yes, it does. =A0This change is applicable to
>> > > arch/powerpc/kernel/prom_parse.c too.
>> >
>> > ok.
>> > Ilpo: Can you create patch for both architectures?
>>
>> Sure, but tomorrow as today is a deadline day :-).
>
> Ok, here's combined patch for both. I came up with slightly
> shorter and (IMHO) nicer variant for -EINVAL assignment than
> in the first version.
>
> --
> [PATCH] powerpc & microblaze: add missing of_node_put to error handling
>
> While reviewing some microblaze patches a while ago, I noticed
> a suspicious error handling in of_irq_map_one(), which turned
> out to be a copy from arch/powerpc. Grant Likely
> <grant.likely@secretlab.ca> confirmed that this is a real bug.
>
> Merge error handling paths using goto with the normal return
> path.
>
> Powerppc compile tested.
>
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>

Looks right to me (but I haven't tested).

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/microblaze/kernel/prom_parse.c | =A0 11 +++++------
> =A0arch/powerpc/kernel/prom_parse.c =A0 =A0| =A0 11 +++++------
> =A02 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel=
/prom_parse.c
> index ae0352e..d16c32f 100644
> --- a/arch/microblaze/kernel/prom_parse.c
> +++ b/arch/microblaze/kernel/prom_parse.c
> @@ -903,7 +903,7 @@ int of_irq_map_one(struct device_node *device,
> =A0 =A0 =A0 =A0struct device_node *p;
> =A0 =A0 =A0 =A0const u32 *intspec, *tmp, *addr;
> =A0 =A0 =A0 =A0u32 intsize, intlen;
> - =A0 =A0 =A0 int res;
> + =A0 =A0 =A0 int res =3D -EINVAL;
>
> =A0 =A0 =A0 =A0pr_debug("of_irq_map_one: dev=3D%s, index=3D%d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device->full_name, index);
> @@ -926,21 +926,20 @@ int of_irq_map_one(struct device_node *device,
>
> =A0 =A0 =A0 =A0/* Get size of interrupt specifier */
> =A0 =A0 =A0 =A0tmp =3D of_get_property(p, "#interrupt-cells", NULL);
> - =A0 =A0 =A0 if (tmp =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(p);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (tmp =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0intsize =3D *tmp;
>
> =A0 =A0 =A0 =A0pr_debug(" intsize=3D%d intlen=3D%d\n", intsize, intlen);
>
> =A0 =A0 =A0 =A0/* Check index */
> =A0 =A0 =A0 =A0if ((index + 1) * intsize > intlen)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
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
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_=
parse.c
> index 8f0856f..8362620 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -971,7 +971,7 @@ int of_irq_map_one(struct device_node *device, int in=
dex, struct of_irq *out_irq
> =A0 =A0 =A0 =A0struct device_node *p;
> =A0 =A0 =A0 =A0const u32 *intspec, *tmp, *addr;
> =A0 =A0 =A0 =A0u32 intsize, intlen;
> - =A0 =A0 =A0 int res;
> + =A0 =A0 =A0 int res =3D -EINVAL;
>
> =A0 =A0 =A0 =A0DBG("of_irq_map_one: dev=3D%s, index=3D%d\n", device->full=
_name, index);
>
> @@ -995,21 +995,20 @@ int of_irq_map_one(struct device_node *device, int =
index, struct of_irq *out_irq
>
> =A0 =A0 =A0 =A0/* Get size of interrupt specifier */
> =A0 =A0 =A0 =A0tmp =3D of_get_property(p, "#interrupt-cells", NULL);
> - =A0 =A0 =A0 if (tmp =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(p);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (tmp =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0intsize =3D *tmp;
>
> =A0 =A0 =A0 =A0DBG(" intsize=3D%d intlen=3D%d\n", intsize, intlen);
>
> =A0 =A0 =A0 =A0/* Check index */
> =A0 =A0 =A0 =A0if ((index + 1) * intsize > intlen)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> =A0 =A0 =A0 =A0/* Get new specifier and map it */
> =A0 =A0 =A0 =A0res =3D of_irq_map_raw(p, intspec + index * intsize, intsi=
ze,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr, out_irq);
> +out:
> =A0 =A0 =A0 =A0of_node_put(p);
> =A0 =A0 =A0 =A0return res;
> =A0}
> --
> 1.5.6.5
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
