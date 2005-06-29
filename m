Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0E06C67B68
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 02:48:55 +1000 (EST)
Date: Wed, 29 Jun 2005 09:48:52 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Scott Coulter <scott.coulter@cyclone.com>
Message-ID: <20050629164852.GA17313@gate.ebshome.net>
References: <43EB80E07C42E1408726E4905FB96B044402F5@CYBORG3.cyclone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43EB80E07C42E1408726E4905FB96B044402F5@CYBORG3.cyclone.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 440GX EMAC driver hang?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 29, 2005 at 09:40:34AM -0400, Scott Coulter wrote:
> Hi,
> 
> I am doing a Linux 2.6.11.11 port for a CPCI board with a 440GX
> processor on it.  Previously, I had successfully ported 2.6.11.11 to the
> board's predecessor running on a 440GP processor.  Due to limitations in
> this version of the PCB, EMAC ports 2 and 3 are not connected.  The
> standalone kernel comes up and gets into a BusyBox shell.  When I try to
> ifconfig the eth0 interface, the messages "eth0: Link is Up" and "eth0:
> Speed: 100, Full duplex." are displayed and then the target hangs.  I
> used the OCOTEA port as a pattern for my 440GP->440GX conversion.  The
> PHYs which are connected to EMAC ports 0 and 1 are the same PHYs as on
> the 440GP board (running in RMII mode).  I have tried to use the
> function "ocp_remove_one_device" to whack EMAC2 and EMAC3.  I am pretty
> sure that the removal worked as I no longer see init messages for those
> EMACs (previously I saw all four devices get initialized).  The MAL
> reports that it has "Initialized, 4 tx channels, 4 rx channels."  I used
> the function "ibm440gx_set_eth_grp" to force the Ethernets to both group
> 0 and group 1 configurations.  So far, nothing has worked.  Can anyone
> think of anything obvious that I am missing?  I know that the Ethernet
> ports are functional as I used TFTP with our ROM monitor package to
> download the zImage file.

You can try using 4xx NAPI EMAC driver I wrote some time ago.
It can be found at http://kernel.ebshome.net/ (there is a patch and 
GIT tree which is kept up to date).

You can enable debug and mail me trace log privately, and maybe I can 
help you debug your problem.

-- 
Eugene
