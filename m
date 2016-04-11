Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkBC93RFxzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 23:45:09 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 11 Apr 2016 23:45:06 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9AD2E2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 23:45:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3BDiu336160838
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 23:45:04 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3BDiViP011264
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 23:44:32 +1000
Date: Mon, 11 Apr 2016 19:13:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Wielaard <mjw@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 0/2] perf probe fixes for ppc64le
Message-ID: <20160411134325.GM15993@naverao1-tp.in.ibm.com>
References: <cover.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
 <57061802.7020508@gmail.com>
 <20160407092636.GK15993@naverao1-tp.in.ibm.com>
 <1460098663.6475.6.camel@gmail.com>
 <20160409134239.GL15993@naverao1-tp.in.ibm.com>
 <1460349706.3444.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460349706.3444.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/04/11 02:41PM, Michael Ellerman wrote:
> On Sat, 2016-04-09 at 19:12 +0530, Naveen N. Rao wrote:
> > 
> > I suppose this boils down to the quirkiness of ABIv2. Though, in 
> > reality, I don't think most users will notice. As I stated above, users 
> > will most likely start with the disassembly or debuginfo and this patch 
> > ensures there are actually no surprises there.
> 
> Yeah it's unfortunate that we have to handle these two cases differently.
> 
> But I think you've chosen the right trade off.
> 
> When we are just given the name we *must not* use the global entry point,
> otherwise the probes will often not hit - because most calls go to the local
> entry point and skip the global entry point entirely.
> 
> When we're given a name and offset, it's less confusing if we use the global
> entry point as the base for the offset calculation.
> 
> So for the concept:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks, Michael. That helps.

> 
> I don't really know this part of the perf code enough to give you an ack for the
> actual changes, I'll leave that to the perf maintainers.

Sure.

Arnaldo,
I will send a v2 soon with a bit more testing to make sure this covers 
all scenarios properly (I am also trying to see if we can address 
debuginfo-based probing properly).

- Naveen
