Return-Path: <srs0=aihx=3s=linux.vnet.ibm.com=gwshan@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w24Wx3jMfzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:25:49 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w24Wx2NCXz8t40
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:25:49 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w24Ww5FTnz9sNB
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 08:25:48 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3AMOKc3030415
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 18:25:44 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rhnajf8v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 18:25:44 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 08:25:41 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3AMPVGD10682518
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 08:25:39 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3AMP6a3022809
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 08:25:06 +1000
Date: Tue, 11 Apr 2017 08:24:42 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: IanJiang <ianjiang.cn@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: EEH error in doing DMA with PEX 8619
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1491826953201-121121.post@n7.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491826953201-121121.post@n7.nabble.com>
Message-Id: <20170410222442.GA11610@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 10, 2017 at 05:22:33AM -0700, IanJiang wrote:
>Hi all!
>
>I am porting PLX driver for PEX 8619 to a power8 machine with CentOS-7.3.
>The PEX 8619 is used as an NTB (Non-Transparent Bridge).
>
>First, two DMA buffer are allocated with dma_alloc_coherent() and the
>physical address are:
>src: 0x 00000000_60600000
>dst: 0x 00000000_60800000
>Then, a DMA transfer is started and an EEH is reported in dmesg.
>
>This DMA test is OK at an x86_64 platform.
>
>Here are the details. Any suggestion is appreciated! 

.../...

>[72634.742182] brdgCtl:     00000002
>[72634.742183] RootSts:     0002004f 00400000 f0820008 00100147 00002800
>[72634.742184] RootErrSts:  00000000 00008000 00000000
>[72634.742185] PhbSts:      0000001c00000000 0000001c00000000
>[72634.742186] Lem:         0000000004000000 42498e327f502eae
>0000000000000000
>[72634.742189] InAErr:      0000000000004000 0000000000004000
>8000000060600001 8                                          400000000000001
>[72634.742190] PE[  1] A/B: 8200302500000000 8000000060600000

Please check if memory physical address (instead of DMA address) is used
in the driver. The EEH error is caused by DMA address 0x60600000 and it's
not having a corresponding TCE entry.

Thanks,
Gavin
