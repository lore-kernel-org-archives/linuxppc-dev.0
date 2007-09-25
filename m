Return-Path: <fenkes@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 984F9DDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 22:14:01 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l8PCDdOK512600
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 12:13:39 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8PCDdhs3096816
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 13:13:39 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8PCDX6q003119
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 13:13:33 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] ibmebus: More speaking error return code in
	ibmebus_store_probe()
References: <200709251410.29780.fenkes@de.ibm.com>
In-Reply-To: <200709251410.29780.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Tue, 25 Sep 2007 14:13:26 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251413.26873.fenkes@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jan-Bernd Themann <themann@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 arch/powerpc/kernel/ibmebus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 379472f..8c08a98 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -270,10 +270,10 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
 		return -ENOMEM;
 
 	if (bus_find_device(&ibmebus_bus_type, NULL, path,
-			     ibmebus_match_path)) {
+			    ibmebus_match_path)) {
 		printk(KERN_WARNING "%s: %s has already been probed\n",
 		       __FUNCTION__, path);
-		rc = -EINVAL;
+		rc = -EEXIST;
 		goto out;
 	}
 
-- 
1.5.2
