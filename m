Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpFnw6J01zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:40:52 +1000 (AEST)
Message-ID: <1460954445.21777.0.camel@ellerman.id.au>
Subject: Re: [1/3] powerpc: scan_features() updates incorrect bits
From: Michael Ellerman <mpe@ellerman.id.au>
To: anton@samba.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras
 <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, David Gibson
 <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>,
 matt@ozlabs.org
Cc: linuxppc-dev@lists.ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Date: Mon, 18 Apr 2016 14:40:45 +1000
In-Reply-To: <3qmfyk6wGYz9t6X@ozlabs.org>
References: <3qmfyk6wGYz9t6X@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-04-16 at 00:27 +1000, Michael Ellerman wrote:
> On Fri, 2016-15-04 at 02:06:13 UTC, Unknown sender due to SPF wrote:
> > The real LE feature entry in the ibm_pa_feature struct has the
> > wrong number of elements. Instead of checking for byte 5, bit 0,
> > we check for byte 0, bit 0, and we also incorrectly update cpu user
> > feature bit 5.
> 
> Finally the user feature, we're setting 5, ie. 0x4 | 0x1, which is:
> 
> #define PPC_FEATURE_PPC_LE		0x00000001
> 
> And nothing else, 0x4 is free.

Buuuut, we should reserve 0x4 for the foreseeable future. Because it is
erroneously set on older kernels.

cheers
