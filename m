Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 15EB3DDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 00:58:16 +1100 (EST)
Message-ID: <45DD9A41.7060900@smiths-aerospace.com>
Date: Thu, 22 Feb 2007 08:27:29 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,  linuxppc-dev@ozlabs.org
Subject: libfdt: a fix but still broken
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dave,

I have good news and bad news. ;-)  The good news is that the 
incompatibility between libfdt and jdl's dtc is that libfdt has the name 
offset and the length of the name switched.  booting_without_of.txt says 
the length comes first, so libfdt is in the wrong.

The bad news is that, when I fix this, nearly all of the tests fail (but 
they fail the same way for both tree.S and jdl's dtc).  I have not 
started on that layer of the onion yet.

Best regards,
gvb

$ git diff fdt.h
diff --git a/fdt.h b/fdt.h
index fff533e..4687a31 100644
--- a/fdt.h
+++ b/fdt.h
@@ -36,8 +36,8 @@ struct fdt_node_header {

  struct fdt_property {
         uint32_t tag;
-       uint32_t nameoff;
         uint32_t len;
+       uint32_t nameoff;
         char data[0];
  };

$ git diff tests/trees.S
diff --git a/tests/trees.S b/tests/trees.S
index 76c0057..400e7d0 100644
--- a/tests/trees.S
+++ b/tests/trees.S
@@ -39,8 +39,8 @@ tree: \

  #define PROPHDR(tree, name, len) \
         FDTLONG(FDT_PROP)       ; \
-       FDTLONG(tree##_##name - tree##_strings) ; \
-       FDTLONG(len)            ;
+       FDTLONG(len)            ; \
+       FDTLONG(tree##_##name - tree##_strings) ;

  #define PROP_INT(tree, name, val) \
         PROPHDR(tree, name, 4) \


______________________________________________________________________
CAUTION: This message was sent via the Public Internet and its 
authenticity cannot be guaranteed.

______________________________________________________
