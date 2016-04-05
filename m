Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfPQH4D5HzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 19:56:39 +1000 (AEST)
Message-ID: <1459850183.20087.67.camel@kernel.crashing.org>
Subject: Re: powerpc: Clear user CPU feature bits if TM is disabled at runtime
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras via Linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paul
 Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>, David
 Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Date: Tue, 05 Apr 2016 19:56:23 +1000
In-Reply-To: <3qfNxw4KcCz9sD5@ozlabs.org>
References: <3qfNxw4KcCz9sD5@ozlabs.org>
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

On Tue, 2016-04-05 at 19:35 +1000, Michael Ellerman wrote:
> Shouldn't we be clearing the user feature there too?
> 
> The ibm_pa_features array and the logic in scan_features() knows to
> flip the
> cpu_user_features bits, it was just never updated to handle
> cpu_user_features2.
> 
> So it seems to me that's where the bug is.

I was about to make the same comment but then realized we are trying to
clear *2* bits. And since that logic will also, I think, set the bits
when the corresponding pa-feature is present, it means we will also set
those 2 bits if we put both in the mask...

Not sure that's quite what we want, but then I'm not sure what the 2
bits are about, which is why I postponed commenting :-)

Cheers,
Ben.
