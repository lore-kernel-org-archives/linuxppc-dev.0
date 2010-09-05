Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EE805B70EB
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Sep 2010 04:59:45 +1000 (EST)
From: Julia Lawall <julia@diku.dk>
To: Olof Johansson <olof@lixom.net>
Subject: [PATCH 4/8] drivers/i2c/busses/i2c-pasemi.c: Fix unsigned return type
Date: Sun,  5 Sep 2010 21:00:22 +0200
Message-Id: <1283713226-8429-5-git-send-email-julia@diku.dk>
In-Reply-To: <1283713226-8429-1-git-send-email-julia@diku.dk>
References: <1283713226-8429-1-git-send-email-julia@diku.dk>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function has an unsigned return type, but returns a negative constant
to indicate an error condition.  The result of calling the function is
always stored in a variable of type (signed) int, and thus unsigned can be
dropped from the return type.

A sematic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@exists@
identifier f;
constant C;
@@

 unsigned f(...)
 { <+...
*  return -C;
 ...+> }
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/i2c/busses/i2c-pasemi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index 4174101..837b8c1 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -88,7 +88,7 @@ static void pasemi_smb_clear(struct pasemi_smbus *smbus)
 	reg_write(smbus, REG_SMSTA, status);
 }
 
-static unsigned int pasemi_smb_waitready(struct pasemi_smbus *smbus)
+static int pasemi_smb_waitready(struct pasemi_smbus *smbus)
 {
 	int timeout = 10;
 	unsigned int status;
