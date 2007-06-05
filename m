Return-Path: <jdubois@mc.com>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id 45676DDE43
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 17:01:00 +1000 (EST)
From: Jean-Christophe Dubois <jdubois@mc.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Tue, 5 Jun 2007 09:00:53 +0200
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
In-Reply-To: <90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706050900.54022.jdubois@mc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 04 June 2007 15:00:05 Michael Ellerman wrote:
> +=A0=A0=A0=A0=A0=A0=A0pr_debug("axon_msi: initialising ...\n");
> +
> +=A0=A0=A0=A0=A0=A0=A0for_each_compatible_node(node, NULL, "ibm,axon-msic=
") {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (axon_msi_setup_one(of_n=
ode_get(node)) =3D=3D 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fou=
nd++;
> +=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0of_node_put(node);

2 comments:

1) There is no "ibm,axon-msic" compatible property in the SLOF tree provide=
d=20
by IBM on the CAB (or other such platforms). Therefore this code will not=20
work on these platforms.

2) you should somehow check for the Axon version. Axon 1.1 (and prior) are=
=20
know to be loosing MSI/MBX interrupts (but not the data part associated to=
=20
them). Therefore this should be enabled only on Axon 2.1 (or later).

JC
