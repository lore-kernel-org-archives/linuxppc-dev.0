Date: Sat, 20 Mar 2004 14:43:16 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org
Subject: keywest bugfix
Message-ID: <20040320134316.GA1276@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following patch fixes a deadlock in I2C probing:

===== drivers/i2c/busses/i2c-keywest.c 1.12 vs edited =====
--- 1.12/drivers/i2c/busses/i2c-keywest.c	Mon Mar 15 11:25:23 2004
+++ edited/drivers/i2c/busses/i2c-keywest.c	Sat Mar 20 14:33:07 2004
@@ -608,6 +608,7 @@
 	}
 #endif /* POLLED_MODE */

+	pmac_low_i2c_unlock(np);
 	dev_set_drvdata(dev, iface);

 	for (i=0; i<nchan; i++) {
@@ -645,7 +646,6 @@
 	printk(KERN_INFO "Found KeyWest i2c on \"%s\", %d channel%s, stepping: %d bits\n",
 		np->parent->name, nchan, nchan > 1 ? "s" : "", bsteps);

-	pmac_low_i2c_unlock(np);
 	return 0;
 }


Without this patch, the deadlock occurs in the following situation:

- keywest holds the pmac_low_i2c_lock while registering the i2c adapter.
- i2c_add_adapter() notifies registered drivers by calling
driver->attach_adapter().
- a driver might access the i2c bus from attach_adapter() which
deadlocks since all xfer routines take the lock.

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
