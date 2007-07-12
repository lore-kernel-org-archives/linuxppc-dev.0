Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 81DD5DDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 10:00:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] [POWERPC] Move generic MPC82xx functions out of
	ADS-specific
Date: Fri, 13 Jul 2007 01:59:40 +0200
References: <200707101312.46052.laurent.pinchart@technotrade.biz>
	<4694F66D.2010907@freescale.com>
	<200707121704.45373.laurent.pinchart@cse-semaphore.com>
In-Reply-To: <200707121704.45373.laurent.pinchart@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707130159.40394.arnd@arndb.de>
Cc: Laurent Pinchart <laurent.pinchart@cse-semaphore.com>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 12 July 2007, Laurent Pinchart wrote:
> > Ah, I missed that. =A0I'd just get rid of "Vendor" altogether, and incl=
ude
> > the vendor name in the machine name.
>=20
> Is there any standard/documentation regarding what show_cpuinfo should pr=
int ?=20
> Should it show CPU information only, or board information as well ? What=
=20
> about the memory size, clock settings, ... ? What are the meanings=20
> of "vendor" and "machine" ?

I guess the easiest would be to modify the common show_cpuinfo function
to fall back to just printing the model, if there is no specific function:

=2D-- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -175,6 +175,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 			seq_printf(m, "platform\t: %s\n", ppc_md.name);
 		if (ppc_md.show_cpuinfo !=3D NULL)
 			ppc_md.show_cpuinfo(m);
+		else {
+			struct device_node *root =3D of_find_node_by_path("/");
+			const char *model =3D of_get_property(root, "model", NULL);
+			seq_printf(m, "machine\t\t: %s\n", model);
+			of_node_put(root);
+		}
=20
 		return 0;
 	}

With that in place, we can probably get rid of half the platform
specific show_cpuinfo functions.

	Arnd <><
