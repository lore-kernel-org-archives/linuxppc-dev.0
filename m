Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>
Subject: [PATCH] spufs: fix  support for read/write on cntl
Date: Tue, 10 Oct 2006 10:27:29 +0200
References: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3E7@jptkyxms38.jp.sony.com>
In-Reply-To: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3E7@jptkyxms38.jp.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610101027.30329.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>

This fixes a memory leak introduced by "spufs: add support
for read/write oncntl", which was missing a call to simple_attr_close.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

On Tuesday 10 October 2006 08:49, Noguchi, Masato wrote:
> Oops,
> I'm so sorry. I mistake to send wrong patch.

Ok, no worries. Paul, please use this patch instead.

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -246,6 +246,7 @@ static int spufs_cntl_open(struct inode 
 
 static struct file_operations spufs_cntl_fops = {
 	.open = spufs_cntl_open,
+	.release = simple_attr_close,
 	.read = simple_attr_read,
 	.write = simple_attr_write,
 	.mmap = spufs_cntl_mmap,
