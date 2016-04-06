Return-Path: <ananth@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg7Vy6f6kzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 00:33:14 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 6 Apr 2016 08:33:10 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3F68019D8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 08:20:56 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u36EX3mY37945568
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 07:33:03 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u36EX3oi002211
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 08:33:03 -0600
Date: Wed, 6 Apr 2016 20:02:58 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Mark Wielaard <mjw@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH 2/2] tools/perf: Fix kallsyms perf test on ppc64le
Message-ID: <20160406143258.GA3620@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <cover.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
 <04f25362721352e7681db4aed572b3ea5154b64d.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <04f25362721352e7681db4aed572b3ea5154b64d.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2016 at 06:02:58PM +0530, Naveen N. Rao wrote:
> ppc64le functions have a Global Entry Point (GEP) and a Local Entry
> Point (LEP). While placing a probe, we always prefer the LEP since it
> catches function calls through both the GEP and the LEP. In order to do
> this, we fixup the function entry points during elf symbol table lookup
> to point to the LEPs. This works, but breaks 'perf test kallsyms' since
> the symbols loaded from the symbol table (pointing to the LEP) do not
> match the symbols in kallsyms.
> 
> To fix this, we do not adjust all the symbols during symbol table load,
> but only adjust the probe trace point.
> 
> Cc: Mark Wielaard <mjw@redhat.com>
> Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
