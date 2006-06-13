Return-Path: <chuckmeade@mindspring.com>
Received: from txslsmtp1.vzwmail.net (unknown [66.174.85.155])
	by ozlabs.org (Postfix) with ESMTP id 22C0767B41
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 08:00:25 +1000 (EST)
From: "Chuck Meade" <chuckmeade@mindspring.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	"'Kumar Gala'" <galak@kernel.crashing.org>,
	"'Alex Zeffertt'" <ajz@cambridgebroadband.com>
Subject: RE: No ttyS device at I/O port 0xfe004500 for console
Date: Tue, 13 Jun 2006 18:01:12 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGCEFHLDAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <001101c68f31$d89aa220$0e67a8c0@Jocke>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Hi Joakim,
> > 
> > Same here -- go into arch/ppc/platforms/83xx and edit file 
> > mpc83xx_sys.c.
> > If you are using the 8323e cpu, then you need to make sure
> 
> Yes, got one of those.
>  
> > that file has code to support the 8323E.  Mine didn't, so I 
> > got no platform devices initialized (no serial port, no Eth 
> > devs).  I added a block of code to support the 8323E (set 
> > mask to 0xffff0000 and "value" to 0x80620000, then the device 
> > list for the 8323E).  Use existing code there as a guide, it 
> > was not difficult once I figured out that this was the problem.
> 
> hmm, you don't have a patch handy?

Here you go:

--- mpc83xx_sys.c-ORIG	2006-06-13 17:54:36.577339832 -0400
+++ mpc83xx_sys.c	2006-06-13 17:56:02.394293672 -0400
@@ -136,6 +136,23 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 #endif
 		},
 	},
+	{
+		.ppc_sys_name	= "8323E",
+		.mask		= 0xFFFF0000,
+		.value		= 0x80620000,
+#ifdef CONFIG_QE
+		.num_devices	= 4,
+#else
+		.num_devices	= 2,
+#endif
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_IIC1, MPC83xx_DUART,
+#ifdef CONFIG_QE
+			MPC83xx_QE_UCC3, MPC83xx_QE_UCC4,
+#endif
+		},
+	},
 	{	/* default match */
 		.ppc_sys_name	= "",
 		.mask 		= 0x00000000,


Regards,
Chuck
