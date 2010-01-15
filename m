Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE819B7CC1
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 13:44:08 +1100 (EST)
Subject: Re: powerpc: should mem_end be assigned to dt_struct_end in
	flatten_device_tree()?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roel Kluin <roel.kluin@gmail.com>
In-Reply-To: <4B4FA225.90108@gmail.com>
References: <4B4FA225.90108@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jan 2010 13:44:00 +1100
Message-ID: <1263523440.724.375.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-01-15 at 00:00 +0100, Roel Kluin wrote:
> vi arch/powerpc/kernel/prom_init.c +1961 and note that in
> flatten_device_tree() we do a
> 
>         RELOC(dt_struct_end) = PAGE_ALIGN(mem_start);
> 
> should that maybe be
> 
>         RELOC(dt_struct_end) = PAGE_ALIGN(mem_end);
> 

Nope.

mem_start is a "cursor", it moves as things gets pushed into the flat
device-tree blob. We thus snapshot its value after pushing the last bit
of the structure. mem_end is just the max boundary past which we can no
longer push things.

Cheers,
Ben.
