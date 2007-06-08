Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54A11DDE42
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 07:12:37 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l58LCXhH010059
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2007 17:12:33 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l58LCXbS216230
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2007 15:12:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l58LCX8a019228
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2007 15:12:33 -0600
Subject: Re: [PATCH 1/3] [PATCH i386] during VM oom condition, kill all
	threads in process group
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070608123230.520655f5.akpm@linux-foundation.org>
References: <20070605174831.21740.33119.stgit@farscape.rchland.ibm.com>
	<20070607153459.2a1b3230.akpm@linux-foundation.org>
	<20070607231621.GB32549@kryten>
	<20070607171018.d51fc5da.akpm@linux-foundation.org>
	<1181330358.21409.31.camel@farscape.rchland.ibm.com>
	<20070608123230.520655f5.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 16:12:26 -0500
Message-Id: <1181337147.21409.42.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Anton Blanchard <anton@samba.org>, Oleg Nesterov <oleg@tv-sign.ru>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-08 at 12:32 -0700, Andrew Morton wrote:
> On Fri, 08 Jun 2007 14:19:18 -0500
> Will Schmidt <will_schmidt@vnet.ibm.com> wrote:
> 
> > > > > zap_other_threads() requires tasklist_lock.
> > 

> In fact, it's probably the case that rcu_read_lock() is now sufficient
> locking coverage for zap_other_threads() (cc's people).
> 
> It had better be, because do_group_exit() forgot to take tasklist_lock.  It
> is perhaps relying upon spin_lock()'s hidden rcu_read_lock() properties
> without so much as a code comment, which would be somewhat nasty of it.

> You could perhaps just call do_group_exit() from within the fault
> handler,
> btw.

Yup, so looks like I can actually replace the existing do_exit() call
with do_group_exit().   I'll sit on this for a bit to give other folks a
chance to comment on which lock call is sufficient, read_lock() or
rcu_read_lock(), etc;  and do_group_exit()'s issue with taking
tasklist_lock. 

Thanks,

-Will
