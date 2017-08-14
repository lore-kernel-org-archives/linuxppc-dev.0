Return-Path: <srs0=kucv=7q=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWQJv4QbGzDqXp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 05:14:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xWQJt0QwVz8tV0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 05:14:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xWQJq0Tm4z9t3p
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2017 05:14:18 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7EJ9VGg062870
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 15:14:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cbevh09r1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 15:14:15 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 14 Aug 2017 15:14:15 -0400
Date: Mon, 14 Aug 2017 12:14:09 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/17] powerpc/vas: Define macros, register fields and
 structures
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <877ey6sp03.fsf@concordia.ellerman.id.au>
 <20170814160522.4f9b517a@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170814160522.4f9b517a@roar.ozlabs.ibm.com>
Message-Id: <20170814191409.GA24096@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin [npiggin@gmail.com] wrote:
> On Mon, 14 Aug 2017 15:21:48 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> 
> > >  arch/powerpc/include/asm/vas.h       |  35 ++++
> > >  arch/powerpc/include/uapi/asm/vas.h  |  25 +++  
> > 
> > I thought we weren't exposing VAS to userspace yet?
> > 
> > If we are then we need to get things straight WRT copy/paste abort.
> 

> No we should not be. This might be just a leftover hunk that should
> be moved to a future series.

Yes, I should have posted patches 14..17 separately as an RFC that goes
on top of the VAS kernel patches 1..13.

> 
> At the moment (as far as I understand) it should be limited to
> preempt-disabled, process context, kernel users which avoids any
> concern for switch_to.
> 

In the FTW case, there is no data transfer from user space to the hardware.
i.e the copy/paste submit a NULL CRB and hardware will be configured (see
->fifo_disable setting in winctx) to ignore any data they specify in the CRB.

Would we be able to allow copy/paste from user space in that case?

Sukadev
