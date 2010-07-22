Return-Path: <kumar.gala@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id C3407B70B5
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 01:52:12 +1000 (EST)
Subject: Re: [PATCH] powerpc: rename immap_86xx.h to fsl_guts.h,
	and add 85xx support
MIME-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1279812617.7232.8703.camel@petert>
Date: Thu, 22 Jul 2010 10:36:55 -0500
Message-ID: <DC2F17B7-80FA-4CCC-81E2-0FCFE5D63C28@freescale.com>
References: <1279749902-13459-1-git-send-email-timur@freescale.com>
	<1279812617.7232.8703.camel@petert>
To: Peter Tyser <ptyser@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com,
	Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 22, 2010, at 10:30 AM, Peter Tyser wrote:

> Hi Timur,
>=20
>> +/**
>> + * Global Utility Registers.
>> + *
>> + * Not all registers defined in this structure are available on all =
chips, so
>> + * you are expected to know whether a given register actually exists =
on your
>> + * chip before you access it.
>> + *
>> + * Also, some registers are similar on different chips but have =
slightly
>> + * different names.  In these cases, one name is chosen to avoid =
extraneous
>> + * #ifdefs.
>> + */
>> +#ifdef CONFIG_PPC_85xx
>> +struct ccsr_guts_85xx {
>> +#else
>> +struct ccsr_guts_86xx {
>> +#endif
>=20
> Is there a good reason to have 2 different names for the same =
structure
> depending on the architecture?  I'd think keeping a common "ccsr_guts"
> name would get rid of the ifdefs above as well as in code that can be
> used on both 85xx and 86xx processors down the road.

I asked for separate structs since the feeling is the GUTS code should =
be limited to platform specific locations.  Additionally the new =
P3/P4/P5 class parts have a completely different guts immap so if/when =
we add them in things would have to change.

- k=
