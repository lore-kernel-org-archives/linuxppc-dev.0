Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A72891A039F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 19:56:14 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 11 Aug 2015 19:56:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BCE362CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 19:56:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7B9u2d026280030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 19:56:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7B9taYJ028590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 19:55:37 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: anton@samba.org, linux-kernel@vger.kernel.org, bharata@linux.vnet.ibm.com
Subject: Re: [PATCH RESEND] powerpc/numa: initialize distance lookup table
 from drconf path
In-Reply-To: <1435815541-11860-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1435815541-11860-1-git-send-email-nikunj@linux.vnet.ibm.com>
Date: Tue, 11 Aug 2015 15:25:17 +0530
Message-ID: <87si7q2lq2.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Michael,

Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:
> In some situations, a NUMA guest that supports
> ibm,dynamic-memory-reconfiguration node will end up having flat NUMA
> distances between nodes. This is because of two problems in the
> current code.
>
> 1) Different representations of associativity lists.
>
>    There is an assumption about the associativity list in
>    initialize_distance_lookup_table(). Associativity list has two forms:
>
>    a) [cpu,memory]@x/ibm,associativity has following
>       format:
>            <N> <N integers>
>
>    b) ibm,dynamic-reconfiguration-memory/ibm,associativity-lookup-arrays
>
>            <M> <N> <M associativity lists each having N integers>
>            M = the number of associativity lists
>            N = the number of entries per associativity list
>
>    Fix initialize_distance_lookup_table() so that it does not assume
>    "case a". And update the caller to skip the length field before
>    sending the associativity list.
>
> 2) Distance table not getting updated from drconf path.
>
>    Node distance table will not get initialized in certain cases as
>    ibm,dynamic-reconfiguration-memory path does not initialize the
>    lookup table.
>
>    Call initialize_distance_lookup_table() from drconf path with
>    appropriate associativity list.
>
> Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Acked-by: Anton Blanchard <anton@samba.org>

Have you pulled this?

Regards,
Nikunj
