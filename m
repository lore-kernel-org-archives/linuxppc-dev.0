Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 008F5DDEEC
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 07:15:54 +1000 (EST)
Received: by gxk1 with SMTP id 1so4885030gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 14:15:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40904172235u2e39f52jee3f7274cd4bd00b@mail.gmail.com>
References: <49E81CED.1000704@monstr.eu>
	<fa686aa40904162344y67115e50lf48c174501120b30@mail.gmail.com>
	<49E87D25.8090001@monstr.eu>
	<Pine.LNX.4.64.0904171601020.10088@wrl-59.cs.helsinki.fi>
	<Pine.LNX.4.64.0904180057290.2522@wrl-59.cs.helsinki.fi>
	<fa686aa40904172235u2e39f52jee3f7274cd4bd00b@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 20 Apr 2009 15:15:23 -0600
Message-ID: <fa686aa40904201415y5edf47dcm10e2007f9276b544@mail.gmail.com>
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

On Fri, Apr 17, 2009 at 11:35 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Fri, Apr 17, 2009 at 4:07 PM, Ilpo J=E4rvinen
>> [PATCH] powerpc & microblaze: add missing of_node_put to error handling
>>
>> While reviewing some microblaze patches a while ago, I noticed
>> a suspicious error handling in of_irq_map_one(), which turned
>> out to be a copy from arch/powerpc. Grant Likely
>> <grant.likely@secretlab.ca> confirmed that this is a real bug.
>>
>> Merge error handling paths using goto with the normal return
>> path.
>>
>> Powerppc compile tested.
>>
>> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>
>
> Looks right to me (but I haven't tested).
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

I've picked up the powerpc half of this patch, tested it, and pushed
it out to my -next tree and asked Ben or Paul to pull.

Michal, I leave it to you to pick up the Microblaze half.

Cheers,
g.


>
>> ---
>> =A0arch/microblaze/kernel/prom_parse.c | =A0 11 +++++------
>> =A0arch/powerpc/kernel/prom_parse.c =A0 =A0| =A0 11 +++++------
>> =A02 files changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kerne=
l/prom_parse.c
>> index ae0352e..d16c32f 100644
>> --- a/arch/microblaze/kernel/prom_parse.c
>> +++ b/arch/microblaze/kernel/prom_parse.c
>> @@ -903,7 +903,7 @@ int of_irq_map_one(struct device_node *device,
>> =A0 =A0 =A0 =A0struct device_node *p;
>> =A0 =A0 =A0 =A0const u32 *intspec, *tmp, *addr;
>> =A0 =A0 =A0 =A0u32 intsize, intlen;
>> - =A0 =A0 =A0 int res;
>> + =A0 =A0 =A0 int res =3D -EINVAL;
>>
>> =A0 =A0 =A0 =A0pr_debug("of_irq_map_one: dev=3D%s, index=3D%d\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device->full_name, index)=
;
>> @@ -926,21 +926,20 @@ int of_irq_map_one(struct device_node *device,
>>
>> =A0 =A0 =A0 =A0/* Get size of interrupt specifier */
>> =A0 =A0 =A0 =A0tmp =3D of_get_property(p, "#interrupt-cells", NULL);
>> - =A0 =A0 =A0 if (tmp =3D=3D NULL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(p);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (tmp =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 =A0intsize =3D *tmp;
>>
>> =A0 =A0 =A0 =A0pr_debug(" intsize=3D%d intlen=3D%d\n", intsize, intlen);
>>
>> =A0 =A0 =A0 =A0/* Check index */
>> =A0 =A0 =A0 =A0if ((index + 1) * intsize > intlen)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> =A0 =A0 =A0 =A0/* Get new specifier and map it */
>> =A0 =A0 =A0 =A0res =3D of_irq_map_raw(p, intspec + index * intsize, ints=
ize,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0addr, out=
_irq);
>> +out:
>> =A0 =A0 =A0 =A0of_node_put(p);
>> =A0 =A0 =A0 =A0return res;
>> =A0}
>> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom=
_parse.c
>> index 8f0856f..8362620 100644
>> --- a/arch/powerpc/kernel/prom_parse.c
>> +++ b/arch/powerpc/kernel/prom_parse.c
>> @@ -971,7 +971,7 @@ int of_irq_map_one(struct device_node *device, int i=
ndex, struct of_irq *out_irq
>> =A0 =A0 =A0 =A0struct device_node *p;
>> =A0 =A0 =A0 =A0const u32 *intspec, *tmp, *addr;
>> =A0 =A0 =A0 =A0u32 intsize, intlen;
>> - =A0 =A0 =A0 int res;
>> + =A0 =A0 =A0 int res =3D -EINVAL;
>>
>> =A0 =A0 =A0 =A0DBG("of_irq_map_one: dev=3D%s, index=3D%d\n", device->ful=
l_name, index);
>>
>> @@ -995,21 +995,20 @@ int of_irq_map_one(struct device_node *device, int=
 index, struct of_irq *out_irq
>>
>> =A0 =A0 =A0 =A0/* Get size of interrupt specifier */
>> =A0 =A0 =A0 =A0tmp =3D of_get_property(p, "#interrupt-cells", NULL);
>> - =A0 =A0 =A0 if (tmp =3D=3D NULL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(p);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (tmp =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 =A0intsize =3D *tmp;
>>
>> =A0 =A0 =A0 =A0DBG(" intsize=3D%d intlen=3D%d\n", intsize, intlen);
>>
>> =A0 =A0 =A0 =A0/* Check index */
>> =A0 =A0 =A0 =A0if ((index + 1) * intsize > intlen)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> =A0 =A0 =A0 =A0/* Get new specifier and map it */
>> =A0 =A0 =A0 =A0res =3D of_irq_map_raw(p, intspec + index * intsize, ints=
ize,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr, out_irq);
>> +out:
>> =A0 =A0 =A0 =A0of_node_put(p);
>> =A0 =A0 =A0 =A0return res;
>> =A0}
>> --
>> 1.5.6.5
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
