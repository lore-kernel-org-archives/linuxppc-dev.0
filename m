Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A2F6EB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 19:58:32 +1000 (EST)
Message-ID: <1339581492.31548.133.camel@twins>
Subject: Re: Q: a_ops->readpage() && struct file
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Date: Wed, 13 Jun 2012 11:58:12 +0200
In-Reply-To: <20120611190902.GA19869@redhat.com>
References: <20120608093257.GG13409@in.ibm.com>
 <20120611161215.GA12116@redhat.com> <20120611190902.GA19869@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
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

On Mon, 2012-06-11 at 21:09 +0200, Oleg Nesterov wrote:
> Stupid question. I'm afraid the answer is "no" but I'll ask anyway.
> Is it safe to pass filp =3D=3D NULL to mapping->readpage()? In fact
> I do not understand why it needs "struct file*" and I do not see
> any example of actual usage.=20

Looking at afs_readpage it looks like its OK to pass in NULL. Same for
nfs_readpage. They use the file, if provided, to avoid some lookups, but
seem to deal with not having it.

This answer by example is of course not authorative nor complete.
