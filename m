Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 544B4B6FE0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 05:21:37 +1000 (EST)
Date: Wed, 13 Jun 2012 21:19:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Q: a_ops->readpage() && struct file
Message-ID: <20120613191928.GB14246@redhat.com>
References: <20120608093257.GG13409@in.ibm.com>
 <20120611161215.GA12116@redhat.com> <20120611190902.GA19869@redhat.com>
 <1339581492.31548.133.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339581492.31548.133.camel@twins>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 lkml <linux-kernel@vger.kernel.org>, Jim Keniston <jkenisto@us.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Al Viro <viro@ZenIV.linux.org.uk>,
 antonb@thinktux.localdomain, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org, Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13, Peter Zijlstra wrote:
>
> On Mon, 2012-06-11 at 21:09 +0200, Oleg Nesterov wrote:
> > Stupid question. I'm afraid the answer is "no" but I'll ask anyway.
> > Is it safe to pass filp == NULL to mapping->readpage()? In fact
> > I do not understand why it needs "struct file*" and I do not see
> > any example of actual usage.
>
> Looking at afs_readpage it looks like its OK to pass in NULL. Same for
> nfs_readpage. They use the file, if provided, to avoid some lookups, but
> seem to deal with not having it.

Yes, and reiser4 does the same.

> This answer by example is of course not authorative nor complete.

Yes... perhaps we should simply change this code to use NULL and
collect the bug-reports ;)

Oleg.
