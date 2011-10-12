Return-Path: <geoff@infradead.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 97B2FB6F18
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2011 05:40:27 +1100 (EST)
Subject: [PATCH] powerpc/ps3: Fix PS3 repository build warnings
From: Geoff Levand <geoff@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Oct 2011 11:39:15 -0700
Message-ID: <1318444755.3496.13.camel@gum>
MIME-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix uninitialized variable warnings in build of repository.c

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/repository.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -184,7 +184,7 @@ int ps3_repository_read_bus_type(unsigne
 	enum ps3_bus_type *bus_type)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_PME,
 		make_first_field("bus", bus_index),
@@ -199,7 +199,7 @@ int ps3_repository_read_bus_num_dev(unsi
 	unsigned int *num_dev)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_PME,
 		make_first_field("bus", bus_index),
@@ -239,7 +239,7 @@ int ps3_repository_read_dev_type(unsigne
 	unsigned int dev_index, enum ps3_dev_type *dev_type)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_PME,
 		make_first_field("bus", bus_index),
@@ -256,8 +256,8 @@ int ps3_repository_read_dev_intr(unsigne
 	enum ps3_interrupt_type *intr_type, unsigned int *interrupt_id)
 {
 	int result;
-	u64 v1;
-	u64 v2;
+	u64 v1 = 0;
+	u64 v2 = 0;
 
 	result = read_node(PS3_LPAR_ID_PME,
 		make_first_field("bus", bus_index),
@@ -275,7 +275,7 @@ int ps3_repository_read_dev_reg_type(uns
 	enum ps3_reg_type *reg_type)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_PME,
 		make_first_field("bus", bus_index),
@@ -615,7 +615,7 @@ int ps3_repository_read_stor_dev_num_reg
 	unsigned int dev_index, unsigned int *num_regions)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_PME,
 		make_first_field("bus", bus_index),
@@ -631,7 +631,7 @@ int ps3_repository_read_stor_dev_region_
 	unsigned int *region_id)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_PME,
 	    make_first_field("bus", bus_index),
@@ -786,7 +786,7 @@ int ps3_repository_read_mm_info(u64 *rm_
 int ps3_repository_read_num_spu_reserved(unsigned int *num_spu_reserved)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_CURRENT,
 		make_first_field("bi", 0),
@@ -805,7 +805,7 @@ int ps3_repository_read_num_spu_reserved
 int ps3_repository_read_num_spu_resource_id(unsigned int *num_resource_id)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_CURRENT,
 		make_first_field("bi", 0),
@@ -827,8 +827,8 @@ int ps3_repository_read_spu_resource_id(
 	enum ps3_spu_resource_type *resource_type, unsigned int *resource_id)
 {
 	int result;
-	u64 v1;
-	u64 v2;
+	u64 v1 = 0;
+	u64 v2 = 0;
 
 	result = read_node(PS3_LPAR_ID_CURRENT,
 		make_first_field("bi", 0),
@@ -854,7 +854,7 @@ static int ps3_repository_read_boot_dat_
 int ps3_repository_read_boot_dat_size(unsigned int *size)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_CURRENT,
 		make_first_field("bi", 0),
@@ -869,7 +869,7 @@ int ps3_repository_read_boot_dat_size(un
 int ps3_repository_read_vuart_av_port(unsigned int *port)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_CURRENT,
 		make_first_field("bi", 0),
@@ -884,7 +884,7 @@ int ps3_repository_read_vuart_av_port(un
 int ps3_repository_read_vuart_sysmgr_port(unsigned int *port)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_CURRENT,
 		make_first_field("bi", 0),
@@ -919,7 +919,7 @@ int ps3_repository_read_boot_dat_info(u6
 int ps3_repository_read_num_be(unsigned int *num_be)
 {
 	int result;
-	u64 v1;
+	u64 v1 = 0;
 
 	result = read_node(PS3_LPAR_ID_PME,
 		make_first_field("ben", 0),
