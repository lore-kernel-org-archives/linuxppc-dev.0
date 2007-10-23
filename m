Return-Path: <michael@ellerman.id.au>
Subject: [PATCH] Allow sysfs_remove_group() to be called on non-added groups
From: Michael Ellerman <michael@ellerman.id.au>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20071023032836.GC7486@kroah.com>
References: <096fae99bd9797c5484ed8f4b87b82e58737cdc0.1189657514.git.michael@ellerman.id.au>
	<dc1166600710221902t1383ff88q421a17b1ff1382cd@mail.gmail.com>
	<20071023032836.GC7486@kroah.com>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 14:18:17 +1000
Message-Id: <1193113097.2898.14.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It would be nice to be able to do:

for_each_thing(thing) {
 	error = sysfs_create_group(&thing->kobj, attrs);
 	if (error) {
 		for_each_thing(thing)
 			sysfs_remove_group(&thing->kobj, attrs);
		return error;
	}
}

But there's a BUG_ON() in sysfs_remove_group() which hits if the attributes
were never added.

As discussed here ...
http://ozlabs.org/pipermail/cbe-oss-dev/2007-July/002774.html

.. we should just return in that case instead of BUG'ing.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 fs/sysfs/group.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index f318b73..a256775 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -73,7 +73,8 @@ void sysfs_remove_group(struct kobject * kobj,
 
 	if (grp->name) {
 		sd = sysfs_get_dirent(dir_sd, grp->name);
-		BUG_ON(!sd);
+		if (!sd)
+			return;
 	} else
 		sd = sysfs_get(dir_sd);
 
-- 
1.5.1.3.g7a33b
