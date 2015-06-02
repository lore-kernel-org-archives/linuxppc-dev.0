Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84AE61A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 17:02:03 +1000 (AEST)
Message-ID: <1433228517.17489.1.camel@ellerman.id.au>
Subject: Re: [RFC PATCH] powerpc/pseries: Ratelimit EPOW event warnings
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 02 Jun 2015 17:01:57 +1000
In-Reply-To: <20150602050320.GA25216@linux.vnet.ibm.com>
References: <1432787595-9946-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <1433158011.1004.3.camel@ellerman.id.au>
 <20150602050320.GA25216@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-06-02 at 10:33 +0530, Kamalesh Babulal wrote:
> * Michael Ellerman <mpe@ellerman.id.au> [2015-06-01 21:26:51]:
> 
> > On Thu, 2015-05-28 at 10:03 +0530, Kamalesh Babulal wrote:
> > > We print the respective warning after parsing EPOW interrupts,
> > > prompting user to take action depending upon the severity of the
> > > event.
> > > 
> > > Some times same EPOW event warning, such as below could flood kernel
> > > log, within very short duration. So Limit the message by using
> > > ratelimit variant of pr_err.
> > > 
> > > May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
> > > May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
> > > May 25 04:04:24 alp kernel: Non critical power or cooling issue cleared
> > > May 25 04:07:18 alp kernel: Non critical power or cooling issue cleared
> > > May 25 04:13:04 alp kernel: Non critical power or cooling issue cleared
> > > May 25 04:22:04 alp kernel: Non critical power or cooling issue cleared
> > > May 25 04:22:26 alp kernel: Non critical power or cooling issue cleared
> > > May 25 04:22:36 alp kernel: Non critical power or cooling issue cleared
> > 
> > Looking at the time stamps those are actually all fairly far apart in time,
> > aren't they? So do we actually see them within a short duration in practice?
> 
> Thanks for the review. Agree, I should have phrased it better. My intend was to
> say, that these warnings keep flooding the kernel log, over a period of time.

OK. By default printk_ratelimited() allows up to 10 messages in five seconds,
so it won't reduce the number of messages in the above example.

But I'm still OK with a patch to ratelimit them.

> [..]
> > >  	case EPOW_WARN_POWER:
> > > -		pr_err("Non critical power issue reported by firmware");
> > > -		pr_err("Check RTAS error log for details");
> > > +		pr_err_ratelimited("Non critical power issue reported by firmware");
> > > +		pr_err_ratelimited("Check RTAS error log for details");
> > >  		break;
> > 
> > Those last two could be collapsed onto one line which would reduce the spam.
> 
> Yes, it could reduce the number of lines printed. Will resend the patch with the
> changes.

Thanks.

cheers
