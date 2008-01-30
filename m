Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D3DADDEBA
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 03:35:13 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id m0UGYwmI010638
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 22:04:58 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0UGYw3q1126436
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 22:04:58 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m0UGYwqK009354
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 16:34:58 GMT
Message-ID: <47A0A3AF.5050005@linux.vnet.ibm.com>
Date: Wed, 30 Jan 2008 21:49:59 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>,
	Andy Whitcroft <apw@shadowen.org>
Subject: [BUILD FAILURE] 2.6.24-git7 section type conflict at various drivers
	on powerpc
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Following are the different build failure with 2.6.24-git7 kernel on the powerpc

drivers/net/typhoon.c:181: error: typhoon_card_info causes a section type conflict
make[2]: *** [drivers/net/typhoon.o] Error 1

drivers/net/natsemi.c:259: error: natsemi_pci_info causes a section type conflict
make[2]: *** [drivers/net/natsemi.o] Error 1

drivers/net/bnx2.c:95: error: board_info causes a section type conflict
make[2]: *** [drivers/net/bnx2.o] Error 1

drivers/net/via-velocity.c:454: error: velocity_id_table causes a section type conflict
make[2]: *** [drivers/net/via-velocity.o] Error 1


Following are warning with section mismatch CONFIG_DEBUG_SECTION_MISMATCH enabled,

WARNING: kernel/built-in.o(.text+0x423f4): Section mismatch in reference from the function .enable_nonboot_cpus() to the function .cpuinit.text:._cpu_up()
The function  .enable_nonboot_cpus() references
the function __cpuinit ._cpu_up().
This is often because .enable_nonboot_cpus lacks a __cpuinit 
annotation or the annotation of ._cpu_up is wrong.

WARNING: drivers/net/ibm_newemac/ibm_newemac.o(.devinit.text+0x1bb4): Section mismatch in reference from the function .emac_probe() to the function .devexit.text:.tah_detach()
The function __devinit .emac_probe() references
a function __devexit .tah_detach().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
.tah_detach() so it may be used outside an exit section.

WARNING: drivers/net/ibm_newemac/ibm_newemac.o(.devinit.text+0x1bd0): Section mismatch in reference from the function .emac_probe() to the function .devexit.text:.rgmii_detach()
The function __devinit .emac_probe() references
a function __devexit .rgmii_detach().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
.rgmii_detach() so it may be used outside an exit section.

WARNING: drivers/net/ibm_newemac/ibm_newemac.o(.devinit.text+0x1bec): Section mismatch in reference from the function .emac_probe() to the function .devexit.text:.zmii_detach()
The function __devinit .emac_probe() references
a function __devexit .zmii_detach().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
.zmii_detach() so it may be used outside an exit section.

WARNING: drivers/net/ibm_newemac/ibm_newemac.o(.devinit.text+0x1bfc): Section mismatch in reference from the function .emac_probe() to the function .devexit.text:.mal_unregister_commac()
The function __devinit .emac_probe() references
a function __devexit .mal_unregister_commac().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
.mal_unregister_commac() so it may be used outside an exit section.

  LD      drivers/net/ibm_newemac/built-in.o
WARNING: drivers/net/ibm_newemac/built-in.o(.devinit.text+0x1bb4): Section mismatch in reference from the function .emac_probe() to the function .devexit.text:.tah_detach()
The function __devinit .emac_probe() references
a function __devexit .tah_detach().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
.tah_detach() so it may be used outside an exit section.

WARNING: drivers/net/ibm_newemac/built-in.o(.devinit.text+0x1bd0): Section mismatch in reference from the function .emac_probe() to the function .devexit.text:.rgmii_detach()
The function __devinit .emac_probe() references
a function __devexit .rgmii_detach().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
.rgmii_detach() so it may be used outside an exit section.

WARNING: drivers/net/ibm_newemac/built-in.o(.devinit.text+0x1bec): Section mismatch in reference from the function .emac_probe() to the function .devexit.text:.zmii_detach()
The function __devinit .emac_probe() references
a function __devexit .zmii_detach().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
.zmii_detach() so it may be used outside an exit section.

WARNING: drivers/net/ibm_newemac/built-in.o(.devinit.text+0x1bfc): Section mismatch in reference from the function .emac_probe() to the function .devexit.text:.mal_unregister_commac()
The function __devinit .emac_probe() references
a function __devexit .mal_unregister_commac().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
.mal_unregister_commac() so it may be used outside an exit section.

WARNING: drivers/net/mlx4/mlx4_core.o(.text+0x6cf8): Section mismatch in reference from the function .mlx4_init_icm() to the function .devinit.text:.mlx4_init_cmpt_table()
The function  .mlx4_init_icm() references
the function __devinit .mlx4_init_cmpt_table().
This is often because .mlx4_init_icm lacks a __devinit 
annotation or the annotation of .mlx4_init_cmpt_table is wrong.

WARNING: drivers/net/mlx4/mlx4_core.o(.text+0x728c): Section mismatch in reference from the function .mlx4_init_hca() to the function .devinit.text:.mlx4_load_fw()
The function  .mlx4_init_hca() references
the function __devinit .mlx4_load_fw().
This is often because .mlx4_init_hca lacks a __devinit 
annotation or the annotation of .mlx4_load_fw is wrong.

WARNING: drivers/net/mlx4/mlx4_core.o(.text+0x7c98): Section mismatch in reference from the function .__mlx4_init_one() to the function .devinit.text:.mlx4_enable_msi_x()
The function  .__mlx4_init_one() references
the function __devinit .mlx4_enable_msi_x().
This is often because .__mlx4_init_one lacks a __devinit 
annotation or the annotation of .mlx4_enable_msi_x is wrong.

WARNING: drivers/net/mlx4/mlx4_core.o(.text+0x97ac): Section mismatch in reference from the function .mlx4_init_mr_table() to the function .devinit.text:.mlx4_buddy_init()
The function  .mlx4_init_mr_table() references
the function __devinit .mlx4_buddy_init().
This is often because .mlx4_init_mr_table lacks a __devinit 
annotation or the annotation of .mlx4_buddy_init is wrong.

  LD      drivers/net/mlx4/built-in.o
WARNING: drivers/net/mlx4/built-in.o(.text+0x6cf8): Section mismatch in reference from the function .mlx4_init_icm() to the function .devinit.text:.mlx4_init_cmpt_table()
The function  .mlx4_init_icm() references
the function __devinit .mlx4_init_cmpt_table().
This is often because .mlx4_init_icm lacks a __devinit 
annotation or the annotation of .mlx4_init_cmpt_table is wrong.

WARNING: drivers/net/mlx4/built-in.o(.text+0x728c): Section mismatch in reference from the function .mlx4_init_hca() to the function .devinit.text:.mlx4_load_fw()
The function  .mlx4_init_hca() references
the function __devinit .mlx4_load_fw().
This is often because .mlx4_init_hca lacks a __devinit 
annotation or the annotation of .mlx4_load_fw is wrong.

WARNING: drivers/net/mlx4/built-in.o(.text+0x7c98): Section mismatch in reference from the function .__mlx4_init_one() to the function .devinit.text:.mlx4_enable_msi_x()
The function  .__mlx4_init_one() references
the function __devinit .mlx4_enable_msi_x().
This is often because .__mlx4_init_one lacks a __devinit 
annotation or the annotation of .mlx4_enable_msi_x is wrong.

WARNING: drivers/net/mlx4/built-in.o(.text+0x97ac): Section mismatch in reference from the function .mlx4_init_mr_table() to the function .devinit.text:.mlx4_buddy_init()
The function  .mlx4_init_mr_table() references
the function __devinit .mlx4_buddy_init().
This is often because .mlx4_init_mr_table lacks a __devinit 
annotation or the annotation of .mlx4_buddy_init is wrong.

WARNING: drivers/net/tokenring/built-in.o(.text+0x4d64): Section mismatch in reference from the function .olympic_open() to the function .devinit.text:.olympic_init()
The function  .olympic_open() references
the function __devinit .olympic_init().
This is often because .olympic_open lacks a __devinit 
annotation or the annotation of .olympic_init is wrong.


-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
