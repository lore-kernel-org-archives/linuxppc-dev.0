Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yPbDb0pzNzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Oct 2017 09:35:42 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9SMXiXh110028
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Oct 2017 18:35:39 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dvp3cqjvj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Oct 2017 18:35:39 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sat, 28 Oct 2017 16:35:38 -0600
Date: Sat, 28 Oct 2017 15:35:32 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/16] Remove hash page table slot tracking from linux PTE
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171027043430.GA27483@fergus.ozlabs.ibm.com>
 <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
Message-Id: <20171028223532.GA5587@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 27, 2017 at 10:57:13AM +0530, Aneesh Kumar K.V wrote:
> 
> 
> On 10/27/2017 10:04 AM, Paul Mackerras wrote:
> >On Fri, Oct 27, 2017 at 09:38:17AM +0530, Aneesh Kumar K.V wrote:
> >>Hi,
> >>
> >>With hash translation mode we always tracked the hash pte slot details in linux page table.
> >>This occupied space in the linux page table and also limitted our ability to support
> >>linux features that require additional PTE bits. This series attempt to lift this
> >>limitation by not tracking slot number in linux page table. We still track slot details
> >>w.r.t Transparent Hugepage entries because an invalidate there requires us to go through
> >>all the 256 hash pte slots. So tracking whether hash page table entry is valid helps us in
> >>avoiding a lot of hcalls there. With THP entries we don't keep slot details in the primary
> >>linux page table entry but in the second half of page table. Hence tracking slot details
> >>for THP doesn't take up space in PTE.
> >>
> >>Even though we don't track slot, for removing/updating hash page table entry, PAPR hcalls expect
> >>hash page table slot details. On pseries we find slot using H_READ hcall using H_READ_4 flags.
> >>This implies an additional 2 hcalls in the updatepp and remove paths. The patch series also
> >>attempt to limit the impact of this by adding new hcalls that does remove/update of hash page table
> >>entry using hash value instead of hash page table slot.
> >>
> >>Below is the performance numbers observed when running a workload that does the below sequence
> >>
> >>for(5000) {
> >>mmap(128M)
> >>touch every page of 2048 page
> >>munmap()
> >>}
> >>

I like the idea of not tracking the slots at all. It is something the
guest should not be knowing or tracking.

> >>The test is run with address randomization off, swap disabled in both host and guest.
> >>
> >>
> >>|------------+----------+---------------+--------------------------+-----------------------|
> >>| iterations | platform | without patch | With series and no hcall | With series and hcall |
> >>|------------+----------+---------------+--------------------------+-----------------------|
> >>|          1 | powernv  |               |                50.818343 |                       |
> >>|          2 | powernv  |               |                50.744123 |                       |
> >>|          3 | powernv  |               |                50.721603 |                       |
> >>|          4 | powernv  |               |                50.739922 |                       |
> >>|          5 | powernv  |               |                50.638555 |                       |
> >>|          1 | powernv  |     51.388249 |                          |                       |
> >>|          2 | powernv  |     51.789701 |                          |                       |
> >>|          3 | powernv  |     52.240394 |                          |                       |
> >>|          4 | powernv  |     51.432255 |                          |                       |
> >>|          5 | powernv  |     51.392947 |                          |                       |
> >>|------------+----------+---------------+--------------------------+-----------------------|
> >>|          1 | pseries  |               |                          |            123.154394 |
> >>|          2 | pseries  |               |                          |            122.253956 |
> >>|          3 | pseries  |               |                          |            117.666344 |
> >>|          4 | pseries  |               |                          |            117.681479 |
> >>|          5 | pseries  |               |                          |            117.735808 |
> >>|          1 | pseries  |               |               119.424940 |                       |
> >>|          2 | pseries  |               |               117.663078 |                       |
> >>|          3 | pseries  |               |               118.345584 |                       |
> >>|          4 | pseries  |               |               119.620934 |                       |
> >>|          5 | pseries  |               |               119.463185 |                       |
> >>|          1 | pseries  |    122.810867 |                          |                       |
> >>|          2 | pseries  |    115.760801 |                          |                       |
> >>|          3 | pseries  |    115.257030 |                          |                       |
> >>|          4 | pseries  |    116.617884 |                          |                       |
> >>|          5 | pseries  |    117.247036 |                          |                       |
> >>|------------+----------+---------------+--------------------------+-----------------------|
> >>
> >

What does 'With series and no hcall' mean?  does it mean -- no calls to  new hcalls,
     instead use H_READ_4 followed by old HCALLs?

And I am assuming the code is not using any of my slot-move-to-secondary-pte changes.

RP
