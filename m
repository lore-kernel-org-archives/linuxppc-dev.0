Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBvQ29MNzDr3d
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:16:50 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBvP2wz6z9s5M
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:16:49 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6558kB5065482
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jul 2016 01:16:47 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23xa529gus-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 05 Jul 2016 01:16:47 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 5 Jul 2016 15:16:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4B91B2BB0059
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:16:42 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u655GgI78782290
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jul 2016 15:16:42 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u655Gfge025135
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jul 2016 15:16:42 +1000
Subject: Re: [PATCH] powerpc/pci: Fix build with PCI_IOV=y and EEH=n
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Russell Currey <ruscur@russell.cc>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@ozlabs.org
Date: Tue, 05 Jul 2016 15:16:41 +1000
In-Reply-To: <1467693015.23386.1.camel@russell.cc>
References: <1467692010-12512-1-git-send-email-mpe@ellerman.id.au>
 <1467693015.23386.1.camel@russell.cc>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1467695801.13965.34.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-07-05 at 14:30 +1000, Russell Currey wrote:
> On Tue, 2016-07-05 at 14:13 +1000, Michael Ellerman wrote:
> > Despite attempting to fix this in commit fb36e9073693
> ("powerpc/pci: Fix
> > SRIOV not building without EEH enabled"), the build is still broken
> when
> > PCI_IOV=y and EEH=n (eg. g5_defconfig with PCI_IOV=y):
> > 
> >   arch/powerpc/kernel/pci_dn.c: In function ‘remove_dev_pci_data’:
> >   arch/powerpc/kernel/pci_dn.c:230:18: error: unused variable
> ‘edev’
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> 
> Mistakes were made.

The fix [PATCH 40/41] powerpc/pci: Fix build of Book3E/64 without EEH
in my series should subsume this... provided I didnt screw up that is
:-)

Cheers,
Ben.
