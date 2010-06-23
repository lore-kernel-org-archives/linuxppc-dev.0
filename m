Return-Path: <fweisbec@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id B4640B70B9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 21:38:07 +1000 (EST)
Received: by bwz1 with SMTP id 1so2371508bwz.15
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 04:38:04 -0700 (PDT)
Date: Wed, 23 Jun 2010 13:38:07 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
Message-ID: <20100623113806.GD5242@nowhere>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
	<4C21DFBA.2070202@linux.intel.com> <20100623102931.GB5242@nowhere>
	<4C21E3F8.9000405@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C21E3F8.9000405@linux.intel.com>
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

On Wed, Jun 23, 2010 at 12:37:44PM +0200, Andi Kleen wrote:
> , Frederic Weisbecker wrote:
>> On Wed, Jun 23, 2010 at 12:19:38PM +0200, Andi Kleen wrote:
>>> , Ian Munsie wrote:
>>>> From: Ian Munsie<imunsie@au1.ibm.com>
>>>>
>>>> This patch converts numerous trivial compat syscalls through the generic
>>>> kernel code to use the COMPAT_SYSCALL_DEFINE family of macros.
>>>
>>> Why? This just makes the code look uglier and the functions harder
>>> to grep for.
>>
>>
>> Because it makes them usable with syscall tracing.
>
> Ok that information is missing in the changelog then.


Agreed, the changelog lacks the purpose of what it does.



> Also I hope the uglification<->usefullness factor is really worth it.
> The patch is certainly no slouch on the uglification side.


It's worth because the kernel's syscall tracing is not complete, we lack all
the compat part.

These wrappers let us create TRACE_EVENT() for every syscalls automatically.
If we had to create them manually, the uglification would be way much more worse.

Most syscalls use the syscall wrappers already, so the uglification
is there mostly. We just forgot to uglify a bunch of them :)


> It also has maintenance costs, e.g. I doubt ctags and cscope
> will be able to deal with these kinds of macros, so it has a
> high cost for everyone using these tools. For those
> it would be actually better if you used separate annotation
> that does not confuse standard C parsers.


I haven't heard any complains about existing syscalls wrappers.

What kind of annotations could solve that?
