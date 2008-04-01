Return-Path: <jens@de.ibm.com>
From: Jens Osterkamp <jens@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] RTAS - adapt procfs interface
Date: Tue, 1 Apr 2008 15:12:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804011512.20834.jens@de.ibm.com>
Cc: maxim@de.ibm.com, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

rtas_flash was broken since 2.6.24-rc5. This patch fixes it.
I think this is a good bugfix candidate for 2.6.25.

Jens

---

From: Maxim Shchetynin <maxim@de.ibm.com>

Handling of the proc_dir_entry->count has being changed in 2.6.24-rc5.
After this change the default value for pde->count is 1 and not 0 as it
was in earlier kernels. Therefore, if we want to check wether our procfs
file is already opened (already in use), we have to check if pde->count
is not greater than 2 but not 1.

Signed-off-by: Maxim Shchetynin <maxim@de.ibm.com>
Signed-off-by: Jens Osterkamp <jens@de.ibm.com>

Index: linux-2.6/arch/powerpc/kernel/rtas_flash.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/rtas_flash.c
+++ linux-2.6/arch/powerpc/kernel/rtas_flash.c
@@ -356,7 +356,7 @@ static int rtas_excl_open(struct inode *
 
 	/* Enforce exclusive open with use count of PDE */
 	spin_lock(&flash_file_open_lock);
-	if (atomic_read(&dp->count) > 1) {
+	if (atomic_read(&dp->count) > 2) {
 		spin_unlock(&flash_file_open_lock);
 		return -EBUSY;
 	}
