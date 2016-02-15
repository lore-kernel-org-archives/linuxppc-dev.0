Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90E1B1A0066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:20:22 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 16 Feb 2016 09:20:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id ABC0D2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:20:17 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FNK9xi65405172
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:20:17 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FNJiBI030368
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:19:45 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: christophe lombard <clombard@linux.vnet.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 14/18] cxl: Support to flash a new image on the adapter
 from a guest
In-reply-to: <56C23AE2.8050608@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-15-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1455097101-sup-8413@delenn.ozlabs.ibm.com>
 <56C23AE2.8050608@linux.vnet.ibm.com>
Date: Tue, 16 Feb 2016 10:19:10 +1100
Message-Id: <1455577998-sup-2795@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from christophe lombard's message of 2016-02-16 07:53:54 +1100:
> >> +void cxl_guest_reload_module(struct cxl *adapter)
> >> +{
> >> +    struct platform_device *pdev;
> >> +    int afu;
> >> +
> >> +    for (afu = 0; afu < adapter->slices; afu++)
> >> +        cxl_guest_remove_afu(adapter->afu[afu]);
> > Should we possibly have done this part earlier?
> >
> > I'd think it should be done before any operation that might lead to us
> > resetting the card. Probably the safest thing is to do it when the first
> > chunk is handed to the kernel so we can make sure it's safe, and return
> > -EBUSY if any of the AFUs are still in use.
> Not necessary. PowerVM - phyp - refuses any type of action when an operation
> of download/validation is in progress. The reverse is true as well.

I was more thinking about what could happen in the short window between
when phyp resets the card and is potentially accepting new operations
and when we remove the old AFUs from Linux - could anything bad happen
if someone e.g. did an attach at that moment and Linux still had
outdated info left over from the previous AFU?

Cheers,
-Ian
