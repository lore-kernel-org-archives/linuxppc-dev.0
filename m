Return-Path: <dan.j.williams@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 2B24FB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Jul 2010 05:21:10 +1000 (EST)
Received: by gxk26 with SMTP id 26so299837gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 12:21:08 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <201007230815.14464.sr@denx.de>
References: <1279846638-22323-1-git-send-email-tmarri@amcc.com>
	<201007230815.14464.sr@denx.de>
Date: Fri, 23 Jul 2010 12:21:08 -0700
Message-ID: <AANLkTi=M1L3xPiA1zyvDkA3403B=OpXdWfhMEP7mahrW@mail.gmail.com>
Subject: Re: [PATCH] Adding ADMA support for PPC460EX DMA engine.
From: Dan Williams <dan.j.williams@intel.com>
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-raid@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org, tmarri@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 22, 2010 at 11:15 PM, Stefan Roese <sr@denx.de> wrote:
> Hi Marri,
>
> On Friday 23 July 2010 02:57:18 tmarri@amcc.com wrote:
>> From: Tirumala Marri <tmarri@amcc.com>
>>
>> =A0 This patch will add ADMA support for DMA engine and HW offload for
>> =A0 XOR/ADG (RAID-5/6) functionalities.
>> =A0 1. It supports memcpy, xor, GF(2) based RAID-6.
>> =A0 2. It supports interrupt based DMA completions.
>> =A0 3. Also supports memcpy in RAID-1 case.
>>
>> =A0 Kernel version: 2.6.35-rc5
>>
>> =A0 Testing:
>> =A0 =A0 Created RAID-5/6 arrays usign mdadm.
>> =A0 =A0 And ran raw IO and filesystem IO to the RAID array.
>> =A0 =A0 Chunk size 4k,64k was tested.
>> =A0 =A0 RAID rebuild , disk fail, resync tested.
>>
>> =A0 File names:
>> =A0 =A0 This code is similar to ppc440spe . So I named the files as
>> =A0 =A0 drivers/dma/ppc4xx/adma1.c and drivers/dma/ppc4xx/adma1.h
>
> As you describe above, a lot of the code seems to be copied from
> drivers/dma/ppc4xx/adma.c/h. Wouldn't it make more sense to factor out th=
e
> common code instead of duplicating it?
>

Yes, and you might look to drivers/dma/iop-adma.c as an example of a
way to support similar hardware with a single code base.

--
Dan
