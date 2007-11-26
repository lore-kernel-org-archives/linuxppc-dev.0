Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2314DDF96
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 03:09:04 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAQG8sJO010806
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 11:08:54 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAQG8j7W067750
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 09:08:46 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAQG8ids007167
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 09:08:44 -0700
Date: Mon, 26 Nov 2007 10:08:43 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: Sequoia EMAC only works if u-boot initializes it?
Message-ID: <20071126100843.2ee3e0b9@weaponx>
In-Reply-To: <474AED67.4020006@harris.com>
References: <474AED67.4020006@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 26 Nov 2007 10:59:35 -0500
"Steven A. Falco" <sfalco@harris.com> wrote:

> I have noticed odd behavior on a Sequoia board.  Kernel is built from 
> DENX git, ARCH=powerpc, 2.6.23.1.
> 
> Sequence that works:
> 1) In u-boot, do "dhcp" (this initializes the PHY)
> 2) Boot linux from flash
> 3) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
> Ethernet is now functional, and I can ping the Sequoia (and it can ping 
> my host)
> 
> Sequence that does not work:
> 1) Boot linux from flash without letting u-boot touch eth0
> 2) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
> Ethernet appears to come up, but it is not functional.  I.e. I get 
> "eth0: link is up, 100 FDX, pause enabled" but I cannot ping the board, 
> and the board cannot ping my host.
> 
> So, the kernel appears to be missing some initialization that u-boot 
> provides.

There are some PHY patches from Valentine that Ben needs to send to
Jeff Garzik.

josh
