Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D09E1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 15:03:37 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 10:33:34 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5C8ADE004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 10:36:46 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5253SUU59506886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:33:28 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t524F9IG011259
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 09:45:09 +0530
Date: Tue, 2 Jun 2015 10:33:21 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc/pseries: Ratelimit EPOW event warnings
Message-ID: <20150602050320.GA25216@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1432787595-9946-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <1433158011.1004.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1433158011.1004.3.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2015-06-01 21:26:51]:

> On Thu, 2015-05-28 at 10:03 +0530, Kamalesh Babulal wrote:
> > We print the respective warning after parsing EPOW interrupts,
> > prompting user to take action depending upon the severity of the
> > event.
> > 
> > Some times same EPOW event warning, such as below could flood kernel
> > log, within very short duration. So Limit the message by using
> > ratelimit variant of pr_err.
> > 
> > May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
> > May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
> > May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
> > May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
> > May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
> > May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
> > May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
> > May 25 04:04:24 alp kernel: Non critical power or cooling issue cleared
> > May 25 04:07:18 alp kernel: Non critical power or cooling issue cleared
> > May 25 04:13:04 alp kernel: Non critical power or cooling issue cleared
> > May 25 04:22:04 alp kernel: Non critical power or cooling issue cleared
> > May 25 04:22:26 alp kernel: Non critical power or cooling issue cleared
> > May 25 04:22:36 alp kernel: Non critical power or cooling issue cleared
> 
> Looking at the time stamps those are actually all fairly far apart in time,
> aren't they? So do we actually see them within a short duration in practice?

Thanks for the review. Agree, I should have phrased it better. My intend was to
say, that these warnings keep flooding the kernel log, over a period of time.

[..]
> >  	case EPOW_WARN_POWER:
> > -		pr_err("Non critical power issue reported by firmware");
> > -		pr_err("Check RTAS error log for details");
> > +		pr_err_ratelimited("Non critical power issue reported by firmware");
> > +		pr_err_ratelimited("Check RTAS error log for details");
> >  		break;
> 
> Those last two could be collapsed onto one line which would reduce the spam.

Yes, it could reduce the number of lines printed. Will resend the patch with the
changes.

Thanks,
Kamalesh.
