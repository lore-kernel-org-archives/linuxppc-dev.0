Return-Path: <fenkes@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C10C8DE3B3
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 19:46:43 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8Q9kaBE074954
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 09:46:36 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8Q9kada1667104
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 11:46:36 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8Q9kZ3X031086
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 11:46:36 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/5] ibmebus: More speaking error return code in
	ibmebus_store_probe()
References: <200709261143.24735.fenkes@de.ibm.com>
In-Reply-To: <200709261143.24735.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Wed, 26 Sep 2007 11:46:34 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261146.35466.fenkes@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
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
index c1e2963..0bd186c 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -268,10 +268,10 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
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
