Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC6DC1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 12:43:41 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DBFCF1402A1
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 12:43:40 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 8 Mar 2016 11:43:39 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 23C722CE8057
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 12:43:37 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u281hSth1507616
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 12:43:37 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u281h4qY013295
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 12:43:04 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Matt Ochs <mrochs@us.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>, Manoj Kumar <kumarmn@us.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michaele@au1.ibm.com>
Subject: Re: [PATCH v2 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
In-reply-to: <2E3C996E-C050-426F-878D-F25905E3C584@us.ibm.com>
References: <1457377164-22234-1-git-send-email-imunsie@au.ibm.com>
 <2E3C996E-C050-426F-878D-F25905E3C584@us.ibm.com>
Date: Tue, 08 Mar 2016 12:42:38 +1100
Message-Id: <1457401187-sup-7130@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Matt Ochs's message of 2016-03-08 11:26:55 +1100:
> Any reason for adding these extra lines as part of this commit?

mpe asked for some newlines here in the v1 submission, and it only
really made sense to do so if all the related sections had consistent
whitespace as well.

> > +/*
> > + * AFU driver ops allows an AFU driver to create their own events to pass to
> > + * userspace through the file descriptor as a simpler alternative to overriding
> > + * the read() and poll() calls that works with the generic cxl events. These
> > + * events are given priority over the generic cxl events, so will be delivered
> 
> so _they_ will be delivered

thanks for spotting that...

> > + *
> > + * even_pending() will be called by the cxl driver to check if an event is
> > + * pending (e.g. in select/poll/read calls).
> 
> event_pending() <- missing 't'

...and that.

Cheers,
-Ian
