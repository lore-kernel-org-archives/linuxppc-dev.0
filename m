Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by ozlabs.org (Postfix) with ESMTP id 7135E2C00C7
 for <linuxppc-dev@ozlabs.org>; Sat, 18 May 2013 01:50:20 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.1]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MRQbm-1V5wLx0GPQ-00SiZp for
 <linuxppc-dev@ozlabs.org>; Fri, 17 May 2013 17:45:13 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: Only iterate over online nodes in
 cbe_init_pm_irq()
Date: Fri, 17 May 2013 17:45:05 +0200
Message-ID: <5021824.e1KI2ptoeP@ernie>
In-Reply-To: <1366719291-29414-1-git-send-email-michael@ellerman.id.au>
References: <1366719291-29414-1-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5153770.BfjdujrCCe";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart5153770.BfjdujrCCe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

Just wanted to remind you: The patchto fix cbe_init_pm_irq() that Michael and 
Grant sent me is still not included in Linux 3.8.12.

--Dennis

Am Dienstag, 23. April 2013, 22:14:51 schrieb Michael Ellerman:
> None of the cell platforms support CPU hotplug, so we should iterate
> only over online nodes when setting PMU interrupts.
> 
> This also fixes a warning during boot when NODES_SHIFT is large enough:
> 
> WARNING: at /scratch/michael/src/kmk/linus/kernel/irq/irqdomain.c:766
> ...
> NIP [c0000000000db278] .irq_linear_revmap+0x30/0x58
> LR [c0000000000dc2a0] .irq_create_mapping+0x38/0x1a8
> Call Trace:
> [c0000003fc9c3af0] [c0000000000dc2a0] .irq_create_mapping+0x38/0x1a8
> (unreliable) [c0000003fc9c3b80] [c000000000655c1c]
> .__machine_initcall_cell_cbe_init_pm_irq+0x84/0x158 [c0000003fc9c3c20]
> [c00000000000afb4] .do_one_initcall+0x5c/0x1e0
> [c0000003fc9c3cd0] [c000000000644580] .kernel_init_freeable+0x238/0x328
> [c0000003fc9c3db0] [c00000000000b784] .kernel_init+0x1c/0x120
> [c0000003fc9c3e30] [c000000000009fb8] .ret_from_kernel_thread+0x64/0xac
> 
> This is caused by us overflowing our linear revmap because we're
> requesting too many interrupts.
> 
> Reported-by: Dennis Schridde <devurandom@gmx.net>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/platforms/cell/pmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/cell/pmu.c
> b/arch/powerpc/platforms/cell/pmu.c index 59c1a16..348a27b 100644
> --- a/arch/powerpc/platforms/cell/pmu.c
> +++ b/arch/powerpc/platforms/cell/pmu.c
> @@ -382,7 +382,7 @@ static int __init cbe_init_pm_irq(void)
>  	unsigned int irq;
>  	int rc, node;
> 
> -	for_each_node(node) {
> +	for_each_online_node(node) {
>  		irq = irq_create_mapping(NULL, IIC_IRQ_IOEX_PMI |
>  					       (node << IIC_IRQ_NODE_SHIFT));
>  		if (irq == NO_IRQ) {
--nextPart5153770.BfjdujrCCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iEYEABECAAYFAlGWUIUACgkQjqfyF1DtJW76twCfXPZGCUaUtKz4o1v/CPv+FpvM
PboAni1Z+/GlWA8TPPqrTRc9tXSXpfPQ
=mx24
-----END PGP SIGNATURE-----

--nextPart5153770.BfjdujrCCe--
