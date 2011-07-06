Return-Path: <anton@samba.org>
Date: Wed, 6 Jul 2011 17:51:36 +1000
From: Anton Blanchard <anton@samba.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 2/2]: powerpc/pseries/hvconsole: Fix dropped console output
Message-ID: <20110706175136.2c00b292@kryten>
In-Reply-To: <20110705142844.GA2514@linux.vnet.ibm.com>
References: <20110704205738.742e56d0@kryten>
	<1309787787.14501.268.camel@pasglop>
	<20110704142429.GA2147@linux.vnet.ibm.com>
	<CAOZdJXW0Lota0ZuEnOHhsU93v7WmvYztEMyfg+UsMKxFdoXNXQ@mail.gmail.com>
	<1309846963.14501.270.camel@pasglop>
	<20110705142844.GA2514@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tabi Timur-B04825 <B04825@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"borntraeger@de.ibm.com" <borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Return -EAGAIN when we get H_BUSY back from the hypervisor. This
makes the hvc console driver retry, avoiding dropped printks.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: linux-powerpc/arch/powerpc/platforms/pseries/hvconsole.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/hvconsole.c	2011-07-06 17:11:33.799095935 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/hvconsole.c	2011-07-06 17:11:47.499332962 +1000
@@ -73,7 +73,7 @@ int hvc_put_chars(uint32_t vtermno, cons
 	if (ret == H_SUCCESS)
 		return count;
 	if (ret == H_BUSY)
-		return 0;
+		return -EAGAIN;
 	return -EIO;
 }
 
