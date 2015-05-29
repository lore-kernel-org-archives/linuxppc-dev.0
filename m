Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0126.outbound.protection.outlook.com [65.55.169.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC6791A004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 10:59:20 +1000 (AEST)
Date: Thu, 28 May 2015 19:59:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Madalin Bucur <madalin.bucur@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <roy.pledge@freescale.com>
Subject: Re: [v2] powerpc/mpc85xx: Add DPAA Ethernet QMan support to the
 device tree(s)
Message-ID: <20150529005908.GA9235@home.buserror.net>
References: <1432124975-6096-1-git-send-email-madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1432124975-6096-1-git-send-email-madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 20, 2015 at 03:29:35PM +0300, Madalin Bucur wrote:
> From: Emil Medve <Emilian.Medve@Freescale.com>
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

What does "DPAA Ethernet QMan support" mean?  Is it ethernet support or
qman support?  In any case the subject is too long.

> +/* These stubs are required to alloc qbman drivers to determine what ranges of
> + * resources are available for dynamic allocation, primarily because there are
> + * some legacy "a priori" assumptions in certain subsystems (eg. networking)
> + * that certain resources are reserved for their use. When those drivers (and in
> + * some cases, their corresponding device-tree nodes) are updated to dynamically
> + * allocate their resources, then *all* resources can be managed by the
> + * allocators and there may be no further need to define these stubs.

I thought we were doing full dynamic resource allocation for the upstream
driver and device tree binding.

> + * - Even for memory-backed resources that are software determined (FQIDs), this
> + *   information may only be configured and available on the control-plane
> + *   partition that manages the device, so in AMP or hypervised scenarios there
> + *   may still be need to a way to provide allocation ranges. Ie. for O/S
> + *   instances that don't know how many resources are available to hardware, and
> + *   possibly even for O/S instances that do know how many are available but
> + *   that should not "own" all of them.

Partial device assignment under virtualization needs special handling for
any device; no need to have a big block comment about it here.

> + */
> +
> +&qportals {
> +	qman-fqids@0 {
> +		compatible = "fsl,fqid-range";
> +		fsl,fqid-range = <256 256>;
> +	};
> +	qman-fqids@1 {
> +		compatible = "fsl,fqid-range";
> +		fsl,fqid-range = <32768 32768>;
> +	};
> +	qman-pools@0 {
> +		compatible = "fsl,pool-channel-range";
> +		fsl,pool-channel-range = <0x21 0xf>;
> +	};
> +	qman-cgrids@0 {
> +		compatible = "fsl,cgrid-range";
> +		fsl,cgrid-range = <0 256>;
> +	};
> +};

Where is the binding for this stuff?

> +/* The comments in qoriq-dpaa-res1.dtsi apply here too so will not be repeated.
> + * This alternative file is to support p1023 which does not have the same
> + * resource ranges as other SoCs to date. */

Then put "p1023" in the name instead of "res2" (or if the 2 really means
something, explain).

> +/* These stubs are required to alloc qbman drivers to determine what ranges of
> + * resources are available for dynamic allocation, primarily because there are
> + * some legacy "a priori" assumptions in certain subsystems (eg. networking)
> + * that certain resources are reserved for their use. When those drivers (and in
> + * some cases, their corresponding device-tree nodes) are updated to dynamically
> + * allocate their resources, then *all* resources can be managed by the
> + * allocators and there may be no further need to define these stubs.
> + *
> + * A couple of qualifiers to the above statement though:
> + *
> + * - Some resource ranges are hardware-specific, rather than being defined by
> + *   software memory allocation choices. Eg. the number of available BPIDs is
> + *   baked into silicon and so will probably always need to be expressed in the
> + *   device-tree, though in that case it will express all BPIDs, not just those
> + *   available for dynamic allocation.
> + *
> + * - Even for memory-backed resources that are software determined (FQIDs), this
> + *   information may only be configured and available on the control-plane
> + *   partition that manages the device, so in AMP or hypervised scenarios there
> + *   may still be need to a way to provide allocation ranges. Ie. for O/S
> + *   instances that don't know how many resources are available to hardware, and
> + *   possibly even for O/S instances that do know how many are available but
> + *   that should not "own" all of them.

Why is all this repeated here?

If explanation is needed about what the nodes are here for, put it in the
binding document.

-Scott
