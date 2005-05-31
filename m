Return-Path: <benjamin.dapon-pigatto@odyssee-systemes.fr>
Received: from smtp8.wanadoo.fr (smtp8.wanadoo.fr [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id 05B3D67A00
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 May 2005 19:56:29 +1000 (EST)
Received: from smtp8.wanadoo.fr (mwinf0801 [172.22.139.23])
	by mwinf0805.wanadoo.fr (SMTP Server) with ESMTP id 9385A1DC0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 May 2005 11:38:23 +0200 (CEST)
Received: from me-wanadoo.net (unknown [127.0.0.1])
	by mwinf0801.wanadoo.fr (SMTP Server) with ESMTP id C69DE18000BC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 May 2005 11:38:19 +0200 (CEST)
From: "Benjamin Dapon-Pigatto" <benjamin.dapon-pigatto@odyssee-systemes.fr>
To: "'Alex Zeffertt'" <ajz@cambridgebroadband.com>,
	<linuxppc-embedded@ozlabs.org>
Date: Tue, 31 May 2005 11:38:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20050531102323.0fbc2b5e.ajz@cambridgebroadband.com>
Message-Id: <20050531093819.73F7D18000BB@mwinf0801.wanadoo.fr>
Subject: RE: set_multicast_list() commented out in fcc_enet.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Alex,

I had the same problem few months ago with arch/ppc/cpm2_io/fcc_enet.c.=20
It should be the same driver.
I suppose that multicast is not correctly implemented. I have commented =
this
return and promiscuous mode works fine but I have never tried with
multicast.

Benjamin

-----Message d'origine-----
De=A0: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] De la part de Alex =
Zeffertt
Envoy=E9=A0: mardi 31 mai 2005 11:23
=C0=A0: linuxppc-embedded@ozlabs.org
Objet=A0: set_multicast_list() commented out in fcc_enet.c

Hi all,

I've noticed that in arch/ppc/8260_io/fcc_enet.c at the very top of the
function set_multicast_list() there is a return statement - effectively
commenting out the rest of the code.  There is no comment saying why it
is there.

An effect of this is that you cannot put the device in promiscuous mode,
which is required when adding it to a bridge.

Please can anyone say why this "return;" is there?

Thanks,

Alex

PS I'm using denx's linuxppc_devel tagged 2005-03-06, which is based
on linux-2.4.25.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
