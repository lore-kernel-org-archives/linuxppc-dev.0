Return-Path: <matvejchikov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 1A10EDE246
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 04:34:30 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id p76so899183pyb
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 11:34:29 -0700 (PDT)
Message-ID: <8496f91a0704271134r48a4855mc79d2e38fae3c041@mail.gmail.com>
Date: Fri, 27 Apr 2007 22:34:28 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] fs_enet & multicasting
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Good Day!

There is a problem in fs_enet driver. When TX times out or when PHY
transceiver adjusts the link the restart() function is called. But it
doesn't take into account the existing device multicast settings (and
IFF_PROMISC too). This little patch fixes the problem.

Signed-off-by: Matvejchikov Ilya <matvejchikov <at> gmail.com>
===================================================================
--- linux-2.6.21.orig/drivers/net/fs_enet/mac-fcc.c
+++ linux-2.6.21/drivers/net/fs_enet/mac-fcc.c
@@ -433,6 +433,8 @@
 	else
  		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);

+	set_multicast_list(dev);
+
  	S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
 }
