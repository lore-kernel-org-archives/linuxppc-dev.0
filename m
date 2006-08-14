Return-Path: <ossthema@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8190567BE1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 02:28:35 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7EGSVOl048794
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 16:28:31 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7EGUM7j125744
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 17:30:22 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7EGSVIk025713
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 17:28:31 +0100
Message-ID: <44E0A4AE.3080600@de.ibm.com>
Date: Mon, 14 Aug 2006 18:28:30 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Subject: [PATCH 0/7] ehea: IBM eHEA Ethernet Device Driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

this is the latest version of the IBM eHEA Ethernet Device Driver.
We got a lot of very helpful comments and modified our driver as we
said in our replies.

Thanks for your efforts so far!

Things we are still working on:
- Debug output rework (EDEB, remove unimportant debug information,
   using standard kernel mechanisms where possible)
- performance improvements on SMP systems
- error recovery

Thanks,
Jan-Bernd

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Changelog-by:  Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set http://www.spinics.net/lists/netdev/msg10997.html

Changelog:

- Proper use of alloc_etherdev() / netdev_priv()
- Several memory leeks fixed
- Split big functions
- 64K page support
- Code cleanup (removed unnecessary casts, unused defines,
   ethtool stub functions removed, renaming prefixes, comments, ...)


  drivers/net/Kconfig             |    6
  drivers/net/Makefile            |    1
  drivers/net/ehea/Makefile       |    7
  drivers/net/ehea/ehea.h         |  470 +++++++
  drivers/net/ehea/ehea_ethtool.c |  271 ++++
  drivers/net/ehea/ehea_hcall.h   |   52
  drivers/net/ehea/ehea_hw.h      |  315 ++++
  drivers/net/ehea/ehea_main.c    | 2672 ++++++++++++++++++++++++++++++++++++++++
  drivers/net/ehea/ehea_phyp.c    | 1087 ++++++++++++++++
  drivers/net/ehea/ehea_phyp.h    |  562 ++++++++
  drivers/net/ehea/ehea_qmr.c     |  757 +++++++++++
  drivers/net/ehea/ehea_qmr.h     |  392 +++++
  12 files changed, 6592 insertions(+)
