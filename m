Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95698DDEEB
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 09:54:08 +1000 (EST)
Date: Wed, 22 Aug 2007 16:53:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [Kgdb-bugreport] 2.6.23-rc3-mm1: kgdb build failure on powerpc
Message-Id: <20070822165318.b82da13c.akpm@linux-foundation.org>
In-Reply-To: <46CCBC3C.7010307@windriver.com>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>
	<200708222104.29432.m.kozlowski@tuxland.pl>
	<20070822124743.fc316963.akpm@linux-foundation.org>
	<46CCBC3C.7010307@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kgdb-bugreport@lists.sourceforge.net, amitkale@linsyssoft.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 22 Aug 2007 17:44:12 -0500
Jason Wessel <jason.wessel@windriver.com> wrote:

> Perhaps there is a cleaner way to do the same thing and avoid the 
> cmpxchg all together.  I used the attached patch to eliminate the 
> cmpxchg operation.
> 
> 
> Jason.
> 
> 
> [kgdb_enter_atomic.patch  text/plain (2.0KB)]
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> 
> ---
>  kernel/kgdb.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> --- a/kernel/kgdb.c
> +++ b/kernel/kgdb.c
> @@ -121,6 +121,7 @@ struct task_struct *kgdb_usethread, *kgd
>  
>  int debugger_step;
>  atomic_t debugger_active;
> +static atomic_t kgdb_sync = ATOMIC_INIT(-1);
>  
>  /* Our I/O buffers. */
>  static char remcom_in_buffer[BUFMAX];
> @@ -638,8 +639,14 @@ static void kgdb_wait(struct pt_regs *re
>  	kgdb_info[processor].task = current;
>  	atomic_set(&procindebug[processor], 1);
>  
> +	/* The master processor must be active to enter here, but this is
> +	 * gaurd in case the master processor had not been selected if
> +	 * this was an entry via nmi.
> +	 */
> +	while (!atomic_read(&debugger_active));

eek.  We're in the process of hunting down and eliminating exactly this
construct.  There have been cases where the compiler cached the
atomic_read() result in a register, turning the above into an infinite
loop.

Plus we should never add power-burners like that into the kernel anyway. 
That loop should have a cpu_relax() in it.  Which will also fix the
compiler problem described above.

Thirdly, please always add a newline when coding statements like that:

	while (expr())
		;
