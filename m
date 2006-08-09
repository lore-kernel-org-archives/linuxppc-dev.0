Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5E82767B32
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 18:37:56 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.7/8.13.7) with ESMTP id k798bps8055364
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 08:37:51 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k798fUhW150940
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 10:41:30 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k798bowb020625
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 10:37:51 +0200
Message-ID: <44D99EDE.70202@de.ibm.com>
Date: Wed, 09 Aug 2006 10:37:50 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Subject: [PATCH 0/6] ehea: IBM eHEA Ethernet Device Driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

this is the latest version of the IBM eHEA Ethernet Device Driver.
It supports a new IBM ethernet chip on System p.
The driver has been posted on the netdev mailing list since the
beginning of June and we got little feedback so far.

Main functionality including broadcast, multicast, VLAN and most
parts of ethtool work.

Things we are still working on:
- performance improvements on SMP systems
- error recovery

In order to get this code ready for kernel inclusion we do highly
appreciate your feedback.

The patch series consists of 6 patches
01: interfaces to network stack
02: pHYP interface
03: queue management
04: header files
05: makefile
06: Kernel build (Kconfig / Makefile)

Thanks,
Jan-Bernd

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Changelog-by:  Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set http://www.spinics.net/lists/netdev/msg06715.html
Changelog:

- Memory Region struct introduced
- Shared Memory Regions for send and receive path included
- Memory Region registeration now processes 512 pages per H_CALL
-.RQ2_PKT_SIZE changed to 1522 bytes
- NET_IP_ALIGN included
- Adaption to latest kernel (gso_size)
- minor changes (coding style, code cleanup)


  drivers/net/Kconfig             |    6
  drivers/net/Makefile            |    1
  drivers/net/ehea/Makefile       |    7
  drivers/net/ehea/ehea.h         |  452 ++++++
  drivers/net/ehea/ehea_ethtool.c |  325 ++++
  drivers/net/ehea/ehea_hcall.h   |   52
  drivers/net/ehea/ehea_hw.h      |  319 ++++
  drivers/net/ehea/ehea_main.c    | 2738 ++++++++++++++++++++++++++++++++++++++++
  drivers/net/ehea/ehea_phyp.c    | 1130 ++++++++++++++++
  drivers/net/ehea/ehea_phyp.h    |  573 ++++++++
  drivers/net/ehea/ehea_qmr.c     |  798 +++++++++++
  drivers/net/ehea/ehea_qmr.h     |  381 +++++
  12 files changed, 6782 insertions(+)
