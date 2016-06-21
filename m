Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYZyY6zxpzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:49:41 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L4nOKV147396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:49:40 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n0meqheq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:49:39 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 21 Jun 2016 14:49:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 28B173578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:49:35 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L4nYwZ21364818
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:49:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L4nYnd029910
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:49:34 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 manoj <manoj@linux.vnet.ibm.com>
Subject: Re: [v6,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
In-reply-to: <87k2hkgs6v.fsf@vajain21.in.ibm.com>
References: <1466086415-30586-1-git-send-email-felix@linux.vnet.ibm.com>
 <87k2hkgs6v.fsf@vajain21.in.ibm.com>
Date: Tue, 21 Jun 2016 14:49:33 +1000
Message-Id: <1466483778-sup-4320@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Vaibhav Jain's message of 2016-06-20 14:20:16 +0530:
> > +int cxl_unset_driver_ops(struct cxl_context *ctx)
> > +{
> > +    if (atomic_read(&ctx->afu_driver_events))
> > +        return -EBUSY;
> > +
> > +    ctx->afu_driver_ops = NULL;
> Need a write memory barrier so that afu_driver_ops isnt possibly called
> after this store.

What situation do you think this will help? I haven't looked closely at
the last few iterations of this patch set, but if you're in a situation
where you might be racing with some code doing e.g.

if (ctx->afu_driver_ops)
	ctx->afu_driver_ops->something();

You have a race with or without a memory barrier. Ideally you would just
have the caller guarantee that it will only call cxl_unset_driver_ops if
no further calls to afu_driver_ops is possible, otherwise you may need
locking here which would be far from ideal.


What exactly is the use case for this API? I'd vote to drop it if we can
do without it.

-Ian
