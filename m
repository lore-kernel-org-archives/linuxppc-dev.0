Return-Path: <srs0=pk4x=3u=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2n2P04yWzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 11:51:09 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2n2N6Zmxz8t7X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 11:51:08 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w2n2N2dXcz9sNr
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 11:51:08 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3C1nJGC031605
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 21:51:06 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29rxx38ssc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 21:51:05 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 12 Apr 2017 11:51:03 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3C1orbj45220012
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 11:51:01 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3C1oTbB006191
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 11:50:29 +1000
Subject: Re: EEH error in doing DMA with PEX 8619
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: IanJiang <ianjiang.cn@gmail.com>, linuxppc-dev@ozlabs.org
Date: Wed, 12 Apr 2017 11:50:03 +1000
In-Reply-To: <1491961190461-121224.post@n7.nabble.com>
References: <1491826953201-121121.post@n7.nabble.com>
 <20170410222442.GA11610@gwshan> <1491876268752-121154.post@n7.nabble.com>
 <1491876910.4166.219.camel@au1.ibm.com> <20170411044238.GA8157@gwshan>
 <1491902810921-121181.post@n7.nabble.com>
 <1491903331.4166.240.camel@kernel.crashing.org>
 <1491961190461-121224.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1491961803.7236.36.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-11 at 18:39 -0700, IanJiang wrote:
> On Tue, Apr 11, 2017 at 5:37 PM, Benjamin Herrenschmidt [via
> linuxppc]
> <ml-node+s10917n121182h95@n7.nabble.com> wrote:
> 
> > Another possibility would be if the requests from the PLX have a 
> > different initiator ID on the bus than the device you are setting
> > up 
> > the DMA for. 
> 
> Is there a way to check out the initiator ID in the driver? I'd like
> to make sure of this.

If you are running bare metal (ie, not under any hypervisor, aka
"powernv" platform), the EEH error log will contain a register dump. If
you paste that to us, we might be able to decode it, it will tell us
more data about the cause of the failure, including possibly the
initiator of the failing transaction.

The initiator ID (aka RID, aka bus/device/fn) of the DMA packets must
match the ones of the struct pci_dev you are using to establish the
mapping.

Cheers,
Ben.

> 
> --
> View this message in context: http://linuxppc.10917.n7.nabble.com/EEH
> -error-in-doing-DMA-with-PEX-8619-tp121121p121224.html
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
