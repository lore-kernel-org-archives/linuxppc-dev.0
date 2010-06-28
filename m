Return-Path: <kyle@moffetthome.net>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id D0049B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 03:06:19 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 19so744869fgg.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 10:06:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1277709539_13309@mail4.comsite.net>
References: <AANLkTikMtZsg5ameUY9dnZoEqV-hfa7tkfGIO1hBtDq1@mail.gmail.com>
	<1277709539_13309@mail4.comsite.net>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Mon, 28 Jun 2010 13:05:56 -0400
Message-ID: <AANLkTiliAex8bgu5UPrEwpVjgfwZHUuFbE2R199wow-H@mail.gmail.com>
Subject: Re: of-flash: Unable to ioremap() both 128MB NOR flashes on 32-bit
	system with 2GB+ RAM
To: Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 28, 2010 at 03:18, Milton Miller <miltonm@bga.com> wrote:
> On Fri Jun 25 around 14:01:51 EST 2010 Kyle Moffett wrote:
>> I've got a new P2020 (32bit mpc85xx family) board I'm working on a
>> port for that includes 2 NOR flashes (128MB each) and a removable
>> SO-RDIMM of 2GB or 4GB. =C2=A0Unfortunately when I configure both flashe=
s
>> in the device-tree off my elbc, Linux is completely unable to access
>> the second one because it attempts to ioremap() the entire virtual
>> address space of both FLASH chips.
>>
>> Even with only one flash chip enabled, there's a bit of a noticeable
>> performance degradation because the mapping consumes almost all of my
>> available vmalloc space and forces bounce-buffering for all my
>> HIGHMEM.
>>
>> It looks like the "of-flash" driver currently requires that the whole
>> chip be mapped in the kernel at once. =C2=A0I would much rather have a 5=
0%
>> performance penalty on flash accesses (which are already very slow)
>> and regain most of the vmap space.
>>
>> So the question is, is there a way to convince the MTD layer to
>> iomap() only what it needs to access to do reads and writes? =C2=A0If no=
t,
>> what changes would need to be made to MTD and/or "of-flash" to create
>> such functionality?
>
> I believe the MTD layer would be happy, but it is beyond the scope of
> the physmap_of driver.

Well, I believe that the physmap_of driver is the correct place for
it; that driver is used by a large number of embedded PPC systems and
at present it is completely unable to handle some of the larger flash
memories currently being produced (256MByte+), and there's a decent
system-wide performance penalty (due to lack of ioremap space) even
for the larger flash memories which do function.

Cheers,
Kyle Moffett
