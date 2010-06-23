Return-Path: <ak@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by ozlabs.org (Postfix) with ESMTP id 9CB42B7112
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:48:02 +1000 (EST)
Message-ID: <4C21E3F8.9000405@linux.intel.com>
Date: Wed, 23 Jun 2010 12:37:44 +0200
From: Andi Kleen <ak@linux.intel.com>
MIME-Version: 1.0
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
	<4C21DFBA.2070202@linux.intel.com> <20100623102931.GB5242@nowhere>
In-Reply-To: <20100623102931.GB5242@nowhere>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Christoph Lameter <cl@linux-foundation.org>, WANG Cong <amwang@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Sam Ravnborg <sam@ravnborg.org>, Mike Frysinger <vapier.adi@gmail.com>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	David Rientjes <rientjes@google.com>,
	Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>,
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

, Frederic Weisbecker wrote:
> On Wed, Jun 23, 2010 at 12:19:38PM +0200, Andi Kleen wrote:
>> , Ian Munsie wrote:
>>> From: Ian Munsie<imunsie@au1.ibm.com>
>>>
>>> This patch converts numerous trivial compat syscalls through the generic
>>> kernel code to use the COMPAT_SYSCALL_DEFINE family of macros.
>>
>> Why? This just makes the code look uglier and the functions harder
>> to grep for.
>
>
> Because it makes them usable with syscall tracing.

Ok that information is missing in the changelog then.

Also I hope the uglification<->usefullness factor is really worth it.
The patch is certainly no slouch on the uglification side.

It also has maintenance costs, e.g. I doubt ctags and cscope
will be able to deal with these kinds of macros, so it has a
high cost for everyone using these tools. For those
it would be actually better if you used separate annotation
that does not confuse standard C parsers.

-Andi
