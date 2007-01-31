Return-Path: <miltonm@bga.com>
In-Reply-To: <45BE4FA4.9020105@us.ibm.com>
References: <45BE4FA4.9020105@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f00c5b64177eafd5445b9da2c8432aa8@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Wed, 31 Jan 2007 03:24:56 -0600
To: Maynard Johnson <maynardj@us.ibm.com>,
 Carl Love <carll@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've actually read most of the replys.   Hopefully I included enough
headers to get my mailer to put this in the right thread.

Sorry if I missed someone on cc, the mail archives don't
give one that info.


On Jan 30, 2007, at 5:48 AM, Maynard Johnson wrote:

>
> Subject: Add support to OProfile for profiling Cell BE SPUs
>
> From: Maynard Johnson <maynardj@us.ibm.com>
>
> This patch updates the existing arch/powerpc/oprofile/op_model_cell.c
> to add in the SPU profiling capabilities.  In addition, a 'cell' 
> subdirectory
> was added to arch/powerpc/oprofile to hold Cell-specific SPU profiling
> code.
>
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
> Index: linux-2.6.20-rc1/arch/powerpc/oprofile/cell/pr_util.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.20-rc1/arch/powerpc/oprofile/cell/pr_util.h	2007-01-29 
> 10:32:03.388789304 -0600
...
> +typedef struct vma_map
> +{
> +	struct vma_map *next;
> +	unsigned int vma;
> +	unsigned int size;
> +	unsigned int offset;
> +	unsigned int guard_ptr;
> +	unsigned int guard_val;
> +} vma_map_t;
> +
> +/* The three functions below are for maintaining and accessing
> + * the vma-to-file offset map.
> + */
> +vma_map_t * create_vma_map(const struct spu * spu, u64 objectid);
> +unsigned int vma_map_lookup(vma_map_t *map, unsigned int vma,
> +			    const struct spu * aSpu);
> +void vma_map_free(struct vma_map *map);
> +

Why would the SPU to cookie translation need to be different
than the standard vm one?   Is it that spufs takes refs on the
pages but doesn't have the standard vma?   Maybe an approach
of creating them would reuse the oprofile code.

> Index: linux-2.6.20-rc1/arch/powerpc/oprofile/cell/spu_profiler.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ 
> linux-2.6.20-rc1/arch/powerpc/oprofile/cell/spu_profiler.c	2007-01-29 
> 10:32:03.392788696 -0600
...
> +#define TRACE_ARRAY_SIZE 1024
> +static u32 * samples;
> +static u32 * samples_per_node;
> +
> +static int spu_prof_running = 0;
> +static unsigned int profiling_interval = 0;
> +
> +extern int num_nodes;
> +extern unsigned int khzfreq;
> +
> +/*
> + * Oprofile setup functions
> + */
> +
> +#define NUM_SPU_BITS_TRBUF 16
> +#define SPUS_PER_TB_ENTRY   4
> +#define SPUS_PER_NODE       8
> +
> +/*
> + * Collect the SPU program counter samples from the trace buffer.
> + * The global variable usage is as follows:
> + *    samples[<total-spus>][TRACE_ARRAY_SIZE] - array to store SPU PC 
> samples
> + *           Assumption, the array will be all zeros on entry.
> + *    u32 samples_per_node[num_nodes] - array of how many valid 
> samples per node
> + */
> +static void cell_spu_pc_collection(void)
> +{
> +	int cpu;
> +	int node;
> +	int spu;
> +	u32 trace_addr;
> +        /* the trace buffer is 128 bits */
> +	u64 trace_buffer[2];
> +	u64 spu_pc_lower;
> +	u64 spu_pc_upper;
> +	u64 spu_mask;
> +	int entry, node_factor;
> +	// process the collected SPU PC for each node
> +	for_each_online_cpu(cpu) {
> +		if (cbe_get_hw_thread_id(cpu))
> +			continue;
> +
> +		node = cbe_cpu_to_node(cpu);
> +		node_factor = node * SPUS_PER_NODE;
> +                /* number of valid entries for this node */
> +		entry = 0;
> +
> +		trace_addr = cbe_read_pm(cpu, trace_address);
> +		while ((trace_addr & CBE_PM_TRACE_BUF_EMPTY) != 0x400)
> +		{
> +			/* there is data in the trace buffer to process */
> +			cbe_read_trace_buffer(cpu, trace_buffer);
> +			spu_mask = 0xFFFF000000000000;
> +
> +			/* Each SPU PC is 16 bits; hence, four spus in each of
> +			 * the two 64-bit buffer entries that make up the
> +			 * 128-bit trace_buffer entry.  Process the upper and
> +			 * lower 64-bit values simultaneously.
> +			 */
> +			for (spu = 0; spu < SPUS_PER_TB_ENTRY; spu++) {
> +				spu_pc_lower = spu_mask & trace_buffer[0];
> +				spu_pc_lower = spu_pc_lower >> (NUM_SPU_BITS_TRBUF
> +								* (SPUS_PER_TB_ENTRY-spu-1));
>

Calculating the shift each time through the loop has to be inefficient.

As mentioned by others, I would suggest making this loop split
the value into the 4 parts.   It would probably be better to
shift the raw data to the left each pass, and then always take
the top 16 bits and shift them down low.

> +
> +				spu_pc_upper = spu_mask & trace_buffer[1];
> +				spu_pc_upper = spu_pc_upper >> (NUM_SPU_BITS_TRBUF
> +								* (SPUS_PER_TB_ENTRY-spu-1));
> +
> +				spu_mask = spu_mask >> NUM_SPU_BITS_TRBUF;
> +
> +				/* spu PC trace entry is upper 16 bits of the
> +				 * 18 bit SPU program counter
> +				 */
> +				spu_pc_lower = spu_pc_lower << 2;
> +				spu_pc_upper = spu_pc_upper << 2;
> +
> +				samples[((node_factor + spu) * TRACE_ARRAY_SIZE) + entry]
> +					= (u32) spu_pc_lower;
> +				samples[((node_factor + spu + SPUS_PER_TB_ENTRY) * 
> TRACE_ARRAY_SIZE) + entry]
> +					= (u32) spu_pc_upper;
> +			}
> +
> +			entry++;
> +
> +			if (entry >= TRACE_ARRAY_SIZE)
> +				/* spu_samples is full */
> +				break;
> +
> +			trace_addr = cbe_read_pm(cpu, trace_address);
> +		}

looks more like a for loop to me ... its
for (a=func; a & bit, a = func)

Actually, i'd probably change this to

for (entry = 0; entry < trace size; entry++)
{
     a = read_trace_data(x);
     if (trace_not_valid)
		break;

	spilt sample per notes aove;
}


Rational: the stop for entrys is absolute
    you are processing data to fill, which eliminates
    duplicate obtain_data code.
Its obvious you should stop if you are full
(aside) the timer should be set to avoid full,
but delays could cause it to fill.   Perhaps
if we fill we should slightly reduce the timer
period?


> +		samples_per_node[node] = entry;
> +	}
> +}
> +
> +


> +/*
> + * Entry point for SPU profiling.
> + * NOTE:  SPU profiling is done system-wide, not per-CPU.
> + *
> + * cycles_reset is the count value specified by the user when
> + * setting up OProfile to count SPU_CYCLES.
> + */
> +void start_spu_profiling(unsigned int cycles_reset) {
> +
> +	ktime_t kt;
> +
> +        /* To calculate a timeout in nanoseconds, the basic
> +	 * formula is ns = cycles_reset * (NSEC_PER_SEC / cpu frequency).
> +	 * To avoid floating point math, we use the scale math
> +	 * technique as described in linux/jiffies.h.  We use
> +	 * a scale factor of SCALE_SHIFT,which provides 4 decimal places
> +	 * of precision, which is close enough for the purpose at hand.
> +	 */
> +
> +	/* Since cpufreq_quick_get returns frequency in kHz, we use
> +	 * USEC_PER_SEC here vs NSEC_PER_SEC.
> +	 */
> +	unsigned long nsPerCyc = (USEC_PER_SEC << SCALE_SHIFT)/khzfreq;
> +	profiling_interval = (nsPerCyc * cycles_reset) >> SCALE_SHIFT;
> +	
> +	pr_debug("timer resolution: %lu\n",
> +		 TICK_NSEC);
> +	kt = ktime_set(0, profiling_interval);
> +	hrtimer_init(&timer, CLOCK_MONOTONIC, HRTIMER_REL);
> +	timer.expires = kt;
> +	timer.function = profile_spus;
> +
> +        /* Allocate arrays for collecting SPU PC samples */
> +	samples = (u32 *) kzalloc(num_nodes * SPUS_PER_NODE * 
> TRACE_ARRAY_SIZE * sizeof(u32), GFP_ATOMIC);
> +	samples_per_node = (u32 *) kzalloc(num_nodes * sizeof(u32), 
> GFP_ATOMIC);
> +
> +	spu_prof_running = 1;
> +	hrtimer_start(&timer, kt, HRTIMER_REL);
> +}


So we are doing all this calculations, including adding cpufreq
dependencys, just to caculate once how often to dump the
trace array once?

And then we have all the convert-to-lfsr in the kernel, which
as people noticed will run up to 2^24 loops of bit manuplitions
as specified by the user ....

I would propose instead the user space code passes (1) the
requested dump interval and (2) the computed lfsr value to
load.

The kernel can impose sanity checks on the interrupt rate.
The invalid lfsr value is known (0), so that means that
that the worse that could happen is (1) user space programs
too small of a count, and we don't dump the trace competely.
or (2) we dump more often that we need to.  If we want to
correct or tune, we (1) can be detected and the kernel
gradually reduce the poll interval; (2) can be detected by
empty trace arrays on timer with no intervening context switch
dump; and only results in interrupt overhead wich can be
limited by sanity checks (bounds testing).

This would also allow a path in the future for userspace to
change the requested sample rates ....


milton
