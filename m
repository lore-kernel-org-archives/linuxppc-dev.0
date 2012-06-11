Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 5ECCEB6FD3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 05:11:27 +1000 (EST)
Date: Mon, 11 Jun 2012 21:09:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>
Subject: Q: a_ops->readpage() && struct file
Message-ID: <20120611190902.GA19869@redhat.com>
References: <20120608093257.GG13409@in.ibm.com>
 <20120611161215.GA12116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120611161215.GA12116@redhat.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 antonb@thinktux.localdomain, lkml <linux-kernel@vger.kernel.org>,
 michael@ellerman.id.au, Jim Keniston <jkenisto@us.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11, Oleg Nesterov wrote:
>
> Note also that we should move this !UPROBE_COPY_INSN from
> install_breakpoint() to somewhere near alloc_uprobe().

The main problem is, uprobe_register() doesn't have struct file
for read_mapping_page().

Stupid question. I'm afraid the answer is "no" but I'll ask anyway.
Is it safe to pass filp == NULL to mapping->readpage()? In fact
I do not understand why it needs "struct file*" and I do not see
any example of actual usage. Yes, I didn't try to grep very much
and I understand that the filesystem can do something special.
Say it can use file->private_data...

However. There is read_cache_page_gfp() which does use
a_ops->readpage(filp => NULL), and the comment says nothing about
the riskiness.


If not, is there any other way
uprobe_register(struct inode *inode, loff_t offset) can read the
page at this offset?



And btw, read_mapping_page() accepts "void *data". Why? it uses
filler == a_ops->readpage, it shouldn't accept anything but file
pointer?


Please help, I know nothing about vfs.

Oleg.
