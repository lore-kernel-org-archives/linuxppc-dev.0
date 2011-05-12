Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B10E11007DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 01:31:25 +1000 (EST)
Date: Thu, 12 May 2011 10:31:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang-R58472 <R58472@freescale.com>
Subject: Re: [linuxppc-release] [PATCH 1/2] powerpc,	e5500: add networking
	to defconfig
Message-ID: <20110512103108.6dd3ca2a@schlenkerla.am.freescale.net>
In-Reply-To: <3F607A5180246847A760FD34122A1E0514EC65@039-SN1MPN1-002.039d.mgd.msft.net>
References: <20110510180147.GA18443@schlenkerla.am.freescale.net>
	<3F607A5180246847A760FD34122A1E0514EC65@039-SN1MPN1-002.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 12 May 2011 01:11:03 -0500
Li Yang-R58472 <R58472@freescale.com> wrote:

> >Subject: [linuxppc-release] [PATCH 1/2] powerpc, e5500: add networking to
> >defconfig
> >
> >Even though support for the p5020's on-chip ethernet is not yet upstream,
> >it is not appropriate to disable all networking support (including
> >loopback, unix domain sockets, external ethernet devices, etc) in the
> >defconfig.  The networking settings are taken from mpc85xx_smp_defconfig,
> >minus the drivers for ethernet devices not found on any current e5500 chip.
> >
> >The other changes are the result of running "make savedefconfig".
> >
> >Signed-off-by: Scott Wood <scottwood@freescale.com>
> >---
> > arch/powerpc/configs/e55xx_smp_defconfig |   38 ++++++++++++++++++++++---
> >----
> > 1 files changed, 29 insertions(+), 9 deletions(-)
> >
> >diff --git a/arch/powerpc/configs/e55xx_smp_defconfig
> >b/arch/powerpc/configs/e55xx_smp_defconfig
> >index 9fa1613..f4c5780 100644
> >--- a/arch/powerpc/configs/e55xx_smp_defconfig
> >+++ b/arch/powerpc/configs/e55xx_smp_defconfig
> >@@ -6,10 +6,10 @@ CONFIG_NR_CPUS=2
> > CONFIG_EXPERIMENTAL=y
> > CONFIG_SYSVIPC=y
> > CONFIG_BSD_PROCESS_ACCT=y
> >+CONFIG_SPARSE_IRQ=y
> 
> Hi Scott,
> 
> I remember in previous testing that this option has a negative effect on performance.  Do we really need it to be enabled?

I didn't change this setting, it just moved due to running it through
savedefconfig.

-Scott
