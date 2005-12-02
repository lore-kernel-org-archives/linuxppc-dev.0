Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D77568802
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Dec 2005 01:09:40 +1100 (EST)
Message-ID: <4390559D.3010605@iki.fi>
Date: Fri, 02 Dec 2005 16:09:33 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: Alex BASTOS <alebas@televes.com>
References: <4390223C.8060103@ru.mvista.com>
	<0IQV004GGIH0UG@mailstore1.hut-mail>
In-Reply-To: <0IQV004GGIH0UG@mailstore1.hut-mail>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pq2_find_bridges hangs system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex BASTOS wrote:

>The Tranfer Error makes not many sense for me, as _TEA is pulled-up.
>Maybe the oops after that is caused by the bad call return point?
>  
>
I remember using this to prevent machine check exceptions during the PCI 
scan. This is in the beginning of the pciauto_bus_scan() function.

--- trunk/linux/arch/ppc/syslib/pci_auto.c	(revision 127)
+++ trunk/linux/arch/ppc/syslib/pci_auto.c	(revision 128)
@@ -382,6 +382,10 @@
 	unsigned short vid;
 	unsigned char header_type;
 
+
+	/* must ignore machine checks during scan */
+	*(volatile unsigned short *) 0xf0010888 &= ~0x0800;
+
 	/*
 	 * Fetch our I/O and memory space upper boundaries used
 	 * to allocated base addresses on this hose.
