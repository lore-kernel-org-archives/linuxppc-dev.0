Return-Path: <Sylvain.Joyeau@thomson.net>
Received: from dmzraw3.extranet.thmulti.com (dmzraw3.extranet.thmulti.com
	[141.11.234.71]) by ozlabs.org (Postfix) with ESMTP id C00AF679F5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Mar 2006 23:23:54 +1100 (EST)
Received: from boulvss1.eu.thmulti.com (unknown [141.11.234.35])
	by dmzraw3.extranet.thmulti.com (Postfix) with ESMTP id 3BAE212F5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Mar 2006 12:23:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by boulvss1.eu.thmulti.com (Postfix) with ESMTP id 9C9F7121A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Mar 2006 12:23:36 +0000 (GMT)
Received: from boulvss1.eu.thmulti.com ([127.0.0.1])
	by localhost (boulvss1.eu.thmulti.com [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 13455-01 for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Mar 2006 12:23:34 +0000 (GMT)
Received: from boulsmailbh01.eu.thmulti.com (boulsmailbh01.eu.thmulti.com
	[141.11.192.5])
	by boulvss1.eu.thmulti.com (Postfix) with ESMTP id 912DB1220
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Mar 2006 12:23:34 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC85xx TSEC performance limits
Date: Wed, 1 Mar 2006 13:23:49 +0100
Message-ID: <9C1918067C3BC14C9C351C206D8A84370398A987@rennsmail03.eu.thmulti.com>
From: "Joyeau Sylvain" <Sylvain.Joyeau@thomson.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Does anybody already succeeded in getting full TX bandwidth on a TSEC
interface, transmitting 1500 bytes frames at netdev level (ie calling
directly dev_queue_xmit(skb)) for instance ?

With default Gianfar driver parameters, I can transmit only around
870Mb/s (while reception side is idle). The other TSEC interface is used
only to control a telnet terminal (~1Kb/s), the CPU is idle 60%,
6000irq/s.

I must decrease TX threshold value from 1024 to 128 to get 960Mb/s.

The problem is that decreasing the TX threshold under 512 bytes has a
dramatic side effect: the Gianfar driver generates "TX underrun" events
as soon as  I start, in parallel, a DMA transfer from memory to memory.
Rather disappointing behavior from a PQ3@825MHz :-(

Any idea how to get full TX bandwidth _without_ modifying this
parameter?

Thanks.

--
sylvain
