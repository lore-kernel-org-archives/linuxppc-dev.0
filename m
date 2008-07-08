Return-Path: <mmlnx@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23C7FDE14D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 02:04:48 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m68G4hNS021247
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 12:04:44 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m68G4ba3089766
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 10:04:38 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m68G4abW032479
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 10:04:36 -0600
Message-ID: <48739013.2050101@us.ibm.com>
Date: Tue, 08 Jul 2008 09:04:35 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linasvepstas@gmail.com, paulus@samba.org, benh@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Restore PERR/SERR bit settings during EEH device recovery
References: <4872DC9C.4000706@us.ibm.com>
	<3ae3aa420807080638t41e8851bx2ad061dd5a4e0279@mail.gmail.com>
In-Reply-To: <3ae3aa420807080638t41e8851bx2ad061dd5a4e0279@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a resubmission of the patch with Linas' suggestion.

The following patch restores the PERR and SERR bits in the PCI
command register during an EEH device recovery. We have found
at least one case (an Agilent test card) where the PERR/SERR
bits are set to 1 by firmware at boot time, but are not restored
to 1 during EEH recovery.  The patch fixes the Agilent card
problem.  It has been tested on several other EEH-enabled cards
with no regressions.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com> 
Acked-by: Linas Vepstas <linasvepstas@gmail.com>

--- linux-2.6.26-rc9/arch/powerpc/platforms/pseries/eeh.c	2008-07-07 16:06:57.000000000 -0700
+++ linux-2.6.26-rc9-new/arch/powerpc/platforms/pseries/eeh.c	2008-07-08 03:56:35.000000000 -0700
@@ -812,6 +812,7 @@
 static inline void __restore_bars (struct pci_dn *pdn)
 {
 	int i;
+	u32 cmd;
 
 	if (NULL==pdn->phb) return;
 	for (i=4; i<10; i++) {
@@ -832,6 +833,19 @@
 
 	/* max latency, min grant, interrupt pin and line */
 	rtas_write_config(pdn, 15*4, 4, pdn->config_space[15]);
+
+	/* Restore PERR & SERR bits, some devices require it,
+	   don't touch the other command bits */
+	rtas_read_config(pdn, PCI_COMMAND, 4, &cmd);
+	if (pdn->config_space[1] & PCI_COMMAND_PARITY)
+		cmd |= PCI_COMMAND_PARITY;
+	else
+		cmd &= ~PCI_COMMAND_PARITY;
+	if (pdn->config_space[1] & PCI_COMMAND_SERR)
+		cmd |= PCI_COMMAND_SERR;
+	else
+		cmd &= ~PCI_COMMAND_SERR;
+	rtas_write_config(pdn, PCI_COMMAND, 4, cmd);
 }
 
 /**
