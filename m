Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D16281A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 12:55:43 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9CFF41402AC
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:55:43 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 21 Jul 2015 12:55:43 +1000
Message-ID: <1437447282.3775.46.camel@au1.ibm.com>
Subject: Re: [PATCH] Fix crash due to processing "memory-controller" nodes
 as "memory"
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Ian Munsie <imunsie@au1.ibm.com>, "sonal.santan" <sonal.santan@xilinx.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Samuel
 Mendoza-Jonas <sam.mj@au1.ibm.com>, Jeremy Kerr <jk@ozlabs.org>, Michael
 Neuling <michael.neuling@au1.ibm.com>
Date: Tue, 21 Jul 2015 12:54:42 +1000
In-Reply-To: <20150721124554.332dd228@kryten>
References: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
 <20150721124554.332dd228@kryten>
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

On Tue, 2015-07-21 at 12:45 +1000, Anton Blanchard wrote:
> Hi Ian,
> 
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > If the system has a PCI device with a memory-controller device node,
> > kexec-lite would spew hundreds of double free warnings and eventually
> > segfault. This would result in a "kexec load failed" message from
> > petitboot.
> > 
> > This was due to kexec_memory_map() searching for "memory" nodes, but
> > actually matching any node that started with "memory", including these
> > "memory-controller" nodes. This patch changes the search to look for
> > nodes starting with "memory@", which should only match memory nodes.
> 
> Nice catch! I wonder if we should be checking for device_type
> "memory". Ben?

Or at least check for the nodes at the root of the DT only.

Cheers,
Ben.

> Anton
> 
> > An example of a device tree that can trigger this bug is as follows:
> > 
> > {
> > 	pciex@3fffe40000000 {
> > 		...
> > 		pci@0 {
> > 			#address-cells = <0x3>;
> > 			#size-cells = <0x2>;
> > 			...
> > 			memory-controller@0 {
> > 				reg = <0x10000 0x0 0x0 0x0 0x0>;
> > 				...
> > 			};
> > 		};
> > 	};
> > };
> > 
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> > ---
> >  kexec_memory_map.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kexec_memory_map.c b/kexec_memory_map.c
> > index fc1b7af..7f18de7 100644
> > --- a/kexec_memory_map.c
> > +++ b/kexec_memory_map.c
> > @@ -192,7 +192,7 @@ void kexec_memory_map(void *fdt, int
> > reserve_initrd) 
> >  		name = fdt_get_name(fdt, nodeoffset, NULL);
> >  
> > -		if (!name || strncmp(name, "memory",
> > strlen("memory")))
> > +		if (!name || strncmp(name, "memory@",
> > strlen("memory@"))) continue;
> >  
> >  		reg = fdt_getprop(fdt, nodeoffset, "reg", &len);
