Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out0.tiscali.nl (smtp-out0.tiscali.nl [195.241.79.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E622DDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 01:11:09 +1100 (EST)
Message-ID: <479DE26F.9050105@tiscali.nl>
Date: Mon, 28 Jan 2008 15:10:55 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: jwboyer@linux.vnet.ibm.com, michael@ellerman.id.au
Subject: [PATCH 1/1][PPC] Test value, not 1 in print_insn_spu(),
	arch/powerpc/xmon/spu-dis.c
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

untested, please confirm:
The '|| 1' does nothing, should this be corrected like my patch does?
--
Test value, not 1.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/xmon/spu-dis.c b/arch/powerpc/xmon/spu-dis.c
index e5f8983..74d45fb 100644
--- a/arch/powerpc/xmon/spu-dis.c
+++ b/arch/powerpc/xmon/spu-dis.c
@@ -222,7 +222,7 @@ print_insn_spu (unsigned long insn, unsigned long memaddr)
 	      break;
 	    case A_U18:
 	      value = DECODE_INSN_U18 (insn);
-	      if (value == 0 || 1)
+	      if (value == 0 || value == 1)
 		{
 		  hex_value = value;
 		  printf("%u", value);
