Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id E5C3CB7BDC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 07:41:46 +1100 (EST)
Received: by yxe9 with SMTP id 9so5767437yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 12:41:45 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B0AED90.6050600@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221536pf558b1fte36dc88bdf58e883@mail.gmail.com>
	<4B0AED90.6050600@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 23 Nov 2009 13:41:14 -0700
Message-ID: <fa686aa40911231241t5191c1bcs59787fa2635460a2@mail.gmail.com>
Subject: Re: [RFC PATCH 14/19] powerpc: allow ioremap within reserved fake ram
	regions
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Becky Bruce <Becky.Bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 23, 2009 at 1:16 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> Grant Likely wrote:
>> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es=
> wrote:
>>> The Nintendo Wii has two discontiguous RAM memory areas called
>>> MEM1 and MEM2.
>>> MEM1 starts at 0x00000000 and contains 24MB of 1T-SRAM.
>>> MEM2 starts at 0x10000000 and contains 64MB of DDR2 RAM.
>>> Between both memory address ranges there is an address space
>>> where memory-mapped I/O registers are found.
>>>
>>> Currently, Linux 32-bit PowerPC does not support RAM in
>>> discontiguous memory address spaces. Thus, in order to use
>>> both RAM areas, we declare as RAM the range from the start of
>>> MEM1 to the end of useable MEM2 and exclude the needed parts
>>> with /memreserve/ statements, at the expense of wasting a bit
>>> of memory.
>>>
>>> As a side effect, we need to allow ioremapping RAM areas
>>> because the I/O address space sits within the memreserve'd part
>>> of the declared RAM region.
>>> Note that this is not safe if the region ioremapped is covered
>>> by an existing BAT mapping used to map RAM, so this is
>>> specifically banned here.
>>>
>>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
>>> ---
>>> =A0arch/powerpc/mm/pgtable_32.c | =A0 19 ++++++++++++++++---
>>> =A01 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.=
c
>>> index cb96cb2..ba00cb1 100644
>>> --- a/arch/powerpc/mm/pgtable_32.c
>>> +++ b/arch/powerpc/mm/pgtable_32.c
>>> @@ -191,9 +191,22 @@ __ioremap_caller(phys_addr_t addr, unsigned long s=
ize, unsigned long flags,
>>> =A0 =A0 =A0 =A0 * Don't allow anybody to remap normal RAM that we're us=
ing.
>>> =A0 =A0 =A0 =A0 * mem_init() sets high_memory so only do the check afte=
r that.
>>> =A0 =A0 =A0 =A0 */
>>> - =A0 =A0 =A0 if (mem_init_done && (p < virt_to_phys(high_memory))) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("__ioremap(): phys addr 0x%llx is =
RAM lr %p\n",
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)p, __b=
uiltin_return_address(0));
>>> + =A0 =A0 =A0 if (mem_init_done && (p < virt_to_phys(high_memory))
>>> +#ifdef CONFIG_WII
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* On some systems, though, we may want=
 to remap an area
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* declared as normal RAM that we have =
memreserve'd at the
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* device tree. See wii.dts.
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* But we can't do that safely if we ar=
e using BATs to map
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* part of that area.
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 && !__map_without_bats
>>> +#endif
>>> + =A0 =A0 =A0 =A0 =A0 ) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"__ioremap(): phys addr 0x=
%llx is RAM lr %p\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)p,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__builtin_return_addre=
ss(0));
>>
>> This could adversely affect multiplatform kernels. =A0I'd rather get the
>> RAM problem fixed and not hack up common code to work around the hack.
>>
>> g.
>>
>
> Would it be acceptable to create a global var __allow_ioremap_normal_ram =
that by default would have a value of 0 and would be set _only_ for those p=
latforms needing it?

I'm not the best one to answer this since I don't dig into the mm code
very often.  Ben?  Kumar?  Becky?  Thoughts?

> The other solutions I see is:
> - add support for discontiguous memory to powerpc 32-bits (which is not s=
omething that I can look into now)

I of course like this option.  :-)

> - don't use the precious second 64MB area (which is a waste)

Not exactly nice, but it might be wise to do this now so that
discussion about how to fix it best won't block getting the bulk of
support into mainline.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
