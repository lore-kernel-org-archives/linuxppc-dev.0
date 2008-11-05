Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 6E375DDE03
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 10:17:47 +1100 (EST)
Date: Wed, 5 Nov 2008 15:17:44 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>,
	Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>
Subject: Re: [RFC v3] net: add PCINet driver
Message-ID: <20081105231744.GB17821@ovro.caltech.edu>
References: <20081105212225.GA17821@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081105212225.GA17821@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 05, 2008 at 01:22:25PM -0800, Ira Snyder wrote:

Despite my best efforts at testing this version, a bug slipped past.
There is some problem with this driver, nfsroot, and Linux routing. If
you do not apply the fix below, udp packets sent by the nfsroot code
have corrupted checksums after they get routed across the network to
another host.

If I boot both hosts to Linux via other means, the driver works fine
with no issues. It only happens for nfsroot.

If I run an nfs server on the PCINET_HOST computer, removing the
routing, it also works fine.

Remove the following line from pcinet_host.c and pcinet_fsl.c:
ndev->features         |= NETIF_F_NO_CSUM; /* No checksum needed */

In case anyone knows offhand what might be causing this, my setup is as
follows:

   cPCI Crate
|-------------------------|
| PCINET_FSL              |
|-------------------------|
|          ^ 10.0.0.2     |
|          |              |
| PCINet Driver Link here |
|          |              |
|          v 10.0.0.1     |
|-------------------------|
| PCINET_HOST             |
|-------------------------|
           ^ 192.168.17.14
           |
 Normal ethernet link here
           |
           v
|-------------------------|
| Ethernet switch         |
|-------------------------|
           ^
           |
 Normal ethernet link here
           |
           v 192.168.17.59
|-------------------------|
| NFS Server              |
|-------------------------|


Ira
