Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 5648FDE05E
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 09:30:29 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 17C081432C
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 01:04:54 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11191-07 for <linuxppc-dev@ozlabs.org>;
	Sat,  2 Jun 2007 01:04:52 +0200 (CEST)
Message-ID: <4660A611.9020909@semihalf.com>
Date: Sat, 02 Jun 2007 01:04:49 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: BestComm ATA task on MPC52xx
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I am working on bringing up a DMA support for ATA controller on MPC52xx
and I am facing problems for which I am not pretty sure what the actual
root cause is.

There was a John Rigby's patch last year, which was based on arch/ppc
and drivers/ide (mpc52xx_ide.c). I use arch/powerpc and adopted to
libata version of mpc52xx_ide.c which is now merged to vanilla and is
called pata_mpc52xx.c. On top of this I have John Rigby's modifications
converted from ide to libata. Problems appear with the first DMA
transfer attempt, which happens during a driver probe when partition
table is read. There shall be a interrupt signaling a transfer end and
the handler (not present in John Rigby's code) should do the transfer
closing. But the interrupt is not received and after the cmd timeouts it
looks like ATA controller registers, BestComm registers, buffer
descriptors and BestComm ATA task variables are unchanged. So, it seems
that for some reason ATA BestComm task did not run/do it's job.

Did anyone had any success with ATA DMA on 52xx? Or maybe hear about
newer version of the ATA BestComm task, or some useful ways of debugging
BestComm stuff? I am planning to post my working code but need a day or
two to clean it up a little.

Thanks,
Marian
