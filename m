Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdsX62DD2zDqmL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 14:00:06 +1000 (AEST)
Message-ID: <1467086399.32607.5.camel@ellerman.id.au>
Subject: Re: [PATCH v20 14/14] Documentation: dt: usable-memory and
 elfcorehdr nodes for arm64 kexec
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Geoff Levand
 <geoff@infradead.org>, James Morse <james.morseatarm.com@hactar>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 28 Jun 2016 13:59:59 +1000
In-Reply-To: <9127562.8x2DzY0I6N@hactar>
References: <cover.1466702804.git.geoff@infradead.org>
 <e212cd53fdf9d09923408eb906fe0228d22432a9.1466702804.git.geoff@infradead.org>
 <9127562.8x2DzY0I6N@hactar>
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

On Mon, 2016-06-27 at 15:22 -0300, Thiago Jung Bauermann wrote:
> Am Donnerstag, 23 Juni 2016, 17:54:49 schrieb Geoff Levand:
> > +linux,usable-memory
> > +-------------------
> > +
> > +This property is set on PowerPC and arm64 by kexec-tools during kdump
> > +to tell the crash kernel the base address of its reserved area of memory,
> > and +the size. e.g.
> > +
> > +/ {
> > +	chosen {
> > +		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
> > +	};
> > +};
> 
> On powerpc, linux,usable-memory isn't in /chosen. It is put by kexec-tools 
> in each /memory node and has the same format as the reg property. During 
> early boot, the kernel goes through the /memory nodes to find usable memory 
> and for each node, if there's a linux,usable-memory property it will use it 
> instead of the reg property to find the ranges of memory it can use (see 
> early_init_dt_scan_memory in drivers/of/fdt.c).

Yep that sounds right to me.

Added in:

ba7594852f4e ("[PATCH] powerpc: Add support for "linux,usable-memory" on memory nodes")

cheers
