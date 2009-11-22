Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 2D5BE10080F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:37:15 +1100 (EST)
Received: by ywh17 with SMTP id 17so4648896ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:37:14 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:36:54 -0700
Message-ID: <fa686aa40911221536pf558b1fte36dc88bdf58e883@mail.gmail.com>
Subject: Re: [RFC PATCH 14/19] powerpc: allow ioremap within reserved fake ram
	regions
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> The Nintendo Wii has two discontiguous RAM memory areas called
> MEM1 and MEM2.
> MEM1 starts at 0x00000000 and contains 24MB of 1T-SRAM.
> MEM2 starts at 0x10000000 and contains 64MB of DDR2 RAM.
> Between both memory address ranges there is an address space
> where memory-mapped I/O registers are found.
>
> Currently, Linux 32-bit PowerPC does not support RAM in
> discontiguous memory address spaces. Thus, in order to use
> both RAM areas, we declare as RAM the range from the start of
> MEM1 to the end of useable MEM2 and exclude the needed parts
> with /memreserve/ statements, at the expense of wasting a bit
> of memory.
>
> As a side effect, we need to allow ioremapping RAM areas
> because the I/O address space sits within the memreserve'd part
> of the declared RAM region.
> Note that this is not safe if the region ioremapped is covered
> by an existing BAT mapping used to map RAM, so this is
> specifically banned here.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> ---
> =A0arch/powerpc/mm/pgtable_32.c | =A0 19 ++++++++++++++++---
> =A01 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index cb96cb2..ba00cb1 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -191,9 +191,22 @@ __ioremap_caller(phys_addr_t addr, unsigned long siz=
e, unsigned long flags,
> =A0 =A0 =A0 =A0 * Don't allow anybody to remap normal RAM that we're usin=
g.
> =A0 =A0 =A0 =A0 * mem_init() sets high_memory so only do the check after =
that.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (mem_init_done && (p < virt_to_phys(high_memory))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("__ioremap(): phys addr 0x%llx is RA=
M lr %p\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)p, __bui=
ltin_return_address(0));
> + =A0 =A0 =A0 if (mem_init_done && (p < virt_to_phys(high_memory))
> +#ifdef CONFIG_WII
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* On some systems, though, we may want t=
o remap an area
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* declared as normal RAM that we have me=
mreserve'd at the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* device tree. See wii.dts.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* But we can't do that safely if we are =
using BATs to map
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* part of that area.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 && !__map_without_bats
> +#endif
> + =A0 =A0 =A0 =A0 =A0 ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"__ioremap(): phys addr 0x%l=
lx is RAM lr %p\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)p,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__builtin_return_address=
(0));

This could adversely affect multiplatform kernels.  I'd rather get the
RAM problem fixed and not hack up common code to work around the hack.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
