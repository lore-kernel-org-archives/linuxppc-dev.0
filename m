Return-Path: <groeck7@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3011F14007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 10:28:58 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id ey11so9511996pad.32
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 17:28:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 12 May 2014 17:28:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
Message-ID: <20140513002846.GA29753@roeck-us.net>
References: <1399874254.17624.85.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399874254.17624.85.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 12, 2014 at 03:57:34PM +1000, Benjamin Herrenschmidt wrote:
> This shuffles code around in exceptions-64s.S in order to
> allow an allmodconfig build to succeed.
> 
> The main problems were:
> 
>  - We have a fixed hole from 0x7000 to 0x8000 for use by FW,
> under some circumstances the code before that would grow too
> big and hit the . = 0x7000
> 
>  - The various attempts at making space in there would trigger
> cases where short conditional branches from assembly would no
> longer be able to reach their target. This is especially nasty
> when these branches reside in alternate feature sections which
> are appended at the end of each .o file
> 
> This fixes it by essentially moving all the "second level"
> exception handlers to after the hole and moving a couple of
> functions near the hole itself so they sit at reachable distance
> of both the first level handlers (before the hole) and the alternate
> feature sections (end of file).
> 
> In the long run, if we start hitting this again, we'll probably
> have to split the file in two, probably at the hole location,
> to keep the alt sections used by the first level handlers close
> to them, and move everything else further away.
> 
> But for now, this will do.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
Ben,

After applying this patch, I get

arch/powerpc/kernel/exceptions-64s.S:269: Error: operand out of range
(0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)
arch/powerpc/kernel/exceptions-64s.S:729: Error: operand out of range
(0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)

with powerpc:defconfig, powerpc:allmodconfig, powerpc:cell_defconfig, and
powerpc:maple_defconfig.

This is on top of v3.15-rc5. Any idea what is going on ?

Compiler is powerpc64-poky-linux-gcc (GCC) 4.7.2 (from poky 1.4.0-1).

Thanks,
Guenter
