Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BA2F1A0AB1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 14:21:15 +1000 (EST)
Date: Fri, 3 Oct 2014 14:21:15 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v3] powerpc/iommu/ddw: Fix endianness
Message-ID: <20141003142115.34b9be97@kryten>
In-Reply-To: <1411627167-22927-1-git-send-email-aik@ozlabs.ru>
References: <1411627167-22927-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alexey,

> rtas_call() accepts and returns values in CPU endianness.
> The ddw_query_response and ddw_create_response structs members are
> defined and treated as BE but as they are passed to rtas_call() as
> (u32 *) and they get byteswapped automatically, the data is
> CPU-endian. This fixes ddw_query_response and ddw_create_response
> definitions and use.
> 
> of_read_number() is designed to work with device tree cells - it
> assumes the input is big-endian and returns data in CPU-endian.
> However due to the ddw_create_response struct fix, create.addr_hi/lo
> are already CPU-endian so do not byteswap them.
> 
> ddw_avail is a pointer to the "ibm,ddw-applicable" property which
> contains 3 cells which are big-endian as it is a device tree.
> rtas_call() accepts a RTAS token in CPU-endian. This makes use of
> of_property_read_u32_array to byte swap and avoid the need for a
> number of be32_to_cpu calls.
> 
> Cc: stable@vger.kernel.org # v3.13
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Anton Blanchard <anton@samba.org>
> [aik: folded Anton's patch with of_property_read_u32_array]
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks for updating, looks good. Could we make it clear the bug is
present in 3.13-3.17 with:

Cc: stable@vger.kernel.org # v3.13+

Acked-by: Anton Blanchard <anton@samba.org>

Anton
