From: Keith Owens <kaos@ocs.com.au>
To: Thomas Graichen <graichen@innominate.de>, thomas.graichen@innominate.de
cc: linuxppc-dev@lists.linuxppc.org, linux-xfs@oss.sgi.com
Subject: Re: SGI XFS on ppc 
In-reply-to: Your message of "31 Jul 2000 00:33:57 GMT."
             <news2mail-8m2hhl$758$1@mate.bln.innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 31 Jul 2000 10:51:36 +1000
Message-ID: <12923.965004696@ocs3.ocs-net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 31 Jul 2000 00:33:57 GMT,
Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.denews-innominate.list.sgi.xfs@innominate.de> wrote:
>i was a bit curious about how hard/easy it would be to get xfs working
>on non intel machines - and this is what i found out about it so far ...
>* first thing in the pagebuf code was that at the ppc the local_bh_count
>  seems to be defined in softirq.h instead of hardirq.h at the x86 - i
>  just added softirq.h to page_buf.c (i think the ppc-dev people
>  should have a look at how to fix this in a clean way)

Linus wants softirq, local_irq_count, local_bh_count plus arch specific
per-cpu counts merged into a single structure which is used on all
systems.  I am doing the patch for this and will be mailing it to
various arch lists later today.

>* kernel now compiled fine but did not link due to unclear ifdefs
>  for the kallsyms stuff (this should be propagated back to
>  whom ever is maintaining the kallsyms stuff)

More specific please.  kallsyms has no ifdefs.  It should only be
included if you select kdb but kdb has not been ported to ppc.  I
maintain modutils, kallsyms and kdb.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
