Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3Syn49VSzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 20:50:57 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8TAo3Ip059792
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 06:50:54 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d9f9q97a3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 06:50:53 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 29 Sep 2017 04:50:52 -0600
Subject: Re: [linux-next][Oops] memory hot-unplug results fault instruction
 address at /include/linux/list.h:104
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, sachinp
 <sachinp@linux.vnet.ibm.com>, stephen Rothwell <sfr@canb.auug.org.au>,
 linux-next <linux-next@vger.kernel.org>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>
Date: Fri, 29 Sep 2017 16:20:44 +0530
In-Reply-To: <CAGXu5jKMGuc-i0vfZx3TYx4iq35PCF0T1y9zv9A=k7ieES2Qkg@mail.gmail.com>
References: <1505198479.10243.23.camel@abdul>
 <1505893239.30180.24.camel@abdul.in.ibm.com>
 <CAGXu5jKMGuc-i0vfZx3TYx4iq35PCF0T1y9zv9A=k7ieES2Qkg@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-2mxhWy4m+UFkcem4BYKr"
Mime-Version: 1.0
Message-Id: <1506682244.26150.18.camel@abdul>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-2mxhWy4m+UFkcem4BYKr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2017-09-20 at 12:54 -0700, Kees Cook wrote:
> On Wed, Sep 20, 2017 at 12:40 AM, Abdul Haleem
> <abdhalee@linux.vnet.ibm.com> wrote:
> > On Tue, 2017-09-12 at 12:11 +0530, abdul wrote:
> >> Hi,
> >>
> >> Memory hot-unplug on PowerVM LPAR running next-20170911 results in
> >> Faulting instruction address: 0xc0000000002b56c4
> >>
> >> which maps to the below code path:
> >>
> >> 0xc0000000002b56c4 is in __rmqueue (./include/linux/list.h:104).
> >> 99     * This is only for internal list manipulation where we know
> >> 100    * the prev/next entries already!
> >> 101    */
> >> 102   static inline void __list_del(struct list_head * prev, struct
> >> list_head * next)
> >> 103   {
> >> 104           next->prev = prev;
> >> 105           WRITE_ONCE(prev->next, next);
> >> 106   }
> >> 107
> >> 108   /**
> >>
> >
> > I see another kernel Oops when running transparent hugepages
> > de-fragmentation test.
> >
> > And the faulty instruction address again pointing to same code line
> > 0xc00000000026f9f4 is in compaction_alloc (./include/linux/list.h:104)
> >
> > steps to recreate:
> > -----------------
> > 1. Enable transparent hugepages ("always")
> > 2. Turn off the defrag $ echo 0 > khugepaged/defrag
> > 3. Write random to memory path
> > 4. Set huge pages numbers
> > 5. Turn on defrag $ echo 1 > khugepaged/defrag
> >
> >
> > new trace:
> > ----------
> > Unable to handle kernel paging request for data at address
> > 0x5deadbeef0000108
> 
> This looks like use-after-list-removal, that value appears to be LIST_POISON1.
> 
> Try enabling CONFIG_DEBUG_LIST to see if you get better details?

With above config enabled I see below messages and also call traces. But
no kernel Oops.

BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8
index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping



-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



--=-2mxhWy4m+UFkcem4BYKr
Content-Disposition: attachment; filename="memhotplug-traces.txt"
Content-Type: text/plain; name="memhotplug-traces.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rs:main Q:Reg  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rs:main Q:Reg  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rs:main Q:Reg  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rs:main Q:Reg  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rs:main Q:Reg  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rs:main Q:Reg  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rs:main Q:Reg  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
Out of memory: Kill process 622 (docker) score 1 or sacrifice child
Killed process 622 (docker) total-vm:528512kB, anon-rss:33664kB, file-rss:1280kB, shmem-rss:0kB
Out of memory: Kill process 1984 (avocado) score 0 or sacrifice child
Killed process 2031 (sh) total-vm:3136kB, anon-rss:256kB, file-rss:256kB, shmem-rss:0kB
Out of memory: Kill process 1984 (avocado) score 0 or sacrifice child
Killed process 1984 (avocado) total-vm:194816kB, anon-rss:17280kB, file-rss:3072kB, shmem-rss:64kB
Out of memory: Kill process 1945 (avocado) score 0 or sacrifice child
Killed process 1971 (journalctl) total-vm:14016kB, anon-rss:1408kB, file-rss:1856kB, shmem-rss:576kB
Out of memory: Kill process 1945 (avocado) score 0 or sacrifice child
Killed process 1964 (vmstat) total-vm:3392kB, anon-rss:0kB, file-rss:192kB, shmem-rss:0kB
Out of memory: Kill process 1945 (avocado) score 0 or sacrifice child
Killed process 1945 (avocado) total-vm:194304kB, anon-rss:20416kB, file-rss:3456kB, shmem-rss:64kB
Out of memory: Kill process 2033 (drmgr) score 0 or sacrifice child
Killed process 2033 (drmgr) total-vm:11968kB, anon-rss:4096kB, file-rss:1216kB, shmem-rss:0kB
Out of memory: Kill process 598 (rsyslogd) score 0 or sacrifice child
Killed process 598 (rsyslogd) total-vm:227968kB, anon-rss:5312kB, file-rss:1984kB, shmem-rss:0kB
Out of memory: Kill process 770 (sshd) score 0 or sacrifice child
Killed process 789 (bash) total-vm:10432kB, anon-rss:1088kB, file-rss:1216kB, shmem-rss:0kB
Out of memory: Kill process 770 (sshd) score 0 or sacrifice child
Killed process 770 (sshd) total-vm:21184kB, anon-rss:5952kB, file-rss:1408kB, shmem-rss:64kB
Out of memory: Kill process 603 (accounts-daemon) score 0 or sacrifice child
Killed process 603 (accounts-daemon) total-vm:239232kB, anon-rss:2112kB, file-rss:2176kB, shmem-rss:0kB
Out of memory: Kill process 656 (polkitd) score 0 or sacrifice child
Killed process 656 (polkitd) total-vm:235008kB, anon-rss:1536kB, file-rss:960kB, shmem-rss:0kB
BUG: Bad page state: 3614 messages suppressed
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-journal  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process kworker/u32:0  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process sshd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process sshd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process sshd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process docker  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process docker  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process docker  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rsyslogd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rsyslogd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rsyslogd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process systemd-timesyn  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process sshd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process sshd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process sshd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process docker  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process docker  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process docker  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process in:imklog  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rsyslogd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rsyslogd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process rsyslogd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process cron  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process dbus-daemon  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process sshd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process sshd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process sshd  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process docker  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process docker  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process docker  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process avocado  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
BUG: Bad page state in process drmgr  pfn:770c7
page:f000000001dc31c0 count:0 mapcount:0 mapping:f000000001dc31c8 index:0x1
flags: 0x33ffff800000000()
raw: 033ffff800000000 f000000001dc31c8 0000000000000001 00000000ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 0000000000000000
page dumped because: non-NULL mapping
Out of memory: Kill process 638 (login) score 0 or sacrifice child
Killed process 1539 (bash) total-vm:10432kB, anon-rss:64kB, file-rss:640kB, shmem-rss:0kB
Out of memory: Kill process 638 (login) score 0 or sacrifice child
Killed process 638 (login) total-vm:12800kB, anon-rss:4160kB, file-rss:768kB, shmem-rss:0kB
Out of memory: Kill process 773 ((sd-pam)) score 0 or sacrifice child
Killed process 773 ((sd-pam)) total-vm:12416kB, anon-rss:704kB, file-rss:0kB, shmem-rss:0kB
Out of memory: Kill process 308 (systemd-journal) score 0 or sacrifice child
Killed process 308 (systemd-journal) total-vm:23360kB, anon-rss:1216kB, file-rss:704kB, shmem-rss:1920kB
Out of memory: Kill process 772 (systemd) score 0 or sacrifice child
Killed process 772 (systemd) total-vm:9152kB, anon-rss:0kB, file-rss:640kB, shmem-rss:0kB
Out of memory: Kill process 487 (systemd-timesyn) score 0 or sacrifice child
Killed process 487 (systemd-timesyn) total-vm:79552kB, anon-rss:512kB, file-rss:768kB, shmem-rss:0kB
Out of memory: Kill process 616 (systemd-logind) score 0 or sacrifice child
Killed process 616 (systemd-logind) total-vm:6464kB, anon-rss:1152kB, file-rss:704kB, shmem-rss:0kB
Out of memory: Kill process 605 (cron) score 0 or sacrifice child
Killed process 605 (cron) total-vm:8576kB, anon-rss:0kB, file-rss:704kB, shmem-rss:0kB
Out of memory: Kill process 607 (irqbalance) score 0 or sacrifice child
Killed process 607 (irqbalance) total-vm:6720kB, anon-rss:448kB, file-rss:704kB, shmem-rss:0kB
Out of memory: Kill process 637 (agetty) score 0 or sacrifice child
Killed process 637 (agetty) total-vm:6976kB, anon-rss:0kB, file-rss:640kB, shmem-rss:0kB
Out of memory: Kill process 606 (dbus-daemon) score 0 or sacrifice child
Killed process 606 (dbus-daemon) total-vm:9472kB, anon-rss:896kB, file-rss:704kB, shmem-rss:0kB
Kernel panic - not syncing: Out of memory and no killable processes...

CPU: 10 PID: 773 Comm: (sd-pam) Tainted: G    B   W       4.14.0-rc2-next-20170928-autotest #2
Call Trace:
[c000000005852fc0] [c000000000c24540] dump_stack+0xb0/0xf0 (unreliable)
[c000000005853000] [c000000000101194] panic+0x140/0x30c
[c000000005853090] [c0000000002b8530] out_of_memory+0x4e0/0x650
[c000000005853130] [c0000000002c04e8] __alloc_pages_nodemask+0x10a8/0x1160
[c000000005853330] [c00000000034b718] alloc_pages_vma+0xb8/0x290
[c0000000058533a0] [c0000000003311e8] __read_swap_cache_async+0x1f8/0x310
[c000000005853420] [c000000000331350] read_swap_cache_async+0x50/0x90
[c000000005853480] [c000000000331640] swapin_readahead+0x2b0/0x3a0
[c000000005853540] [c00000000030a8b4] do_swap_page+0x464/0xa60
[c0000000058535d0] [c00000000030f458] __handle_mm_fault+0xd38/0x1ad0
[c0000000058536b0] [c000000000310318] handle_mm_fault+0x128/0x210
[c0000000058536f0] [c000000000067878] __do_page_fault+0x218/0x8e0
[c0000000058537a0] [c00000000000a4a4] handle_page_fault+0x18/0x38
--- interrupt: 301 at exit_robust_list+0x7c/0x240
    LR = mm_release+0x158/0x1c0
[c000000005853a90] [c000000000c3ef84] _cond_resched+0x34/0xa0 (unreliable)
[c000000005853b00] [c0000000000fdaf8] mm_release+0x158/0x1c0
[c000000005853b30] [c000000000107a40] do_exit+0x1b0/0xcc0
[c000000005853bf0] [c000000000108634] do_group_exit+0x64/0x100
[c000000005853c30] [c00000000011a88c] get_signal+0x54c/0x760
[c000000005853d10] [c00000000001d208] do_signal+0x68/0x2c0
[c000000005853e00] [c00000000001d670] do_notify_resume+0xc0/0xf0
[c000000005853e30] [c00000000000b744] ret_from_except_lite+0x70/0x74
---[ end Kernel panic - not syncing: Out of memory and no killable processes...

------------[ cut here ]------------
WARNING: CPU: 10 PID: 773 at kernel/sched/core.c:1178 set_task_cpu+0x200/0x260
Modules linked in: rpadlpar_io rpaphp xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 iptable_filter ip_tables x_tables nf_nat nf_conntrack bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c rtc_generic vmx_crypto pseries_rng autofs4
CPU: 10 PID: 773 Comm: (sd-pam) Tainted: G    B   W       4.14.0-rc2-next-20170928-autotest #2
task: c00000000579cc00 task.stack: c000000005850000
NIP:  c000000000143500 LR: c0000000001441b4 CTR: c0000000001508e0
REGS: c000000005852580 TRAP: 0700   Tainted: G    B   W        (4.14.0-rc2-next-20170928-autotest)
MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28242424  XER: 00000001
CFAR: c0000000001433ac SOFTE: 0 
GPR00: c0000000001441b4 c000000005852800 c0000000015ac700 c0000007769c1700 
GPR04: 0000000000000000 0000000000000000 0000000000000001 0000000000000001 
GPR08: 0000000000000000 0000000000000400 c0000000015e1ed0 c00000077a000028 
GPR12: 0000000028242444 c00000000e746900 0000000000000001 00000000014200ca 
GPR16: c00000077e230000 c0000000014f9d70 c000000000e94cd0 0000000000000001 
GPR20: c0000000010ca8a8 0000000000000000 c000000001772858 0000000000000000 
GPR24: c0000000015ddd78 c0000007769c1b38 c0000000010e6680 0000000000000000 
GPR28: 0000000000000000 0000000000000004 0000000000000000 c0000007769c1700 
NIP [c000000000143500] set_task_cpu+0x200/0x260
LR [c0000000001441b4] try_to_wake_up+0x1d4/0x5d0
Call Trace:
[c000000005852800] [c0000000010e6680] runqueues+0x0/0xb00 (unreliable)
[c000000005852840] [c0000000001441b4] try_to_wake_up+0x1d4/0x5d0
[c0000000058528c0] [c000000000124460] insert_work+0xe0/0x130
[c000000005852910] [c000000000127140] __queue_work+0x200/0x610
[c0000000058529f0] [c0000000001a8210] call_timer_fn+0x60/0x1d0
[c000000005852a80] [c0000000001a8488] expire_timers+0xc8/0x1e0
[c000000005852af0] [c0000000001a8758] run_timer_softirq+0x1b8/0x240
[c000000005852b90] [c000000000c46430] __do_softirq+0x170/0x3dc
[c000000005852c80] [c00000000010a028] irq_exit+0xe8/0x120
[c000000005852ca0] [c000000000025788] timer_interrupt+0xa8/0x110
[c000000005852ce0] [c000000000008f74] decrementer_common+0x114/0x120
--- interrupt: 901 at udelay+0x50/0x80
    LR = panic+0x2f8/0x30c
[c000000005852fd0] [c000000005853000] 0xc000000005853000 (unreliable)
[c000000005853000] [c00000000010134c] panic+0x2f8/0x30c
[c000000005853090] [c0000000002b8530] out_of_memory+0x4e0/0x650
[c000000005853130] [c0000000002c04e8] __alloc_pages_nodemask+0x10a8/0x1160
[c000000005853330] [c00000000034b718] alloc_pages_vma+0xb8/0x290
[c0000000058533a0] [c0000000003311e8] __read_swap_cache_async+0x1f8/0x310
[c000000005853420] [c000000000331350] read_swap_cache_async+0x50/0x90
[c000000005853480] [c000000000331640] swapin_readahead+0x2b0/0x3a0
[c000000005853540] [c00000000030a8b4] do_swap_page+0x464/0xa60
[c0000000058535d0] [c00000000030f458] __handle_mm_fault+0xd38/0x1ad0
[c0000000058536b0] [c000000000310318] handle_mm_fault+0x128/0x210
[c0000000058536f0] [c000000000067878] __do_page_fault+0x218/0x8e0
[c0000000058537a0] [c00000000000a4a4] handle_page_fault+0x18/0x38
--- interrupt: 301 at exit_robust_list+0x7c/0x240
    LR = mm_release+0x158/0x1c0
[c000000005853a90] [c000000000c3ef84] _cond_resched+0x34/0xa0 (unreliable)
[c000000005853b00] [c0000000000fdaf8] mm_release+0x158/0x1c0
[c000000005853b30] [c000000000107a40] do_exit+0x1b0/0xcc0
[c000000005853bf0] [c000000000108634] do_group_exit+0x64/0x100
[c000000005853c30] [c00000000011a88c] get_signal+0x54c/0x760
[c000000005853d10] [c00000000001d208] do_signal+0x68/0x2c0
[c000000005853e00] [c00000000001d670] do_notify_resume+0xc0/0xf0
[c000000005853e30] [c00000000000b744] ret_from_except_lite+0x70/0x74
Instruction dump:
e93d0019 2fa90000 409effd8 4bfffed8 893f0644 61290004 993f0644 4bffff10 
0fe00000 4bfffe6c 60000000 60420000 <0fe00000> 4bfffeac 60000000 60420000 
---[ end trace 9911bc072ee2c322 ]---



--=-2mxhWy4m+UFkcem4BYKr--
