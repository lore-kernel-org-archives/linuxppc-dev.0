Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 94CCFDDF5C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 05:26:34 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Fri, 8 Jun 2007 21:26:23 +0200
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<1181271180.6026.10.camel@concordia.ozlabs.ibm.com>
	<cc1d6d368ded181bbbdad8e4f4cb37ae@kernel.crashing.org>
In-Reply-To: <cc1d6d368ded181bbbdad8e4f4cb37ae@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706082126.23435.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 June 2007, Segher Boessenkool wrote:
> >>> + =A0 =A0 =A0 for_each_compatible_node(node, NULL, "ibm,axon-msic") {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (axon_msi_setup_one(of_node_get(node=
)) =3D=3D 0)
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found++;
> >>> + =A0 =A0 =A0 }
> >>> + =A0 =A0 =A0 of_node_put(node);
>=20
> So where is the of_node_put() done for the of_node_get()
> inside the loop?

of_find_compatible_node does an of_node_put() on the device_node
that you pass in as the 'from' argument. In the last step, 'node'
is set to NULL and we put the previous element.

	Arnd <><
