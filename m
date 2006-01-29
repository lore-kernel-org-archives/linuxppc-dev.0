Return-Path: <dibacco@inwind.it>
Received: from smtp2.libero.it (smtp2.libero.it [193.70.192.52])
	by ozlabs.org (Postfix) with ESMTP id 2B8FD68A84
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jan 2006 07:44:52 +1100 (EST)
Received: from localhost (172.16.1.77) by smtp2.libero.it (7.0.027-DD01)
	id 439D90690378860E for linuxppc-embedded@ozlabs.org;
	Sun, 29 Jan 2006 21:36:17 +0100
Received: from smtp1.libero.it ([172.16.1.96])
	by localhost (asav19.libero.it [193.70.193.6]) (amavisd-new, port 10024)
	with ESMTP id 05583-18-2 for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Jan 2006 21:36:16 +0100 (CET)
Received: from libero.it (172.16.1.87) by smtp1.libero.it (7.0.027-DD01)
	id 431C3A4201807339 for linuxppc-embedded@ozlabs.org;
	Sun, 29 Jan 2006 21:36:16 +0100
Date: Sun, 29 Jan 2006 21:36:16 +0100
Message-Id: <ITVFWG$4348B6817725503C985E8AE1EC093B8E@libero.it>
Subject: MPC875 porting
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a custom board with a MPC875 and two ethernet ports. I think I nee=
d to modify the enet.c to have two ethernet ports working. What happens i=
f I define both
CONFIG_SCC1_ENET and CONFIG_SCC2_ENET ? I saw in enet.c the following cod=
e:

#if defined(CONFIG_SCC3_ENET)
#define CPM_CR_ENET	CPM_CR_CH_SCC3
#define PROFF_ENET	PROFF_SCC3
#define SCC_ENET	2		/* Index, not number! */
#define CPMVEC_ENET	CPMVEC_SCC3
#elif defined(CONFIG_SCC2_ENET)
#define CPM_CR_ENET	CPM_CR_CH_SCC2
#define PROFF_ENET	PROFF_SCC2
#define SCC_ENET	1		/* Index, not number! */
#define CPMVEC_ENET	CPMVEC_SCC2
#elif defined(CONFIG_SCC1_ENET)
#define CPM_CR_ENET	CPM_CR_CH_SCC1
#define PROFF_ENET	PROFF_SCC1
#define SCC_ENET	0		/* Index, not number! */
#define CPMVEC_ENET	CPMVEC_SCC1
#else
#error CONFIG_SCCx_ENET not defined
#endif

The point is that there is and elif here, only the SCC1 will work then, I=
'm confused!

Thank you for your help!

Bye.
