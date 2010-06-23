Return-Path: <BATV+8d3bbc5e89a8a81f1be1+2495+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49ED2B7111
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 22:41:21 +1000 (EST)
Date: Wed, 23 Jun 2010 08:41:07 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
Message-ID: <20100623124106.GA13200@infradead.org>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
	<4C21DFBA.2070202@linux.intel.com> <20100623102931.GB5242@nowhere>
	<4C21E3F8.9000405@linux.intel.com> <20100623113806.GD5242@nowhere>
	<4C21FF9A.2040207@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C21FF9A.2040207@linux.intel.com>
Cc: Christoph Lameter <cl@linux-foundation.org>, WANG Cong <amwang@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Sam Ravnborg <sam@ravnborg.org>, Mike Frysinger <vapier.adi@gmail.com>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>,
	David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Jun 23, 2010 at 02:35:38PM +0200, Andi Kleen wrote:
> >I haven't heard any complains about existing syscalls wrappers.
> 
> At least for me they always interrupt my grepping.
> 
> >
> >What kind of annotations could solve that?
> 
> If you put the annotation in a separate macro and leave the original
> prototype alone. Then C parsers could still parse it.

I personally hate the way SYSCALL_DEFINE works with passion, mostly
for the grep reason, but also because it looks horribly ugly.

But there is no reason not to be consistent here.  We already use
the wrappers for all native system calls, so leaving the compat
calls out doesn't make any sense.  And I'd cheer for anyone who
comes up with a better scheme for the native and compat wrappers.
