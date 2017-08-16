Return-Path: <srs0=xvm0=7s=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXlPN3SYXzDrCk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 09:07:52 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xXlPN2YsRz8tG6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 09:07:52 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xXlPM6pzcz9t36
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 09:07:51 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7GN5FqS015504
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2017 19:07:49 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ccudgu7t6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2017 19:07:49 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 16 Aug 2017 19:07:48 -0400
Date: Wed, 16 Aug 2017 16:07:42 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/17] powerpc/vas: Define macros, register fields and
 structures
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <877ey6sp03.fsf@concordia.ellerman.id.au>
 <20170814160522.4f9b517a@roar.ozlabs.ibm.com>
 <20170814191409.GA24096@us.ibm.com>
 <87ziazsol1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ziazsol1.fsf@concordia.ellerman.id.au>
Message-Id: <20170816230742.GE31897@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> 
> > Nicholas Piggin [npiggin@gmail.com] wrote:
> >> On Mon, 14 Aug 2017 15:21:48 +1000
> >> Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> 
> >> > Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> >> 
> >> > >  arch/powerpc/include/asm/vas.h       |  35 ++++
> >> > >  arch/powerpc/include/uapi/asm/vas.h  |  25 +++  
> >> > 
> >> > I thought we weren't exposing VAS to userspace yet?
> >> > 
> >> > If we are then we need to get things straight WRT copy/paste abort.
> ...
> >
> > In the FTW case, there is no data transfer from user space to the hardware.

Sorry, that was focussed on the paste side.

> > i.e the copy/paste submit a NULL CRB and hardware will be configured (see
> > ->fifo_disable setting in winctx) to ignore any data they specify in the CRB.
> 
> I thought the copy did copy a cacheline, but then the paste to the VAS
> window just ignores the contents, and doesn't allow userspace to get the
> content in any way?

Yes, you are right. The copy instruction does read the CRB into its copy-
buffer but for the FTW, VAS ignores the copy-buffer contents on paste.
So, the CRB may be zeroed, but must be a valid buffer.

> 
> Which means we have two thirds of a covert channel, ie. something can be
> copied into the copy buffer by one process, and then a second process
> can paste it, but because it can only paste to foreign memory, and the
> only foreign memory it can get is a VAS FTW window, it can't actually
> see the content of the copy buffer.
> 
> > Would we be able to allow copy/paste from user space in that case?
> 
> Yeah I think so, but it is all a bit fragile.
> 
> cheers
