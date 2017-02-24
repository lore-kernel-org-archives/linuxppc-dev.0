Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vV60V1mghzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 20:55:06 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Hamish Martin' <hamish.martin@alliedtelesis.co.nz>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: "chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 0/2] Allow configurable stack size (especially 32k on
 PPC64)
Date: Fri, 24 Feb 2017 09:54:56 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE6EDAD@AcuExch.aculab.com>
References: <20170224005210.1318-1-hamish.martin@alliedtelesis.co.nz>
In-Reply-To: <20170224005210.1318-1-hamish.martin@alliedtelesis.co.nz>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hamish Martin
> Sent: 24 February 2017 00:52
> This patch series adds the ability to configure the THREAD_SHIFT value an=
d
> thereby alter the stack size on powerpc systems. We are particularly inte=
rested
> in configuring for a 32k stack on PPC64.
>=20
> Using an NXP T2081 (e6500 PPC64 cores) we are observing stack overflows a=
s a
> result of applying a DTS overlay containing some I2C devices. Our scenari=
o is
> an ethernet switch chassis with plug-in cards. The I2C is driven from the=
 T2081
> through a PCA9548 mux on the main board. When we detect insertion of the =
plugin
> card we schedule work for a call to of_overlay_create() to install a DTS
> overlay for the plugin board. This DTS overlay contains a further PCA9548=
 mux
> with more devices hanging off it including a PCA9539 GPIO expander. The
> ultimate installed I2C tree is:
>=20
> T2081 --- PCA9548 MUX --- PCA9548 MUX --- PCA9539 GPIO Expander
>=20
> When we install the overlay the devices described in the overlay are prob=
ed and
> we see a large number of stack frames used as a result. If this is couple=
d with
> an interrupt happening that requires moderate to high stack use we observ=
e
> stack corruption. Here is an example long stack (from a 4.10-rc8 kernel) =
that
> does not show corruption but does demonstrate the length and frame sizes
> involved.
...

ISTM that the device probe needs to be iterative rather than recursive so
that deeply nested buses don't require deep stacks.

Switching stacks on interrupt entry would also make it much less likely tha=
t
you'll get an unexpected stack corruption.

The problem with just doubling the stack size is that code will just eat
it all up and, in a few years, something will hit the limit again.

	David
