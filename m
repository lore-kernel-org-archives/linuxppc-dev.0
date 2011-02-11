Return-Path: <meador_inge@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C0684B718E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 08:19:58 +1100 (EST)
Message-ID: <4D55A7F7.5090700@mentor.com>
Date: Fri, 11 Feb 2011 15:19:51 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC] Inter-processor Mailboxes Drivers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: openmcapi-dev@googlegroups.com, "Blanchard,
	Hollis" <Hollis_Blanchard@mentor.com>,
	Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I am currently working on building AMP systems using OpenMCAPI
(https://bitbucket.org/hollisb/openmcapi/wiki/Home) as the
inter-processor communication mechanism.  With OpenMCAPI we, of course,
need a way to send messages to various cores.  On some Freescale PPC
platforms (e.g. P1022DS, MPC8572DS), we have been using message
registers to do this work.  Recently, I was looking at the OMAP4
mailboxes to gear up for moving into ARM based platforms.

With that, I noticed 'arch/arm/plat-omap/mailbox.c'.  This is very
specific to the OMAP4 boards.  I am looking at designing a new set of
drivers to expose a mailbox service to userspace that will be used
for inter-processor communication.  This would entail the traditional
generic/specific driver split:

     1. Hardware specific bits somewhere under '.../arch/*'.  Drivers
        for the MPIC message registers on Power and OMAP4 mailboxes, for
        example.
     2. A higher level driver under '.../drivers/mailbox/*'.  That the
        pieces in (1) would register with.  This piece would expose the
        main kernel API.
     3. Userspace interfaces for accessing the mailboxes.  A
        '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.

Now I have the following questions:

     1. Do others see value in this?
     2. Does something like this already exist?
     3. Is someone else already working on this?

Any feedback will be greatly appreciated.

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
