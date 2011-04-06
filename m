Return-Path: <rlary@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2E08B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 08:50:56 +1000 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p36MTBp4020402
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2011 18:29:11 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9F5F86E8036
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 18:50:53 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p36MorJP2322686
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2011 18:50:53 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p36Moq7w021344
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2011 19:50:52 -0300
Message-ID: <4D9CEE45.9000904@linux.vnet.ibm.com>
Date: Wed, 06 Apr 2011 15:50:45 -0700
From: Richard A Lary <rlary@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1]  powerpc/eeh: Add support for ibm,configure-pe RTAS call
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: rlary@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Richard A. Lary <rlary@linux.vnet.ibm.com>

Added support for ibm,configure-pe RTAS call introduced with
PAPR 2.2.

Signed-off-by: Richard A. Lary <rlary@linux.vnet.ibm.com>
---
  arch/powerpc/platforms/pseries/eeh.c |   13 	12 +	1 -	0 !
  1 file changed, 12 insertions(+), 1 deletion(-)

Index: b/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -95,6 +95,7 @@ static int ibm_slot_error_detail;
  static int ibm_get_config_addr_info;
  static int ibm_get_config_addr_info2;
  static int ibm_configure_bridge;
+static int ibm_configure_pe;

  int eeh_subsystem_enabled;
  EXPORT_SYMBOL(eeh_subsystem_enabled);
@@ -263,6 +264,8 @@ void eeh_slot_error_detail(struct pci_dn
  	pci_regs_buf[0] = 0;

  	rtas_pci_enable(pdn, EEH_THAW_MMIO);
+	rtas_configure_bridge(pdn);
+	eeh_restore_bars(pdn);
  	loglen = gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);

  	rtas_slot_error_detail(pdn, severity, pci_regs_buf, loglen);
@@ -896,6 +899,7 @@ void
  rtas_configure_bridge(struct pci_dn *pdn)
  {
  	int config_addr;
+	int token;
  	int rc;

  	/* Use PE configuration address, if present */
@@ -903,7 +907,13 @@ rtas_configure_bridge(struct pci_dn *pdn
  	if (pdn->eeh_pe_config_addr)
  		config_addr = pdn->eeh_pe_config_addr;

-	rc = rtas_call(ibm_configure_bridge,3,1, NULL,
+	/* Use new configure-pe function, if supported */
+	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE)
+		token = ibm_configure_pe;
+	else
+		token = ibm_configure_bridge;
+
+	rc = rtas_call(token, 3, 1, NULL,
  	               config_addr,
  	               BUID_HI(pdn->phb->buid),
  	               BUID_LO(pdn->phb->buid));
@@ -1079,6 +1089,7 @@ void __init eeh_init(void)
  	ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
  	ibm_get_config_addr_info2 = rtas_token("ibm,get-config-addr-info2");
  	ibm_configure_bridge = rtas_token ("ibm,configure-bridge");
+	ibm_configure_pe = rtas_token("ibm,configure-pe");

  	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
  		return;
