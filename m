Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjy8C0C3KzDq9n
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 14:41:47 +1000 (AEST)
Message-ID: <1460349706.3444.2.camel@ellerman.id.au>
Subject: Re: [PATCH 0/2] perf probe fixes for ppc64le
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Balbir Singh
 <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Wielaard <mjw@redhat.com>, Arnaldo
 Carvalho de Melo
 <acme@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Thiago Jung
 Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 11 Apr 2016 14:41:46 +1000
In-Reply-To: <20160409134239.GL15993@naverao1-tp.in.ibm.com>
References: <cover.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
 <57061802.7020508@gmail.com>
 <20160407092636.GK15993@naverao1-tp.in.ibm.com>
 <1460098663.6475.6.camel@gmail.com>
 <20160409134239.GL15993@naverao1-tp.in.ibm.com>
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

On Sat, 2016-04-09 at 19:12 +0530, Naveen N. Rao wrote:
> 
> I suppose this boils down to the quirkiness of ABIv2. Though, in 
> reality, I don't think most users will notice. As I stated above, users 
> will most likely start with the disassembly or debuginfo and this patch 
> ensures there are actually no surprises there.

Yeah it's unfortunate that we have to handle these two cases differently.

But I think you've chosen the right trade off.

When we are just given the name we *must not* use the global entry point,
otherwise the probes will often not hit - because most calls go to the local
entry point and skip the global entry point entirely.

When we're given a name and offset, it's less confusing if we use the global
entry point as the base for the offset calculation.

So for the concept:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

I don't really know this part of the perf code enough to give you an ack for the
actual changes, I'll leave that to the perf maintainers.

cheers
