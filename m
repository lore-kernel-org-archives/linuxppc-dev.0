Return-Path: <B40534@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21BDA2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 13:30:40 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [RFC 2/2] powerpc/cputable: add wait feature for CPU kernel
 features
Date: Tue, 30 Jul 2013 03:30:29 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259FEF03A@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1373444876-7783-2-git-send-email-dongsheng.wang@freescale.com>
 (from dongsheng.wang@freescale.com on Wed Jul 10 03:27:56 2013)
 <1375118838.30721.43@snotra>
In-Reply-To: <1375118838.30721.43@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, July 30, 2013 1:27 AM
> To: Wang Dongsheng-B40534
> Cc: benh@kernel.crashing.org; galak@kernel.crashing.org; Zhao Chenhui-
> B35336; Li Yang-R58472; Wang Dongsheng-B40534
> Subject: Re: [RFC 2/2] powerpc/cputable: add wait feature for CPU kernel
> features
>=20
> On 07/10/2013 03:27:56 AM, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > diff --git a/arch/powerpc/include/asm/cputable.h
> > b/arch/powerpc/include/asm/cputable.h
> > index 6f3887d..0a8d0cb 100644
> > --- a/arch/powerpc/include/asm/cputable.h
> > +++ b/arch/powerpc/include/asm/cputable.h
> > @@ -138,6 +138,7 @@ extern const char *powerpc_base_platform;
> >  #define CPU_FTR_NOEXECUTE		ASM_CONST(0x10000000)
> >  #define CPU_FTR_INDEXED_DCR		ASM_CONST(0x20000000)
> >  #define CPU_FTR_EMB_HV			ASM_CONST(0x40000000)
> > +#define CPU_FTR_CAN_WAIT		ASM_CONST(0x80000000)
>=20
> Note that this is the last 32-bit CPU feature flag; it's time to start
> thinking about other mechanisms.  We should probably reserve feature
> flags for things that need to use code patching due to being on a
> performance critical path, and move other things into struct cpu_spec.
> CPU_FTR_CAN_WAIT seems like a good candidate to be moved.
>=20
First of all, why should I do, I need to distinguish between the core, whic=
h
is to support the wait instruction. The CPU_FTR_CAN_WAIT looks easy.

How to fix this problem:
1/ I can drop this cpu feature, and move it into struct cpu_spec.
Add a pm_feature in struct cpu_spec? like,

struct cpu_spec {
	...
	unsigned long pm_features;
	...
}

2/ Drop this cpu feature, using CPU_FTRS_E6500/CPU_FTRS_E5500.. to distingu=
ish wait or doze/nap.
Like,

CPU_FTRS_E500/CPU_FTRS_E500_2 support doze/nap.

CPU_FTRS_E500MC/CPU_FTRS_E5500/CPU_FTRS_E6500 support wait.

If using this method, inside the cpuidle driver needs to do a lot of judgme=
nt. So I'm not sure this
is a very good solution.

Thanks.
- dongsheng
