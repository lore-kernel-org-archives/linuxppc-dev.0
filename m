Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D921067C4A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2005 12:09:03 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1121718331.2400.24.camel@cashmere.sps.mot.com>
References: <1121718331.2400.24.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 12:08:24 +1000
Message-Id: <1121738905.14393.43.camel@gaston>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: DTC memory reserve question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-07-18 at 15:25 -0500, Jon Loeliger wrote:
> So, when the Device Tree Compiler lays down a memory
> reserve table into an assembly file, it always adds
> a reserved region covering the whole DT blob itself.
> That is, it does this:
> 
>         .balign 8
>         .globl  dt_reserve_map
> dt_reserve_map:
> _dt_reserve_map:
>         .long   0, _dt_blob_start
>         .long   0, _dt_blob_end - _dt_blob_start
>         .llong  0
>         .llong  0
> 
> Naturally, that yields System.map entries like this:
> 
> c0013988 t _dt_blob_start
> c0013988 T dt_blob_start
> c0013988 t _dt_header
> c0013988 T dt_header
> c00139b0 t _dt_reserve_map
> c00139b0 T dt_reserve_map
> c00139d0 t _dt_struct_start
> c00139d0 T dt_struct_start
> c0013df0 t _dt_strings_start
> c0013df0 T dt_strings_start
> c0013df0 t _dt_struct_end
> c0013df0 T dt_struct_end
> c0013f05 t _dt_blob_end
> c0013f05 T dt_blob_end
> 
> Notice that these are 0xC-gazillion addresses.

How are you getting these addresses ? You are trying to link the output
of dtc with the kernel directly ? Hrm...  That will not work for that
(and maybe a couple of other things). Might be better to link it with
the zImage wrapper...

Ben.
