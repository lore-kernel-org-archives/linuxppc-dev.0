Return-Path: <nacc@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 539B21007DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:06:44 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FI4ZG0011269
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:04:35 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FI6bMb116518
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:06:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8FI6Z5p006017
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:06:36 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 06/15] pseries/dlpar: use kmemdup
Date: Wed, 15 Sep 2010 11:05:49 -0700
Message-Id: <1284573958-8397-7-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: Gautham R Shenoy <ego@in.ibm.com>, Milton Miller <miltonm@bga.com>,
	Julia Lawall <julia@diku.dk>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While looking at some code paths I came across this code that zeros
memory then copies over the entire length.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 72d8054..6004c81 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -55,13 +55,12 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
 
 	prop->length = ccwa->prop_length;
 	value = (char *)ccwa + ccwa->prop_offset;
-	prop->value = kzalloc(prop->length, GFP_KERNEL);
+	prop->value = kmemdup(value, prop->length, GFP_KERNEL);
 	if (!prop->value) {
 		dlpar_free_cc_property(prop);
 		return NULL;
 	}
 
-	memcpy(prop->value, value, prop->length);
 	return prop;
 }
 
-- 
1.7.0.4
