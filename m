Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 07D5FDDE1F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 02:15:31 +1100 (EST)
Message-ID: <47A33018.2090606@ru.mvista.com>
Date: Fri, 01 Feb 2008 17:43:36 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Laurent Lagrange <lagrange@fr.oleane.com>
Subject: Re: PCI configuration with multiple PCI controllers
References: <000001c864df$63b833c0$a501a8c0@GEGE6600V>
In-Reply-To: <000001c864df$63b833c0$a501a8c0@GEGE6600V>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Laurent Lagrange wrote:

> I have a MPC8641 based board. I try to use the two PCIe controllers. My
> firmware configures (physically) the PCI buses as follow:

> ------------------+
> MPC8641 PCIe 1	|	bus 1		+--------------+
> 			| --------------> | PCI device 0 |
> 	BUS 0		|			+--------------+
> - - - - - - - - - +
> MPC8641 PCIe 2	|	bus 3		+--------------+
> 			| --------------> | PCI device 1 |
> 	BUS 2		|			+--------------+
> ------------------+

> I launch the Linux image (2.6.23.9). During the Kernel PCI configuration,
> buses behind the 2nd MPC8641 PCIe are skipped because its primary bus don't
> start at bus number 0. The kernel reconfigure the primary bus number of the
> MPC8641 PCIe 2 controller from 2 to 0.

    Hm...

> I can patch the kernel to work with my firmware but I don't know if my PCI
> configuration is the good one.

> What is the common way to configure the PCI for Linux when a new controller
> is found: start the bus number to 0 or to the last bus number + 1?

    The latter. Otherwise it just won't work.

WBR, Sergei
