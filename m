Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6B12DB6F8E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 12:48:19 +1100 (EST)
Subject: Re: [PATCH v2] Integrated Flash Controller support
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4ED5531C.6030104@freescale.com>
Date: Tue, 29 Nov 2011 19:47:46 -0600
Message-Id: <EFF451D9-552A-4820-90D3-BF3156D5B25F@kernel.crashing.org>
References: <1320053901-23801-1-git-send-email-b35362@freescale.com>
 <CCF7C6DB-437C-4140-894F-2F497AD610DC@kernel.crashing.org>
 <8EDB3DC6-63E5-4D5C-BB52-15F32B85C5DD@kernel.crashing.org>
 <1322602860.2150.10.camel@koala> <4ED5531C.6030104@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Artem.Bityutskiy@nokia.com, Li Yang-R58472 <r58472@freescale.com>,
 dedekind1@gmail.com,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "b35362@freescale.com>" <b35362@freescale.com>,
 "linux-kernel@vger.kernel.org Kernel" <linux-kernel@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 29, 2011, at 3:48 PM, Scott Wood wrote:

> On 11/29/2011 03:40 PM, Artem Bityutskiy wrote:
>> On Thu, 2011-11-24 at 08:24 -0600, Kumar Gala wrote:
>>> On Nov 22, 2011, at 9:41 PM, Kumar Gala wrote:
>>>=20
>>>>=20
>>>> On Oct 31, 2011, at 4:38 AM, <b35362@freescale.com> =
<b35362@freescale.com> wrote:
>>>>=20
>>>>> From: Liu Shuo <b35362@freescale.com>
>>>>>=20
>>>>> Integrated Flash Controller supports various flashes like NOR, =
NAND
>>>>> and other devices using NOR, NAND and GPCM Machine available on =
it.
>>>>> IFC supports four chip selects.
>>>>>=20
>>>>> Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
>>>>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>>> Signed-off-by: Liu Shuo <b35362@freescale.com>
>>>>> ---
>>>>> arch/powerpc/Kconfig               |    4 +
>>>>> arch/powerpc/include/asm/fsl_ifc.h |  834 =
++++++++++++++++++++++++++++++++++++
>>>>> arch/powerpc/sysdev/Makefile       |    1 +
>>>>> arch/powerpc/sysdev/fsl_ifc.c      |  322 ++++++++++++++
>>>>> 4 files changed, 1161 insertions(+), 0 deletions(-)
>>>>> create mode 100644 arch/powerpc/include/asm/fsl_ifc.h
>>>>> create mode 100644 arch/powerpc/sysdev/fsl_ifc.c
>>>>=20
>>>> Guys,
>>>>=20
>>>> How are we handling this patchset since it touches =
drivers/mtd/nand?
>>=20
>> I do not see it touching MTD from the diffstat above. I am a little =
bit
>> confused why a flash controller is added to
>> arch/powerpc/sysdev/fsl_ifc.c ?
>=20
> It's really a bus controller, with NOR, NAND, and general-purpose =
modes
> settable per chipselect.  The actual NAND driver goes in
> drivers/mtd/nand, and is apparently in a separate patch (probably due =
to
> separate maintenance domains).
>=20
> It's the same situation as arch/powerpc/sysdev/fsl_lbc.c versus
> drivers/mtd/nand/fsl_elbc_nand.c and drivers/mtd/nand/fsl_upm.c.
>=20
> -Scott

As Scott said, I was more asking about the 2nd patch in the sequence =
which did touch MTD.  Since that one is dependent on this patch, =
wondering how we wanted to handle them.

- k
