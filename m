Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 513AA1A0151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 13:18:59 +1000 (AEST)
Message-ID: <1439867938.1763.6.camel@ellerman.id.au>
Subject: Re: [PATCH RESEND] powerpc/numa: initialize distance lookup table
 from drconf path
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 linux-kernel@vger.kernel.org, bharata@linux.vnet.ibm.com
Date: Tue, 18 Aug 2015 13:18:58 +1000
In-Reply-To: <87si7q2lq2.fsf@linux.vnet.ibm.com>
References: <1435815541-11860-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <87si7q2lq2.fsf@linux.vnet.ibm.com>
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

On Tue, 2015-08-11 at 15:25 +0530, Nikunj A Dadhania wrote:
> Hi Michael,
> 
> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:
> > In some situations, a NUMA guest that supports
> > ibm,dynamic-memory-reconfiguration node will end up having flat NUMA
> > distances between nodes. This is because of two problems in the
> > current code.
> >
> > 1) Different representations of associativity lists.
> >
> >    There is an assumption about the associativity list in
> >    initialize_distance_lookup_table(). Associativity list has two forms:
> >
> >    a) [cpu,memory]@x/ibm,associativity has following
> >       format:
> >            <N> <N integers>
> >
> >    b) ibm,dynamic-reconfiguration-memory/ibm,associativity-lookup-arrays
> >
> >            <M> <N> <M associativity lists each having N integers>
> >            M = the number of associativity lists
> >            N = the number of entries per associativity list
> >
> >    Fix initialize_distance_lookup_table() so that it does not assume
> >    "case a". And update the caller to skip the length field before
> >    sending the associativity list.
> >
> > 2) Distance table not getting updated from drconf path.
> >
> >    Node distance table will not get initialized in certain cases as
> >    ibm,dynamic-reconfiguration-memory path does not initialize the
> >    lookup table.
> >
> >    Call initialize_distance_lookup_table() from drconf path with
> >    appropriate associativity list.
> >
> > Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> > Acked-by: Anton Blanchard <anton@samba.org>
> 
> Have you pulled this?

Nope.

Will add it now.

cheers
