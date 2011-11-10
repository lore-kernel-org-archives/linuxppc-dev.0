Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 824ECB6F8F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 05:53:07 +1100 (EST)
Subject: Re: [RFC PATCH 16/17] powerpc/e500: Make __setup_cpu_{e200, e500,
 e500mc, e5500} optional
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111110164741.GC11983@schlenkerla.am.freescale.net>
Date: Thu, 10 Nov 2011 12:52:36 -0600
Message-Id: <45E2D05B-B8B9-4254-910C-F24757C59A22@kernel.crashing.org>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-17-git-send-email-Kyle.D.Moffett@boeing.com>
 <20111110164741.GC11983@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Shaohui Xie <b21989@freescale.com>,
 Alexandre Bounine <alexandre.bounine@idt.com>,
 Timur Tabi <B04825@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 10, 2011, at 10:47 AM, Scott Wood wrote:

> On Wed, Nov 09, 2011 at 07:07:14PM -0500, Kyle Moffett wrote:
>> Only build the setup functions when the corresponding entries are
>> included in the CPU table.
>>=20
>> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
>> ---
>> arch/powerpc/kernel/cpu_setup_fsl_booke.S |   14 +++++++++++++-
>> 1 files changed, 13 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S =
b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
>> index 8053db0..77721b2 100644
>> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
>> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
>> @@ -17,6 +17,8 @@
>> #include <asm/cputable.h>
>> #include <asm/ppc_asm.h>
>>=20
>> +#if defined(CONFIG_FSL_E500_V1_V2) || defined(CONFIG_FSL_E500MC) \
>> +		|| defined(CONFIG_FSL_E5500)
>=20
> This seems like the kind of thing that CONFIG_E500 should be retained
> for.
>=20
> -Scott

Agreed, we should define CONFIG_E500 as internal and used for common =
functionality between E500, E500MC, E5500, E6500.

- k=
