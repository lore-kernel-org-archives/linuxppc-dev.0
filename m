Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:49 -0500 (CDT)
Subject: [PATCH 05/11] dtc: clean up grow_data_for()
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-05.miltonm@bga.com>
In-Reply-To: <dtc-5-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the grow_data_for function to copy struct data and
modifiy the fields it is updating instead of storing all
fields individually to a stack allocated struct.

This reduces maintence for future enhancements as now all
instances of struct data are created by modifying a copy
of an existing struct data or directly copying empty_data.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
It took me a bit of time to find the source of the
uninitialized pointer that was causing my changes
to segfault.

diff --git a/data.c b/data.c
index 5d7db17..3d68792 100644
--- a/data.c
+++ b/data.c
@@ -57,6 +57,8 @@ struct data data_grow_for(struct data d,
 	if (xlen == 0)
 		return d;
 
+	nd = d;
+
 	newsize = xlen;
 
 	while ((d.len + xlen) > newsize)
@@ -64,8 +66,6 @@ struct data data_grow_for(struct data d,
 
 	nd.asize = newsize;
 	nd.val = xrealloc(d.val, newsize);
-	nd.len = d.len;
-	nd.refs = d.refs;
 
 	assert(nd.asize >= (d.len + xlen));
 
