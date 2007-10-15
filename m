Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18195.64334.985238.848522@cargo.ozlabs.ibm.com>
Date: Tue, 16 Oct 2007 09:44:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
In-Reply-To: <4713A616.3090103@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor> <4713A616.3090103@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

>     I don't see my own signoff or at least a reference to my prior work in
> this patch or even at -rt patch -- despite this code ha clearly borrowed from
> it.  And I'm not sure why this crippled version (lacking 40x/ Book E specific
> clockevents implementation) is preferred over mine, unless this implementation
> was only aimed at PPC64 machines...

Tony started from an earlier patch by John Stultz, not from your
patches.

The main reason your patches were rejected were that you completely
broke the VDSO and the deterministic time accounting, and made no
attempt to fix them.

As for 40x/Book E, the main thing there is the auto-reload.  However,
since the generic core can use a oneshot clock event source to
generate periodic ticks, there is no advantage to using the
auto-reload.

>     Also, have the deterministic CPU accounting incompatibility with
> clockevents been dealt with?

The S390 guys looked at that and solved it with Ingo's and Thomas's
help (although I did see something on linux-kernel about some further
problems).

>     I'd use (evt - 1) since the interrupt gets generated at 0xffffffff count, 
> not 0 (on classic CPUs).  With you removing of the code that compensated for 

See commit d968014b7280e2c447b20363e576999040ac72ef; I already fixed
that.

> the errors, they will accumulate.  And no, this wouldn't be enough anyway, 

No, they don't accumulate.  See tick_setup_periodic().  The interval
until the next tick is determined using ktime_get() rather than just
being a constant.

> since on 40x and Book E you'll need to set it for evt anyway, since the 
> interrupt happens at 0 count...
>     NAK the patch.  And I really don't understand why you're throwing alway 
> already tested/working code...

Because you broke important features and because you seem to have some
fundamental misconceptions (e.g. the comment about errors accumulating
you just made).

Paul.
