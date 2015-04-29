Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E59DE1A0025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 14:53:27 +1000 (AEST)
Message-ID: <1430283207.12906.1.camel@ellerman.id.au>
Subject: Re: [PATCH] Correct cpu affinity for dlpar added cpus
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 29 Apr 2015 14:53:27 +1000
In-Reply-To: <553FA94D.2000608@linux.vnet.ibm.com>
References: <553FA94D.2000608@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subject should be "powerpc/pseries: ..." please.

On Tue, 2015-04-28 at 10:37 -0500, Nathan Fontenot wrote:
> The incorrect ordering of operations during cpu dlpar causes the affinity
> of cpus being added to be invalid. Phyp does not assign affinity information
> for a cpu until the rtas set-indicator calls are made to set the isolation
> and allocation state. In the current code we call rtas configure-connector
> before making the set-indicator calls which results in invalid data in the
> ibm,associativity property for the cpu we're adding.

Invalid and benign? Or invalid and causes an oops or ..?

> This patch corrects the order of operations to make the set-indicator
> calls (done in acquire_drc) before calling configure-connector.

Which commit added the code and/or caused it to be wrong?

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n187


While looking at the code I notice it looks like we leak a reference if
dlpar_configure_connector() fails:

	parent = of_find_node_by_path("/cpus");
	if (!parent)
		return -ENODEV;

	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
	if (!dn)
		return -EINVAL;

	of_node_put(parent);


Please send a separate patch to fix that.

cheers
