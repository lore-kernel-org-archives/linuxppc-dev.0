Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7vYp1tzgzDqSr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 23:01:50 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79Csj1m072614
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 09:01:47 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qe85mkxs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 09:01:47 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 18:31:31 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 16DFEE0063
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 18:35:54 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79D1RPf38797356
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 18:31:27 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79D1PcV010586
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 18:31:26 +0530
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung
 Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>
Date: Tue, 09 Aug 2016 09:01:13 -0400
In-Reply-To: <87wpjqtdg8.fsf@concordia.ellerman.id.au>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1470313475-20090-2-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1470747673.2881.118.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index b5728da..84e8d36 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -102,6 +102,13 @@ struct ima_queue_entry {
> >  };
> >  extern struct list_head ima_measurements;	/* list of all measurements */
> >  
> > +/* Some details preceding the binary serialized measurement list */
> > +struct ima_kexec_hdr {
> > +	unsigned short version;
> > +	unsigned long buffer_size;
> > +	unsigned long count;
> > +} __packed;
> > +
> 
> Am I understanding it correctly that this structure is passed between kernels?

Yes, the header prefixes the measurement list, which is being passed on
the same computer to the next kernel.  Could the architecture (eg.
LE/BE) change between soft re-boots?

> If so it's an ABI and should use types with well defined sizes, as if it was
> going out to userspace, shouldn't it?

Ok

Mimi
