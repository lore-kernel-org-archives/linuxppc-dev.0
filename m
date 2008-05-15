Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [PATCH] Updated: Reworked Cell OProfile: SPU mutex lock fix
Date: Thu, 15 May 2008 17:39:25 +0200
References: <1209652994.17842.1.camel@carll-linux-desktop>
In-Reply-To: <1209652994.17842.1.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200805151739.26392.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, oprofile-list <oprofile-list@lists.sf.net>,
	cbe-oss-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 01 May 2008, Carl Love wrote:

> Finally, this patch backs out the changes previously added to the 
> oprofile generic code for handling the architecture specific 
> ops.sync_start and ops.sync_stop that allowed the architecture
> to skip the per CPU buffer creation.

Thanks for your patch, it looks a lot better than your previous version.
It would be good to have an oprofile person look into the changes
to the common code though.

Just a few more comments/questions this time:

> -static DEFINE_SPINLOCK(buffer_lock);
> +static DEFINE_SPINLOCK(add_value_lock);
>  static DEFINE_SPINLOCK(cache_lock);
>  static int num_spu_nodes;
>  int spu_prof_num_nodes;
>  int last_guard_val[MAX_NUMNODES * 8];
> +static int spu_ctx_sw_seen[MAX_NUMNODES * 8];
>  
>  /* Container for caching information about an active SPU task. */
>  struct cached_info {

I noticed now that you are indexing arrays by SPU number. This is not
a good idea, because you make assumptions about the system that may
not be true. Better pass around 'struct spu' pointers and put those
values in there if you need them. Then again, the last_guard_val looks
like you should really store that information in the context instead
of the physical SPU, but that is something else to work on.

Let's leave this one as it is for now and fix the current bug at hand,
but please remember to fix the assumptions in the code later.

> @@ -289,6 +290,7 @@ static int process_context_switch(struct
>  	int retval;
>  	unsigned int offset = 0;
>  	unsigned long spu_cookie = 0, app_dcookie;
> +	int cpu_buf;
>  
>  	retval = prepare_cached_spu_info(spu, objectId);
>  	if (retval)
> @@ -303,17 +305,28 @@ static int process_context_switch(struct
>  		goto out;
>  	}
>  
> -	/* Record context info in event buffer */
> -	spin_lock_irqsave(&buffer_lock, flags);
> -	add_event_entry(ESCAPE_CODE);
> -	add_event_entry(SPU_CTX_SWITCH_CODE);
> -	add_event_entry(spu->number);
> -	add_event_entry(spu->pid);
> -	add_event_entry(spu->tgid);
> -	add_event_entry(app_dcookie);
> -	add_event_entry(spu_cookie);
> -	add_event_entry(offset);
> -	spin_unlock_irqrestore(&buffer_lock, flags);
> +	/* Record context info in event buffer.  Note, there are 4x more
> +	 * SPUs then CPUs.  Map the SPU events/data for a given SPU to
> +	 * the same CPU buffer.  Need to ensure the cntxt switch data and
> +	 * samples stay in order.
> +	 */
> +	cpu_buf = spu->number >> 2;

The ratio of CPUs versus SPUs is anything but fixed, and the CPU numbers
may not start at 0. If you have a hypervisor (think PS3), or you are
running a non-SMP kernel, this is practically always wrong.
Please use get_cpu()/put_cpu() to read the current CPU number instead.
This one needs to be fixed now.

> +	spin_lock_irqsave(&add_value_lock, flags);
> +	oprofile_add_value(ESCAPE_CODE, cpu_buf);
> +	oprofile_add_value(SPU_CTX_SWITCH_CODE, cpu_buf);
> +	oprofile_add_value(spu->number, cpu_buf);
> +	oprofile_add_value(spu->pid, cpu_buf);
> +	oprofile_add_value(spu->tgid, cpu_buf);
> +	oprofile_add_value(app_dcookie, cpu_buf);
> +	oprofile_add_value(spu_cookie, cpu_buf);
> +	oprofile_add_value(offset, cpu_buf);
> +
> +	/* Set flag to indicate SPU PC data can now be written out.  If
> +	 * the SPU program counter data is seen before an SPU context
> +	 * record is seen, the postprocessing will fail.
> +	 */
> +	spu_ctx_sw_seen[spu->number] = 1;
> +	spin_unlock_irqrestore(&add_value_lock, flags);
>  	smp_wmb();	/* insure spu event buffer updates are written */
>  			/* don't want entries intermingled... */
>  out:

How does the spinlock protect you from racing against other values added
for the same CPU?

I'm not sure if this patch can still fix the original bug that you
are trying to solve, although it will certainly be harder to trigger.

If you are using the get_cpu() number for passing down the samples,
it is probably safe because you then can't add anything else to the
same buffer from a different CPU or from an interrupt, but I don't
understand enough about oprofile to be sure about that.

> -	spin_lock_irqsave(&buffer_lock, flags);
> -	add_event_entry(ESCAPE_CODE);
> -	add_event_entry(SPU_PROFILING_CODE);
> -	add_event_entry(num_spu_nodes);
> -	spin_unlock_irqrestore(&buffer_lock, flags);
> +	/* The SPU_PROFILING_CODE escape sequence must proceed
> +	 * the SPU context switch info.
> +	 */
> +	for_each_online_cpu(cpu) {
> +		oprofile_add_value(ESCAPE_CODE, cpu);
> +		oprofile_add_value(SPU_PROFILING_CODE, cpu);
> +		oprofile_add_value((unsigned long int)
> +					    num_spu_nodes, cpu);
> +	}
>  

You are no longer holding a lock while adding the events, which
may be correct as long as no switch_events come in, but it's
still inconsistent. Do you mind just adding the spinlock here
as well?

> @@ -452,31 +464,38 @@ void spu_sync_buffer(int spu_num, unsign
>  			break;
>  		}
>  
> -		add_event_entry(file_offset | spu_num_shifted);
> +		/* We must ensure that the SPU context switch has been written
> +		 * out before samples for the SPU.  Otherwise, the SPU context
> +		 * information is not available and the postprocessing of the
> +		 * SPU PC will fail with no available anonymous map information.
> +		 */
> +		if (spu_ctx_sw_seen[spu_num])
> +			oprofile_add_value((file_offset | spu_num_shifted),
> +						    (spu_num >> 2));

Again, I think this should just be added on the local CPU, as 'spu_num >> 2'
may not be a valid CPU number.

	Arnd <><
