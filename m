Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 1319FDE052
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 00:00:54 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so652686yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 07:00:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200905141438.23348.kosmo@semihalf.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<20090506220954.5D3AF83420E8@gemini.denx.de>
	<fa686aa40905061539t4fa463aehe56fdb64d053135d@mail.gmail.com>
	<200905141438.23348.kosmo@semihalf.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 14 May 2009 08:00:33 -0600
Message-ID: <fa686aa40905140700k3ca28ac0m74c9c161ad538abc@mail.gmail.com>
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
To: =?ISO-8859-2?Q?Piotr_Zi=EAcik?= <kosmo@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: Becky Bruce <Becky.Bruce@freescale.com>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, John Rigby <jrigby@gmail.com>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/5/14 Piotr Zi=EAcik <kosmo@semihalf.com>:
> Thursday 07 May 2009 00:39:25 Grant Likely napisa=B3(a):
>> >> 512x are enabled in the same kernel?
>> >
>> > Hm... both architectures look sufficiently different to me that I
>> > don't see sense in trying such a thing. Do you think that needs to be
>> > supported?
>>
>> Yes! =A0:-) =A0It's not hard to do and it keeps the driver cleaner
>> (IMNSHO). =A0I don't think it is quite possible at the moment due to
>> cache coherency issues, but with Becky's recently merged dma ops
>> changes it should be fixable.
>
> Could you elaborate on the cache coherency issues in MPC5121
> FEC context? Especially how these issues are related to the driver
> binary compatibility.
>
> MPC5121 support was added to drivers/net/fs_enet. MPC52xx uses
> drivers/net/fec_mpc52xx.c. Do you think that creating one universal
> driver from these two is now possible? You said that it should be easy,
> however you also said that cache coherency issues makes this imposible.

Not impossible.  Hard.

The mpc5200 is a cache coherent part.  Bestcomm memory accesses are
noticed (snooped) by the cache, and it will flush out cache lines
appropriately to maintain coherency.

The mpc5121 bus design is non-coherent.  The e300 core is essentially
the same as on the 5200, and the core can do snooping, but the
multiport memory controller on the 5121 doesn't support bus snooping
so the cache is not automatically maintained in a consistent state.
On this part Linux needs to manually flush the relevant cache lines
before initiating DMA transfers, and invalidiate them afterwards.

All of this doesn't actually affect the driver code at all.  It's all
handled by the kernel and the DMA apis.  What it does affect is
multiplatform kernels.  The DMA behaviour is set at compile time, not
run time, depending on the setting of CONFIG_NON_COHERENT_CACHE (see
arch/powerpc/platforms/Kconfig.cputype).  A kernel which has it on
won't run properly on a platform which has it off, and visa-versa.

So, while the MPC5200 and MPC5121 (and MPC83xx) all have the same
core, it isn't currently possible to build a single kernel which will
boot on both the MPC5200 and the MPC5121.  The solution (i think) is
to kill CONFIG_NON_COHERENT_CACHE and have the platform setup code set
the appropriate dmaops at platform init time.

Cheers,
g.

>
> --
> Best Regards.
> Piotr Ziecik
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
