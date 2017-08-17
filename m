Return-Path: <srs0=qr4f=7t=linux.vnet.ibm.com=bharata@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY1r73ztmzDrKp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:58:31 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xY1r731Qdz8vFh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:58:31 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xY1r65D9wz9sRV
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 19:58:30 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7H9ttEr126652
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 05:58:28 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ccykd042f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 05:58:28 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Thu, 17 Aug 2017 19:58:25 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7H9wOSZ29098194
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 19:58:24 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7H9wOdt009443
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 19:58:24 +1000
Date: Thu, 17 Aug 2017 15:28:20 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, nfont@linux.vnet.ibm.com
Subject: Re: [FIX PATCH v0] powerpc: Fix memory unplug failure on radix guest
Reply-To: bharata@linux.vnet.ibm.com
References: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
 <87valuxzqb.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87valuxzqb.fsf@linux.vnet.ibm.com>
Message-Id: <20170817095820.GA18925@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2017 at 02:12:04PM +0530, Aneesh Kumar K.V wrote:
> Bharata B Rao <bharata@linux.vnet.ibm.com> writes:
> 
> > For a PowerKVM guest, it is possible to specify a DIMM device in
> > addition to the system RAM at boot time. When such a cold plugged DIMM
> > device is removed from a radix guest, we hit the following warning in the
> > guest kernel resulting in the eventual failure of memory unplug:
> >
> > remove_pud_table: unaligned range
> > WARNING: CPU: 3 PID: 164 at arch/powerpc/mm/pgtable-radix.c:597 remove_pagetable+0x468/0xca0
> > Call Trace:
> > remove_pagetable+0x464/0xca0 (unreliable)
> > radix__remove_section_mapping+0x24/0x40
> > remove_section_mapping+0x28/0x60
> > arch_remove_memory+0xcc/0x120
> > remove_memory+0x1ac/0x270
> > dlpar_remove_lmb+0x1ac/0x210
> > dlpar_memory+0xbc4/0xeb0
> > pseries_hp_work_fn+0x1a4/0x230
> > process_one_work+0x1cc/0x660
> > worker_thread+0xac/0x6d0
> > kthread+0x16c/0x1b0
> > ret_from_kernel_thread+0x5c/0x74
> >
> > The DIMM memory that is cold plugged gets merged to the same memblock
> > region as RAM and hence gets mapped at 1G alignment. However since the
> > removal is done for one LMB (lmb size 256MB) at a time, the address
> > of the LMB (which is 256MB aligned) would get flagged as unaligned
> > in remove_pud_table() resulting in the above failure.
> >
> > This problem is not seen for hot plugged memory because for the
> > hot plugged memory, the mappings are created separately for each
> > LMB and hence they all get aligned at 256MB.
> >
> > To fix this problem for the cold plugged memory, let us mark the
> > cold plugged memblock region explicitly as HOTPLUGGED so that the
> > region doesn't get merged with RAM. All the memory that is discovered
> > via ibm,dynamic-memory-configuration is marked so(1). Next identify
> > such regions in radix_init_pgtable() and create separate mappings
> > within that region for each LMB so that they get don't get aligned
> > like RAM region at 1G (2).
> >
> > (1) For PowerKVM guests, all boot time memory is represented via
> > memory@XXXX nodes and hot plugged/pluggable memory is represented via
> > ibm,dynamic-memory-reconfiguration property. We are marking all
> > hotplugged memory that is in ASSIGNED state during boot as HOTPLUGGED.
> > With this only cold plugged memory gets marked for PowerKVM but
> > need to check how this will affect PowerVM guests.
> 
> Can you verify this on PowerVM too ? ie we should in most case not find
> anything under ibm,dynamic-memory-reconfiguration ?

Checked with a couple of PowerVM systems. Look like except for RMA which
is represented by memory@0, rest of the memory is coming under
ibm,dynamic-memory-reconfiguration. So the approach I have taken in this
fix wouldn't be optimal on PowerVM ?

Regards,
Bharata.
