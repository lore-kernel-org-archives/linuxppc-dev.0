Return-Path: <danny@mailmij.org>
Received: from mail.mailmij.org (mail.mailmij.org [82.93.140.149])
	by ozlabs.org (Postfix) with ESMTP id 9938A679A6
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2006 15:05:11 +1000 (EST)
Date: Mon, 7 Aug 2006 06:38:54 +0200
From: danny@mailmij.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix for firewire patch added in 2.6.17.2 that breaks things
	on ppc
Message-ID: <20060807063854.B641@luna.ellen.dexterslabs.com>
References: <20060805151050.B24484@luna.ellen.dexterslabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
In-Reply-To: <20060805151050.B24484@luna.ellen.dexterslabs.com>;
	from danny@luna.ellen.dexterslabs.com on Sat, Aug 05, 2006 at
	03:10:50PM +0200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
I sent this to Ben earlier but forgot to cc this list:

> 
> Sleep broke on my ibook G3 with 2.6.17. After some tests it seemed it only broke when I had used my 
> iSight. Plugging it after a sleep/resume cycle would sometimes instantly hang the machine.
> 
> The problem appeared to result from a patch added in 2.6.17.2, where a
> pci_save_state(pdev);
> is called after
>  pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 0);
> 
> resuming shows that the corresponding pci_restore_state is writing all ffffffff to the config space. 
> Which is probably not a good idea.
> 

Patch is attached

Danny



--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ohci1394_save_state.patch"


    2.6.17.2 contained a patch for preliminary suspend/resume 
    handling on !PPC_PMAC. However, this broke suspend and firewire
    on powerpc because it saves the state after the device has already
    been disabled.

    Firewire works perfectly through suspend on my ibook, so save/restore
    state is not needed there.
    
    Signed-off-by: Danny Tholen <obiwan@mailmij.org>

--- linux-2.6.17.7/drivers/ieee1394/ohci1394.c~	2006-08-03 10:00:01.875855084 -0400
+++ linux-2.6.17.7/drivers/ieee1394/ohci1394.c	2006-08-03 10:08:24.274059577 -0400
@@ -3537,9 +3537,9 @@
 		if (of_node)
 			pmac_call_feature (PMAC_FTR_1394_ENABLE, of_node, 0, 1);
 	}
-#endif /* CONFIG_PPC_PMAC */
-
+#else
 	pci_restore_state(pdev);
+#endif /* CONFIG_PPC_PMAC */
 	pci_enable_device(pdev);
 
 	return 0;
@@ -3557,10 +3557,9 @@
 		if (of_node)
 			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 0);
 	}
-#endif
-
+#else
 	pci_save_state(pdev);
-
+#endif /* CONFIG_PPC_PMAC */
 	return 0;
 }
 

--envbJBWh7q8WU6mo--
