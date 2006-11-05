Return-Path: <hnguyen@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90B2F67CC2
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 07:46:33 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kA5KkRSO233148
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:46:27 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA5Kn8HJ1978438
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:49:08 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA5Kk9Wq028084
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:46:10 GMT
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19 3/4] ehca: Kconfig: activate scaling code as default to
	prevent drop packets (UD)
Date: Sun, 5 Nov 2006 21:42:20 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sykTF3lLtF5NXBG"
Message-Id: <200611052142.20577.hnguyen@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, raisch@de.ibm.com, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_sykTF3lLtF5NXBG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Roland!
Here is a small patch of ehca's Kconfig that activates scaling code as default.
After several measurements we saw that this feature prevents drop packets (UD)
in stress situation. Thus, enabling it helps to improve ehca's bandwidth through
ipoib.
Thanks!
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 Kconfig |    1 +
 1 files changed, 1 insertion(+)


diff --git a/drivers/infiniband/hw/ehca/Kconfig b/drivers/infiniband/hw/ehca/Kconfig
index 922389b..727b10d 100644
--- a/drivers/infiniband/hw/ehca/Kconfig
+++ b/drivers/infiniband/hw/ehca/Kconfig
@@ -10,6 +10,7 @@ config INFINIBAND_EHCA
 config INFINIBAND_EHCA_SCALING
  bool "Scaling support (EXPERIMENTAL)"
  depends on IBMEBUS && INFINIBAND_EHCA && HOTPLUG_CPU && EXPERIMENTAL
+ default y
  ---help---
  eHCA scaling support schedules the CQ callbacks to different CPUs.
 

--Boundary-00=_sykTF3lLtF5NXBG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="roland_svnehca_0018_kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="roland_svnehca_0018_kconfig.patch"

diff --git a/drivers/infiniband/hw/ehca/Kconfig b/drivers/infiniband/hw/ehca/Kconfig
index 922389b..727b10d 100644
--- a/drivers/infiniband/hw/ehca/Kconfig
+++ b/drivers/infiniband/hw/ehca/Kconfig
@@ -10,6 +10,7 @@ config INFINIBAND_EHCA
 config INFINIBAND_EHCA_SCALING
 	bool "Scaling support (EXPERIMENTAL)"
 	depends on IBMEBUS && INFINIBAND_EHCA && HOTPLUG_CPU && EXPERIMENTAL
+	default y
 	---help---
 	eHCA scaling support schedules the CQ callbacks to different CPUs.
 

--Boundary-00=_sykTF3lLtF5NXBG--
