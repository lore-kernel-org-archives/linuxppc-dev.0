Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:22:29 -0500
To: paulus@ozlabs.org
Subject: [4/10]: Quiet VETH version printk
Message-ID: <20060412202229.GK19464@pb15.lixom.net>
References: <20060412201823.GG19464@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412201823.GG19464@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ibmveth_printk() is only used to print the driver version when the module
initializes, which means on all machines as long as it's compiled in.

If it's really only needed for debugging, boot with loglevel=8, or get
it from dmesg instead.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6/drivers/net/ibmveth.c
===================================================================
--- 2.6.orig/drivers/net/ibmveth.c
+++ 2.6/drivers/net/ibmveth.c
@@ -61,7 +61,7 @@
 #undef DEBUG
 
 #define ibmveth_printk(fmt, args...) \
-  printk(KERN_INFO "%s: " fmt, __FILE__, ## args)
+  printk(KERN_DEBUG "%s: " fmt, __FILE__, ## args)
 
 #define ibmveth_error_printk(fmt, args...) \
   printk(KERN_ERR "(%s:%3.3d ua:%x) ERROR: " fmt, __FILE__, __LINE__ , adapter->vdev->unit_address, ## args)
