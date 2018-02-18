Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zkghC2cMRzDqx7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Feb 2018 19:55:39 +1100 (AEDT)
In-Reply-To: <151875166139.16739.9174261168457130221.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: ""@gmail.com, daniel@linux.vnet.ibm.com, camb@cyrilbur.gho.pok.ibm.com
Subject: Re: pseries/drmem: Check for zero filled ibm, dynamic-memory property.
Message-Id: <3zkghC02lqz9sWJ@ozlabs.org>
Date: Sun, 18 Feb 2018 19:55:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-02-16 at 03:27:41 UTC, Nathan Fontenot wrote:
> Some versions of QEMU will produce an ibm,dynamic-reconfiguration-memory
> node with a ibm,dynamic-memory property that is zero-filled. This causes
> the drmem code to oops trying to parse this property.
> 
> The fix for this is to validate that the property does contain LMB
> entries before trying to parse it and bail if the count is zero.
> 
> Oops: Kernel access of bad area, sig: 11 [#1]
...
> 
> The ibm,dynamic-reconfiguration-memory device tree property
> generated that causes this:
> 
> ibm,dynamic-reconfiguration-memory {
>         ibm,lmb-size = <0x0 0x10000000>;
>         ibm,memory-flags-mask = <0xff>;
>         ibm,dynamic-memory = <0x0 0x0 0x0 0x0 0x0 0x0>;
>         linux,phandle = <0x7e57eed8>;
>         ibm,associativity-lookup-arrays = <0x1 0x4 0x0 0x0 0x0 0x0>;
>         ibm,memory-preservation-time = <0x0>;
> };
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
> Tested-by: Daniel Black <daniel@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2c10636a0b9c689450e85f99455839

cheers
