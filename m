Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id 5990767A6B
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2005 14:58:13 +1100 (EST)
Date: 14 Mar 2005 03:51:31 -0000
Message-ID: <20050314035131.3098.qmail@kunk.qbjnet.com>
From: linuxppcdev@qbjnet.com
To: linuxppc-dev@ozlabs.org
Subject: DMA appears broken in 2.6.11 for Mac 7200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just updated a couple of old Mac 7200 (601) boxen and ran into trouble with
the ide driver and a promise PDC20267 card. 

The very same drives and card work fine on a 9500 but hang on a 7200. If
I set the kernel arg ide=nodma I get in the dmesg:
ide_setup: ide=nodma : Prevented DMA
and the 7200 boots and runs fine.

Another suspect, the mace ethernet driver (which also appears to use DMA)
doesn't work on the 7200 with 2.6.11 but does with 2.4.28 and it works 
with 2.6.11 on the 9500.

Finally, I don't think this is related to DMA however the OF frame buffer
driver, if compiled into the kernel, kills the platinumfb driver which wasn't
a problem in the 2.4 kernels either (I get a blank screen but the machine
keeps running).

Bob
