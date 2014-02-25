Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F24A22C0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 10:19:50 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 26 Feb 2014 09:19:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 515343578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 10:19:47 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PMxrIf12517704
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 09:59:53 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1PNJkp1028576
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 10:19:46 +1100
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Read opal error log and export it
 through sysfs interface.
In-Reply-To: <530C23D3.6020203@linux.vnet.ibm.com>
References: <20131216095746.14595.64602.stgit@mars.in.ibm.com>
 <87y515mij4.fsf@river.au.ibm.com> <530C23D3.6020203@linux.vnet.ibm.com>
Date: Wed, 26 Feb 2014 10:19:46 +1100
Message-ID: <87k3cin5kd.fsf@river.au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>>  I think we could provide a better interface with instead having a file
>>  per log message appear in sysfs. We're never going to have more than 128
>>  of these at any one time on the Linux side, so it's not going to bee too
>>  many files.
>
> It is not just about 128 files, we may be adding/removing sysfs node for
> every new log id that gets informed to kernel and ack-ed. In worst case,
> when we have flood of elog errors with user daemon consuming it and
> ack-ing back to get ready for next log in a tight poll, we may
> continuously add/remove the sysfs node for each new <id>.

Do we ever get a storm of hundreds/thousands of them though? If many
come it at once userspace may just be woken up one or two times, as it
would just select() and wait for events.

>>  I've seen some conflicting things on this - is it 2kb or 16kb?
>
> We choose 16kb because we want to pull all the log data and not
> partial.

So the max log size for any one entry is in fact 16kb?

>>  This means we constantly use 128 * sizeof(struct opal_err_log) which
>>  equates to somewhere north of 2MB of memory (due to list overhead).
>> 
>>  I don't think we need to statically allocate this, we can probably just
>>  allocate on-demand as in a typical system you're probably quite
>>  unlikely to have too many of these sitting around (besides, if for
>>  whatever reason we cannot allocate memory at some point, that's okay
>>  because we can read it again later).
>
> The reason we choose to go for static allocation is, we can not afford
> to drop or delay a critical error log due to memory allocation failure.
> OR we can keep static allocations for critical errors and follow dynamic
> allocation for informative error logs.  What do you say?

Userspace is probably going to have to do IO to get the log and ack it,
so it's probably not a huge problem - if we can't allocate a few kb in a
couple of attempts then we likely have bigger problems.

If we were going to have a sustained amount of hundreds/thousands of
these per second then perhaps we'd have other issues, but from what I
understand we're probably only going to have a handful per year on a
typical system? (I am, of course, not talking about our dev systems,
which are rather atypical :)

I'll likely have a patch today that shows kind of what I mean.
