Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B4B3101D2D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 03:30:58 +1100 (EST)
Subject: Re: [RFC PATCH 00/17] powerpc/e500: separate e500 from e500mc
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C0DED343-76A8-457E-BF54-E52DFCAC83A8@boeing.com>
Date: Thu, 10 Nov 2011 10:30:41 -0600
Message-Id: <58FDDDA5-26C4-493B-A00D-81DD94A5C26A@kernel.crashing.org>
References: <4E42AB6F.1050900@freescale.com>
 <1320883399-15911-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <FF2BF3F3-1158-4747-AEEC-03D6A7C462D9@kernel.crashing.org>
 <C0DED343-76A8-457E-BF54-E52DFCAC83A8@boeing.com>
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Cc: Scott Wood <scottwood@freescale.com>, Timur Tabi <B04825@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 10, 2011, at 10:17 AM, Moffett, Kyle D wrote:

> On Nov 10, 2011, at 08:59, Kumar Gala wrote:
>> On Nov 9, 2011, at 6:03 PM, Kyle Moffett wrote:
>>> I saw Baruch Siach's patch:
>>> powerpc: 85xx: separate e500 from e500mc
>>>=20
>>> Unfortunately, that patch breaks the dependencies for the P5020DS
>>> platform and does not fix the underlying code which does not
>>> understand what the ambiguous "CONFIG_E500" means.
>>>=20
>>> In order to fix the issue at the fundamental level, I created the
>>> following 17-patch series loosely based on Baruch's patch.
>>>=20
>>> =3D=3D=3D High-Level Summary =3D=3D=3D
>>>=20
>>> The e500v1/v2 and e500mc/e5500 CPU families are not compatible with
>>> each other, yet they share the same "CONFIG_E500" Kconfig option.
>>>=20
>>> The following patch series splits the 32-bit CPU support into two
>>> separate options: "CONFIG_FSL_E500_V1_V2" and "CONFIG_FSL_E500MC".
>>> Additionally, the 64-bit e5500 support is separated to its own =
config
>>> option ("CONFIG_FSL_E5500") which is automatically combined with
>>> either 32-bit e500MC or 64-bit Book-3E when the P5020DS board =
support
>>> is enabled.
>>=20
>> So its clear from the community that there is confusion here and we
>> need to clean this up.  I guess my attempt to support an kernel that
>> ran on both E500v2 and E500mc isn't worth it.  However I don't want =
to
>> completely remove the ability to do this.
>=20
> Well, a kernel built with CONFIG_PPC_E500MC today appears to be
> fundamentally broken on E500v1/E500v2:
>=20
> #if defined(CONFIG_8xx) || defined(CONFIG_403GCX)
> #define L1_CACHE_SHIFT		4
> #define MAX_COPY_PREFETCH	1
> #elif defined(CONFIG_PPC_E500MC)
> #define L1_CACHE_SHIFT		6
> #define MAX_COPY_PREFETCH	4
> #elif defined(CONFIG_PPC32)
> #define MAX_COPY_PREFETCH	4
> #if defined(CONFIG_PPC_47x)
> #define L1_CACHE_SHIFT		7
> #else
> #define L1_CACHE_SHIFT		5
> #endif
> #else /* CONFIG_PPC64 */
> #define L1_CACHE_SHIFT		7
> #endif
>=20
> E500MC will set L1_CACHE_SHIFT to 6, while regular E500 appears to
> want it set to 5.  I don't know if that's a mistake or exactly what
> code that affects, but it looks very wrong.

This is correct for E500 & E500MC.  However we have a HW mode that =
allows us to handle running in 'e500' mode on e500mc.

> Furthermore, it looks like there are a couple issues here I missed
> before.  PPC64 systems all appear to have an L1_CACHE_SHIFT of 7,
> except when you turn on the P5020DS board option which magically
> changes it to "6" and breaks lord-knows-what.  I think my patch
> series actually "breaks" that and makes e5500 use 7 as well.

a value of '6' on E5500 / P5020DS is correct and doesn't break anything. =
 Setting it to 7 is wrong and thus the code is correct today.

> Are you sure that a kernel built to support E5500 can also run on
> other 64-bit PowerPC/POWER systems?

No it will not.  There is not expectation of that as E5500 is an =
embedded / Book-E class part and uses that ISA version.  Book-S (server) =
64-bit machines are not OS compatible and we are not trying to make them =
as such (but we do re-use a lot of code).

>> Towards the cleanup I'd ask for a proposal on what exactly the
>> CONFIG_ options we'd end up with would be and their meaning.
>> So today we have:
>>=20
>> CONFIG_E500
>> CONFIG_PPC_E500MC
>=20
> It's actually a bit more complicated than that.  There are 3 ways
> that the user can configure an e500 kernel today.  I'm omitting
> the "FSL_SOC_BOOKE" menu that wraps around all of the 85xx/e5500
> boards today, because that is set for all of these platforms:
>=20
>  * PPC32 + PPC_85xx + E500 [+ boards]
>  * PPC64 + BOOK3E_64 + P5020_DS (which adds E500 and PPC_E500MC)
>=20
> Note that whether or not "PPC_E500MC" is set on PPC32 depends
> only on which boards the user picked.  So if I am trying to
> build an e500v2 kernel and I accidentally also turn on support
> for one of the e500mc boards, my kernel mysteriously breaks.

sure, I understand I'm fine with us 'fixing' things such that we treat =
E500V1/V2 differently from E500MC/E5500 in user Kconfig choices

>> What do we want to move to?  I want to keep the builds such that we
>> have only 2 classes:  e500V1/V2 and e500mc/e5500/e6500/.../eX500.
>> I see no reason to hyper-optimize e500mc vs e5500 vs e6500.
>=20
> So after my changes, there are the following user-configurable
> option sets:
>  * PPC32 + FSL_E500_V1_V2 [+ e500v1/v2 boards]
>  * PPC32 + FSL_E500MC     [+ e500mc boards]
>  * PPC64 + BOOK3E_64 + P5020_DS (which adds FSL_E5500)
>=20
> Since most of the "e500mc"-specific code was in 32-bit-only ASM
> or inside of #ifdef PPC32, the new FSL_E500MC option is only
> set on 32-bit builds, even if it is running in compat mode on
> 64-bit e5500 hardware)
>=20
> Internally the P5020_DS option turns on the hidden FSL_E5500
> option for both 32-bit and 64-bit; that config option enables
> platform drivers and similar stuff.
>=20
> Depending on how compatible the AMP processors are, you could
> rename the option to be "FSL_E5X00" or add a hidden option for
> "FSL_E6500" that is also selected by appropriate boards.
>=20
> Please let me know if you think!

I'd like to avoid adding FSL_E5500, FSL_E6500, etc CONFIG options =
getting added.  I'd like to keep things as:

32-bit:
	e500v1/v2
	e500mc/e5500/e6500/...
64-bit:
	e5500/e6500/...

We need to come up with some CONFIG option that covers =
e500mc/e5500/e6500/...

- k=
