Return-Path: <mmlnx@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02211DDEFD
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 13:18:58 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m683IsPO029949
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 23:18:54 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m683Isjc170442
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 21:18:54 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m683IrEL009984
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 21:18:54 -0600
Message-ID: <4872DC9C.4000706@us.ibm.com>
Date: Mon, 07 Jul 2008 20:18:52 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: paulus@samba.org, benh@kernel.crashing.org, linasvepstas@gmail.com,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] Restore PERR/SERR bit settings during EEH device recovery
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch restores the PERR and SERR bits in the PCI
command register during an EEH device recovery.
We have found at least one case (an Agilent test card) where the
PERR/SERR bits are set to 1 by firmware at boot time, but are
not restored to 1 during EEH recovery.  The patch fixes the
Agilent card problem.  It has been tested on several other 
EEH-enabled cards with no regressions.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com>

--- linux-2.6.26-rc9/arch/powerpc/platforms/pseries/eeh.c	2008-07-07 16:06:57.000000000 -0700
+++ linux-2.6.26-rc9-new/arch/powerpc/platforms/pseries/eeh.c	2008-07-07 16:11:10.000000000 -0700
@@ -812,6 +812,7 @@
 static inline void __restore_bars (struct pci_dn *pdn)
 {
 	int i;
+	u32 cmd;
 
 	if (NULL==pdn->phb) return;
 	for (i=4; i<10; i++) {
@@ -832,6 +833,15 @@
 
 	/* max latency, min grant, interrupt pin and line */
 	rtas_write_config(pdn, 15*4, 4, pdn->config_space[15]);
+
+	/* Restore PERR & SERR bits, some devices require it,
+	   don't touch the other command bits */
+	rtas_read_config(pdn, PCI_COMMAND, 4, &cmd);
+	if (pdn->config_space[1] & PCI_COMMAND_PARITY)
+		cmd |= PCI_COMMAND_PARITY;
+	if (pdn->config_space[1] & PCI_COMMAND_SERR)
+		cmd |= PCI_COMMAND_SERR;
+	rtas_write_config(pdn, PCI_COMMAND, 4, cmd);
 }
 
 /**
