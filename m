Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6132B7BD9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 13:41:17 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nB42fC99004570
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 20:41:13 -0600
Subject: [Fwd: [PATCH] therm_adt746x: Don't access non-existing register]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/mixed; boundary="=-jZQoKJJPfpqAGU5OknZd"
Date: Fri, 04 Dec 2009 13:41:06 +1100
Message-ID: <1259894466.2076.1247.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-jZQoKJJPfpqAGU5OknZd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-jZQoKJJPfpqAGU5OknZd
Content-Disposition: inline
Content-Description: Forwarded message - [PATCH] therm_adt746x: Don't
 access non-existing register
Content-Type: message/rfc822

Return-Path: <linux-kernel-owner+benh=40kernel.crashing.org-S1752034AbZLBITs@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0
 tests=AWL,BAYES_00,FORGED_RCVD_HELO autolearn=unavailable version=3.1.9
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167]) by
 gate.crashing.org (8.14.1/8.13.8) with ESMTP id nB28K2jw029035 for
 <benh@kernel.crashing.org>; Wed, 2 Dec 2009 02:20:04 -0600
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752034AbZLBITs (ORCPT <rfc822;benh@kernel.crashing.org>); Wed, 2 Dec 2009
 03:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id
 S1751067AbZLBITs (ORCPT <rfc822;linux-kernel-outgoing>); Wed, 2 Dec 2009
 03:19:48 -0500
Received: from bamako.nerim.net ([62.4.17.28]:59080 "EHLO bamako.nerim.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1750894AbZLBITr
 (ORCPT <rfc822;linux-kernel@vger.kernel.org>); Wed, 2 Dec 2009 03:19:47
 -0500
Received: from localhost (localhost [127.0.0.1]) by bamako.nerim.net
 (Postfix) with ESMTP id A424939DEFA; Wed,  2 Dec 2009 09:19:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from bamako.nerim.net ([127.0.0.1]) by localhost
 (bamako.nerim.net [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id
 XlC-ZSpy63cA; Wed,  2 Dec 2009 09:19:50 +0100 (CET)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
 by bamako.nerim.net (Postfix) with ESMTP id 6D16A39DE46; Wed,  2 Dec 2009
 09:19:50 +0100 (CET)
Date: Wed, 2 Dec 2009 09:19:51 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Michel =?ISO-8859-15?B?RORuemVy?= <michel@daenzer.net>, "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, Colin Leroy <colin@colino.net>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] therm_adt746x: Don't access non-existing register
Message-ID: <20091202091951.5ec6bb83@hyperion.delvare>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit

Michel, Darrick,

Apparently you are using the therm_adt746x driver, so maybe you would
be interested in testing and carrying the following patch. I've sent it
to Colin Leroy, who is listed as the maintainer for this driver, 1.5
month ago, but did not hear back.

* * * * *

The ADT746x don't have any register at sub-address 0, so better use an
existing register for the initial test read.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Tested-by: Tim Shepard <shep@alum.mit.edu>
Cc: Colin Leroy <colin@colino.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 drivers/macintosh/therm_adt746x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.32-rc4.orig/drivers/macintosh/therm_adt746x.c	2009-10-12 11:53:59.000000000 +0200
+++ linux-2.6.32-rc4/drivers/macintosh/therm_adt746x.c	2009-10-14 17:27:46.000000000 +0200
@@ -387,7 +387,7 @@ static int probe_thermostat(struct i2c_c
 	i2c_set_clientdata(client, th);
 	th->clt = client;
 
-	rc = read_reg(th, 0);
+	rc = read_reg(th, CONFIG_REG);
 	if (rc < 0) {
 		dev_err(&client->dev, "Thermostat failed to read config!\n");
 		kfree(th);


-- 
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--=-jZQoKJJPfpqAGU5OknZd--
