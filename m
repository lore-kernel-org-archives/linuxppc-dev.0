Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA313DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 19:56:25 +1000 (EST)
Date: Tue, 30 Sep 2008 11:55:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] sputrace : use marker_synchronize_unregister()
Message-ID: <20080930095520.GB7557@elte.hu>
References: <48E08B05.7030802@cn.fujitsu.com> <20080929082722.GB18663@elte.hu>
	<20080929151147.GH11245@Krystal> <200809301028.21485.jk@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809301028.21485.jk@ozlabs.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	cbe-oss-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Jeremy Kerr <jk@ozlabs.org> wrote:

> Mathieu,
> 
> > We need a marker_synchronize_unregister() before the end of exit() to
> > make sure every probe callers have exited the non preemptible section
> > and thus are not executing the probe code anymore.
> 
> Looks good - added to spufs.git.

that wont work very well as the patch relies on the new 
marker_synchronize_unregister() facility.

	Ingo
