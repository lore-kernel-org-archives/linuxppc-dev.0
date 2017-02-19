Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRMwq483QzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 10:12:27 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vRMwp63WRz9s7r
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 10:12:26 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JN9Ckj055294
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 18:12:24 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28qaeebnq3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 18:12:24 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 09:12:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DD7A62CE8054
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 10:12:18 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1JNCA3137814410
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 10:12:18 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1JNBkRK014057
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 10:11:46 +1100
Date: Mon, 20 Feb 2017 10:11:21 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Make PCI non-optional
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1487313253-22846-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487313253-22846-1-git-send-email-mpe@ellerman.id.au>
Message-Id: <20170219231121.GA10854@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2017 at 05:34:13PM +1100, Michael Ellerman wrote:
>Bare metal systems without PCI don't exist, so there's no real point in
>making PCI optional, it just breaks the build from time to time. In fact
>the build is broken now if you turn off PCI_MSI but enable KVM.
>
>Using select for PCI is OK because we (powerpc) define config PCI, and it
>has no dependencies. Selecting PCI_MSI is slightly fishy, because it's
>in drivers/pci and it is user-visible, but its only dependency is PCI,
>so selecting it can't actually lead to breakage.
>
>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
