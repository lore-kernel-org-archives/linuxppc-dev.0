Return-Path: <groeck7@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 683C71A0338
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 22:26:57 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id fa1so961380pad.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 05:26:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 12 Jun 2014 05:26:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
Message-ID: <20140612122644.GA17249@roeck-us.net>
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
Hi Ben,

what happened with this patch ?

Thanks,
Guenter
