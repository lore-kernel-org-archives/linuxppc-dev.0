Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CFC22C02C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 12:28:43 +1000 (EST)
Date: Thu, 27 Jun 2013 21:28:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Hongtao Jia <hongtao.jia@freescale.com>
Subject: Re: [V2,2/2] powerpc/85xx: workaround for chips with MSI hardware
 errata
Message-ID: <20130628022833.GA28050@home.buserror.net>
References: <1364954598-31914-2-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1364954598-31914-2-git-send-email-hongtao.jia@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 03, 2013 at 10:03:18AM +0800, Hongtao Jia wrote:
> The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It causes
> that neither MSI nor MSI-X can work fine. This is a workaround to allow
> MSI-X to function properly.
> 
> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>

Building on 83xx:

  arch/powerpc/sysdev/built-in.o: In function `fsl_of_msi_probe':
  fsl_msi.c:(.text+0x1464): undefined reference to `fsl_mpic_primary_get_version'
  make[1]: *** [vmlinux] Error 1
  make: *** [sub-make] Error 2

fsl_msi.c supports IPIC as well.

-Scott
