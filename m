Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8DAA9DDF2B
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 17:59:59 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id A351BC8C21E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 00:59:58 -0700 (PDT)
Date: Mon, 05 May 2008 00:59:58 -0700 (PDT)
Message-Id: <20080505.005958.186160264.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: on the topic of of_device resources...
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Since it came to my attention due to the build error fix
I just had to fix, I figured I'd mention some things.

Right now, powerpc and sparc differ in how they resolve
interrupts and resources.

Powerpc uses an on-demand model, whereas Sparc pre-resolves
everything at bootup when parsing the OF tree.

Unfortunately they operate on differing objects too, otherwise I could
provide routines to match the interfaces that powerpc OF drivers want
:-/

Powerpc drivers want device_node objects, whereas sparc roots all
driver usable objects under of_platform_bus using of_device objects
(which point to the device_node if the driver needs that).

Inside of the of_device is where we hang the fully resolved resources
and interrupts.

I'd like to see consolidation in this area, and in return I'll be
compiling all of your PPC_OF devices in my allmodconfig builds on
sparc :-)
