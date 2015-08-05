Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25CBA1A0232
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 14:19:38 +1000 (AEST)
Date: Tue, 4 Aug 2015 23:19:28 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Gschwind <mkg@us.ibm.com>,
 Alan Modra <amodra@gmail.com>, Bill Schmidt <wschmidt@us.ibm.com>,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, paulus@samba.org
Subject: Re: RFC: Reducing the number of non volatile GPRs in the ppc64 kernel
Message-ID: <20150805041928.GA32178@gate.crashing.org>
References: <20150805140300.218ef661@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150805140300.218ef661@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On Wed, Aug 05, 2015 at 02:03:00PM +1000, Anton Blanchard wrote:
> While looking at traces of kernel workloads, I noticed places where gcc
> used a large number of non volatiles. Some of these functions
> did very little work, and we spent most of our time saving the
> non volatiles to the stack and reading them back.

That is something that should be fixed in GCC -- do you have an example
of such a function?

> It made me wonder if we have the right ratio of volatile to non
> volatile GPRs. Since the kernel is completely self contained, we could
> potentially change that ratio.
> 
> Attached is a quick hack to gcc and the kernel to decrease the number
> of non volatile GPRs to 8. I'm not sure if this is a good idea (and if
> the volatile to non volatile ratio is right), but this gives us
> something to play with.

Instead of the GCC hack you can add a bunch of -fcall-used-r14 etc.
options; does that not work for you?


Segher
