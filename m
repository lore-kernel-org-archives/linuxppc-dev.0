Return-Path: <SSparks@aclara.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) by ozlabs.org (Postfix) with ESMTP id 6B9CDB7D15
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Apr 2010 23:11:33 +1000 (EST)
Received: from mail167-tx2 (localhost.localdomain [127.0.0.1])	by
	mail167-tx2-R.bigfish.com (Postfix) with ESMTP id 19D071758895	for
	<linuxppc-dev@ozlabs.org>; Tue, 13 Apr 2010 13:11:30 +0000 (UTC)
Received: from TX2EHSMHS035.bigfish.com (unknown [10.9.14.251])	by
	mail167-tx2.bigfish.com (Postfix) with ESMTP id 7F97C8380FE	for
	<linuxppc-dev@ozlabs.org>; Tue, 13 Apr 2010 13:11:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Upgrade to 2.6.26 results in Oops during request_irq
Date: Tue, 13 Apr 2010 08:10:37 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A835560860170785F@mail.twacs.com>
In-Reply-To: <6011A7C9CD0EE74792C3ED2A83556086B67190@mail.twacs.com>
References: <6011A7C9CD0EE74792C3ED2A83556086B67190@mail.twacs.com>
From: "Sparks, Sam" <SSparks@aclara.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From: Sparks, Sam
>Sent: Thursday, April 08, 2010 4:15 PM
>
>Howdy All,
>
>I have (almost) successfully upgraded from Linux 2.6.22 to 2.6.26 (both
>downloaded from debian) on my mpc8347 powerpc, but I think I may be
>missing a required change to my dts regarding the IPIC or maybe a
change
>in how my driver requests IRQs.
>
>I have several modules that are maintained outside the kernel tree, and
>all but one is working correctly. The offending driver is attempting to
>register IRQ 23, and is accessing an invalid memory location. I am
>currently getting the following stack dump:

Aha! I have found that change that caused my module to break:
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg09748.html

This patch modified ipic_set_irq_type to override the handle_irq
function pointer.

Do I need to register a new function to handle falling edge triggered
external interrupts? It appears the default is NULL.

--Sam
