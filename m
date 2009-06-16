Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 339D0B710D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 02:39:58 +1000 (EST)
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 2E847DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 02:39:56 +1000 (EST)
Received: by yxe8 with SMTP id 8so3475574yxe.9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 09:39:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1245048902.19217.47.camel@pasglop>
References: <20090527185422.15186.46133.stgit@localhost.localdomain>
	<1245048902.19217.47.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Jun 2009 10:39:34 -0600
Message-ID: <fa686aa40906160939u731341b4p6fae735c7102c717@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: add ioremap_early() for mapping IO regions
	before MMU_init()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 15, 2009 at 12:55 AM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> On Wed, 2009-05-27 at 12:55 -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> ioremap_early() is useful for things like mapping SoC internally registe=
rs
>> and early debug output because it allows mappings to devices to be setup
>> early in the boot process where they are needed. =A0It also give a
>> performance boost since BAT mapped registers don't get flushed out of
>> the TLB.
>>
>> Without ioremap_early(), early mappings are set up in an ad-hoc manner
>> and they get lost when the MMU is set up. =A0Drivers then have to perfor=
m
>> hacky fixups to transition over to new mappings.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>
> Approach looks sane at first glance.
>
> However, I'm reluctant to but that in until we have all MMU types
> covered or we'll have "interesting" surprises.

I considered this and was originally concerned about the same thing.
However, ioremap_early() is special in that caller cannot take for
granted what it does and must understand the side effects.  For
example; on 6xx ioremap_early is always going to carve out a minimum
of 128k from the virtual address space and it is likely that the range
will extend both both before and after the desired address.  Plus,
because of the limited number of BATs there is real likelyhood that
ioremap_early() will fail.  Code calling it must handle the failure
mode gracefully.

IMHO, I think this is only really applicable for platform code that
understands the memory layout.  ie. map the entire IMMR at once, or
mapping local bus device ranges.  On the 5200 I call it early in the
platform setup on the IMMR range, but I don't actually do anything
with the returned value (unless I'm doing udbg).  Then, future
ioremap() calls to that range get to use the BAT mapping
transparently.

On the 440 and the 405 with the small TLB users also need to be
careful so that too many TLB entries don't get pinned to static
allocation and negate the performance improvement of doing the pinning
in the first place.  Again I think it is best restricted to platform
code, and should never cause the system to fail to boot if the mapping
doesn't work.

I do want to implement it for all MMUs (when I have the bandwidth to
do so), but I don't think merging it needs to wait.  If it is merged
as is and someone uses it in the wrong place (ie. non-platform code),
then 405 and 440 will fail to build, and it will get caught quickly.
Alternately I could implement stub ioremap_early() for non-6xx to just
return NULL until it can be implemented.  Callers who don't handle
NULL gracefully are broken, but it won't be known until boot time.

> Also, the CPM patch
> doesn't actually fix the massive bogon in there :-)

Yeah, that was just to get it to build.  I'll look at fix that too.

>> + =A0 =A0 /* Be loud and annoying if someone calls this too late.
>> + =A0 =A0 =A0* No need to crash the kernel though */
>> + =A0 =A0 WARN_ON(mem_init_done);
>> + =A0 =A0 if (mem_init_done)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>
> Can't we write
>
> =A0 =A0 =A0 =A0if (WARN_ON(mem_init_done))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> nowadays ?

I'll check.

>> + =A0 =A0 /* Make sure request is sane */
>> + =A0 =A0 if (size =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> +
>> + =A0 =A0 /* If the region is already block mapped, then there is nothin=
g
>> + =A0 =A0 =A0* to do; just return the mapped address */
>> + =A0 =A0 v =3D p_mapped_by_bats(addr);
>> + =A0 =A0 if (v)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return (void __iomem *)v;
>
> Should we check the size ?

Ugh.  Yes.  good catch.

>> + =A0 =A0 /* Align region size */
>> + =A0 =A0 for (bl =3D 128<<10; bl < (256<<20); bl <<=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 p =3D _ALIGN_DOWN(addr, bl); /* BATs align on =
128k boundaries */
>> + =A0 =A0 =A0 =A0 =A0 =A0 size =3D ALIGN(addr - p + size, bl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bl >=3D size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Complain loudly if too much is requested */
>> + =A0 =A0 if (bl >=3D (256<<20)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>
> Do we avoid that running into the linear mapping ?

No.  I'll fix.

>> + =A0 =A0 /* Allocate the aligned virtual base address. =A0ALIGN_DOWN is=
 used
>> + =A0 =A0 =A0* to ensure no overlaps occur with normal 4k ioremaps. */
>> + =A0 =A0 ioremap_bot =3D _ALIGN_DOWN(ioremap_bot, bl) - size;
>> +
>> + =A0 =A0 /* Set up a BAT for this IO region */
>> + =A0 =A0 i =3D loadbat(ioremap_bot, p, size, PAGE_KERNEL_NCG);
>> + =A0 =A0 if (i < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> +
>> + =A0 =A0 return (void __iomem *) (ioremap_bot + (addr - p));
>> =A0}
>>
>> =A0/*
>> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc=
/platforms/52xx/mpc52xx_common.c
>> index 8e3dd5a..2c49148 100644
>> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
>> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
>> @@ -146,7 +146,20 @@ static struct of_device_id mpc52xx_cdm_ids[] __init=
data =3D {
>> =A0void __init
>> =A0mpc52xx_map_common_devices(void)
>> =A0{
>> + =A0 =A0 const struct of_device_id immr_ids[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "fsl,mpc5200-immr", },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "fsl,mpc5200b-immr", },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { .type =3D "soc", .compatible =3D "mpc5200", =
}, /* lite5200 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 { .type =3D "builtin", .compatible =3D "mpc520=
0", }, /* efika */
>> + =A0 =A0 =A0 =A0 =A0 =A0 {}
>> + =A0 =A0 };
>> =A0 =A0 =A0 struct device_node *np;
>> + =A0 =A0 struct resource res;
>> +
>> + =A0 =A0 /* Pre-map the whole register space using a BAT entry */
>> + =A0 =A0 np =3D of_find_matching_node(NULL, immr_ids);
>> + =A0 =A0 if (np && (of_address_to_resource(np, 0, &res) =3D=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 ioremap_early(res.start, res.end - res.start +=
 1);
>>
>> =A0 =A0 =A0 /* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
>> =A0 =A0 =A0 =A0* possibly from a interrupt context. wdt is only implemen=
t
>> diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_=
common.c
>> index e4b6d66..370723e 100644
>> --- a/arch/powerpc/sysdev/cpm_common.c
>> +++ b/arch/powerpc/sysdev/cpm_common.c
>> @@ -56,7 +56,7 @@ void __init udbg_init_cpm(void)
>> =A0{
>> =A0 =A0 =A0 if (cpm_udbg_txdesc) {
>> =A0#ifdef CONFIG_CPM2
>> - =A0 =A0 =A0 =A0 =A0 =A0 setbat(1, 0xf0000000, 0xf0000000, 1024*1024, P=
AGE_KERNEL_NCG);
>> + =A0 =A0 =A0 =A0 =A0 =A0 setbat(0xf0000000, 0xf0000000, 1024*1024, PAGE=
_KERNEL_NCG);
>> =A0#endif
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 udbg_putc =3D udbg_putc_cpm;
>> =A0 =A0 =A0 }
>
> That needs to be properly fixed ... maybe using ioremap_early() ? :-)

:-p

> Also, make the initial call ioremap_early_init() just to make things
> clear that one can't just call ioremap(), we are limited to a very
> specific thing here.

ok.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
