Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 539162BDC5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 20:19:43 +1000 (EST)
Date: Tue, 21 Sep 2004 06:13:14 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <B244CFE5-0B98-11D9-97DC-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.60.0409210605090.9033@dell.enoriver.com>
References: <Pine.LNX.4.60.0409201531570.5653@dell.enoriver.com>
	<E91A9C3A-0B51-11D9-9327-003065F9B7DC@embeddededge.com>
	<Pine.LNX.4.60.0409201949550.6348@dell.enoriver.com>
	<B244CFE5-0B98-11D9-97DC-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


   rather than get into more detailed discussion on microcode patches, 
here's a (partial) patch that represents what i'd really, really, 
*really* like to see.

==========================================================================
--- linuxppc-2.5/arch/ppc/8xx_io/Kconfig	2004-09-21 05:54:40.112334040 -0400
+++ linuxppc-2.5-new/arch/ppc/8xx_io/Kconfig	2004-09-21 06:00:56.836063328 -0400
@@ -140,13 +140,23 @@

  	  If in doubt, say N here.

-config UCODE_PATCH
-	bool "I2C/SPI Microcode Patch"
-	help
-	  Motorola releases microcode updates for their 8xx CPM modules.  The
-	  microcode update file has updates for IIC, SMC and USB.  Currently only
-	  the USB update is available by default, if the MPC8xx USB option is
-	  enabled.  If in doubt, say 'N' here.
+choice
+	prompt "Microcode patch selection"
+	default NO_UCODE_PATCH
+
+config NO_UCODE_PATCH
+	bool "None"
+
+config USB_SOF_PATCH
+	bool "USB SOF patch"
+
+config I2C_SPI_PATCH
+	bool "I2C/SPI relocation patch"
+
+config I2C_SPI_SMC1_PATCH
+	bool "I2C/SPI/SMC1 relocation patch"
+
+endchoice

  endmenu
==========================================================================

   it adds a simple choice entry to the MPC8xx menu, from which you can 
select the appropriate patch -- it's as easy as that.

   note that that's not the entire list of possible patches -- i have 
the list from wolfgang's tree that distinguishes between 850 and 8xx 
(non-850) patches in some cases so the list is actually longer than 
this one.  but, really, selecting a patch should be this easy -- pick 
one and check the box.  and this makes it trivial to add or delete 
patches appropriately as time goes by.

   obviously, this menu requires changes in the underlying micropatch.c 
file (which aren't shown here), but i'm curious about whether this 
approach would overly offend anyone.

   i'm willing to create the overall patch to support this, but not if 
it's just going to be tossed because of philosophical positions.


rday
