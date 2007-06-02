Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4433DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 16:02:55 +1000 (EST)
Message-ID: <4661082C.70607@genesi-usa.com>
Date: Sat, 02 Jun 2007 07:03:24 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: BestComm ATA task on MPC52xx
References: <4660A611.9020909@semihalf.com>
In-Reply-To: <4660A611.9020909@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Which chip revision are you using?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Marian Balakowicz wrote:
> Hi,
> 
> I am working on bringing up a DMA support for ATA controller on MPC52xx
> and I am facing problems for which I am not pretty sure what the actual
> root cause is.
> 
> There was a John Rigby's patch last year, which was based on arch/ppc
> and drivers/ide (mpc52xx_ide.c). I use arch/powerpc and adopted to
> libata version of mpc52xx_ide.c which is now merged to vanilla and is
> called pata_mpc52xx.c. On top of this I have John Rigby's modifications
> converted from ide to libata. Problems appear with the first DMA
> transfer attempt, which happens during a driver probe when partition
> table is read. There shall be a interrupt signaling a transfer end and
> the handler (not present in John Rigby's code) should do the transfer
> closing. But the interrupt is not received and after the cmd timeouts it
> looks like ATA controller registers, BestComm registers, buffer
> descriptors and BestComm ATA task variables are unchanged. So, it seems
> that for some reason ATA BestComm task did not run/do it's job.
> 
> Did anyone had any success with ATA DMA on 52xx? Or maybe hear about
> newer version of the ATA BestComm task, or some useful ways of debugging
> BestComm stuff? I am planning to post my working code but need a day or
> two to clean it up a little.
> 
> Thanks,
> Marian
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
