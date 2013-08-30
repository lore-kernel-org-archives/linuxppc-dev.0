Return-Path: <rkrcmar@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id D80612C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Aug 2013 02:39:01 +1000 (EST)
Date: Fri, 30 Aug 2013 18:37:33 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 1/5] jump_label: factor out the base part of jump_label.h
 to a separate file
Message-ID: <20130830163732.GA2353@hpx.cz>
References: <1377414952-15995-1-git-send-email-haokexin@gmail.com>
 <1377414952-15995-2-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377414952-15995-2-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013-08-25 15:15+0800, Kevin Hao:
> We plan to use the jump label in the cpu/mmu feature check on ppc.
> This will need to include the jump_label.h in several very basic header
> files of ppc which seems to be included by most of the other head
> files implicitly or explicitly. But in the current jump_label.h,
> it also include the "linux/workqueue.h" and this will cause recursive
> inclusion. In order to fix this, we choose to factor out the base
> part of jump_label.h to a separate header file and we can include
> that file instead of jump_label.h to avoid the recursive inclusion.
> No functional change.

"linux/workqueue.h" was included because of deferred keys and they are
split into "linux/jump_label_ratelimit.h" to solve the same problem in
paravirt ticket spinlock series.
(still in -next: 851cf6e7 jump_label: Split jumplabel ratelimit)
