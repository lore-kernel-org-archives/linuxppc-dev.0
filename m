Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 2F430DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 07:21:11 +1000 (EST)
Date: Fri, 10 Aug 2007 23:21:29 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTC 1.0.0 Release
Message-ID: <20070810212129.GA16948@aepfle.de>
References: <E1IJIsf-0003VN-RE@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <E1IJIsf-0003VN-RE@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 09, Jon Loeliger wrote:

> As usual, please let me know of any issues with it.

tests/truncated_property.c:45: warning: 'err' is used uninitialized in this function

(untested patch)

---
 tests/truncated_property.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/tests/truncated_property.c
+++ b/tests/truncated_property.c
@@ -33,7 +33,6 @@ int main(int argc, char *argv[])
 {
 	void *fdt = &_truncated_property;
 	const void *prop;
-	int err;
 	int len;
 
 	test_init(argc, argv);
@@ -43,7 +42,7 @@ int main(int argc, char *argv[])
 		FAIL("fdt_getprop() succeeded on truncated property");
 	if (len != -FDT_ERR_BADSTRUCTURE)
 		FAIL("fdt_getprop() failed with \"%s\" instead of \"%s\"",
-		     fdt_strerror(err), fdt_strerror(-FDT_ERR_BADSTRUCTURE));
+		     fdt_strerror(len), fdt_strerror(-FDT_ERR_BADSTRUCTURE));
 
 	PASS();
 }
