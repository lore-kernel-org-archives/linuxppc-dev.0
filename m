Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C030CDDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 07:28:26 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1KKSNCv023677
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 15:28:23 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1KKSNFX521558
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 13:28:23 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1KKSMuY005757
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 13:28:23 -0700
Subject: Re: [0/14] Ebony support, 2nd spi
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <df6b7857dc38d708a68c81a75b256cb5@kernel.crashing.org>
References: <20070220020837.GF17818@localhost.localdomain>
	<200702201607.33249.arnd@arndb.de>
	<814781c1228541df932f8f4c7cc6ea89@kernel.crashing.org>
	<200702201902.09051.arnd@arndb.de>
	<df6b7857dc38d708a68c81a75b256cb5@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 14:29:25 -0600
Message-Id: <1172003365.24204.135.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-20 at 20:51 +0100, Segher Boessenkool wrote:
> 
> > We probably also need a volunteer to clean up the legacy_serial
> >
> > code for this, it's grown pretty messy by now.
> 
> I nominate you :-)

In the absence of someone actually cleaning up the code, the following
ugly patch should work for both Axon and 4xx until we can settle on
settle on something.  It booted on my Ebony board with David's
FIXED_PORT flag patch also applied anyway.

josh

Make legacy_serial look for multiple compatible serial types on the OBP bus.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

--

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 325f490..3cb2f51 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -291,7 +291,14 @@ void __init find_legacy_serial_ports(void)
 {
 	struct device_node *np, *stdout = NULL;
 	const char *path;
-	int index;
+	int index, i;
+	const char *compat[] = {
+		"ns16750",
+		"ns16550",
+		"ns16450",
+		"i8250",
+		NULL,
+	};
 
 	DBG(" -> find_legacy_serial_port()\n");
 
@@ -339,14 +346,19 @@ void __init find_legacy_serial_ports(void)
 	}
 
 	/* First fill our array with opb bus ports */
-	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16750")) != NULL;) {
-		struct device_node *opb = of_get_parent(np);
-		if (opb && !strcmp(opb->type, "opb")) {
-			index = add_legacy_soc_port(np, np);
-			if (index >= 0 && np == stdout)
-				legacy_serial_console = index;
+	for (i = 0; compat[i] != NULL; i++) {
+		for (np = NULL;
+			(np = of_find_compatible_node(np, "serial", compat[i])) != NULL;) {
+
+			struct device_node *opb = of_get_parent(np);
+			if (opb &&
+				(!strcmp(opb->type, "opb") || !strcmp(opb->type, "ibm,opb"))) {
+				index = add_legacy_soc_port(np, np);
+				if (index >= 0 && np == stdout)
+					legacy_serial_console = index;
+			}
+			of_node_put(opb);
 		}
-		of_node_put(opb);
 	}
 
 #ifdef CONFIG_PCI
