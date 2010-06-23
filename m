Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id 40B46B713F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 21:04:02 +1000 (EST)
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o5NAUqsS022087 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Wed, 23 Jun 2010 19:30:52 +0900
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o5NAUobn028327 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Wed, 23 Jun 2010 19:30:50 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id AECA245DE7C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 19:30:49 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 77ABD45DE70
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 19:30:49 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 462DFE38009
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 19:30:49 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id EB159E38002
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 19:30:48 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
In-Reply-To: <4C21DFBA.2070202@linux.intel.com>
References: <1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
	<4C21DFBA.2070202@linux.intel.com>
Message-Id: <20100623192930.B5A9.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Wed, 23 Jun 2010 19:30:47 +0900 (JST)
Cc: Christoph Lameter <cl@linux-foundation.org>, WANG Cong <amwang@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Sam Ravnborg <sam@ravnborg.org>, Mike Frysinger <vapier.adi@gmail.com>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	kosaki.motohiro@jp.fujitsu.com, Ingo Molnar <mingo@elte.hu>,
	Arnd Bergmann <arnd@arndb.de>, David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Roland McGrath <roland@redhat.com>,
	Lee Schermerhorn <lee.schermerhorn@hp.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Neil Horman <nhorman@tuxdriver.com>, linux-mm@kvack.org,
	netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	Simon Kagstrom <simon.kagstrom@netinsight.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> , Ian Munsie wrote:
> > From: Ian Munsie<imunsie@au1.ibm.com>
> >
> > This patch converts numerous trivial compat syscalls through the generic
> > kernel code to use the COMPAT_SYSCALL_DEFINE family of macros.
> 
> Why? This just makes the code look uglier and the functions harder
> to grep for.

I guess trace-syscall feature need to override COMPAT_SYSCALL_DEFINE. but
It's only guess...
