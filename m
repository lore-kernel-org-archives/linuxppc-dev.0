Return-Path: <paulus@ozlabs.org>
Date: Thu, 16 Feb 2012 15:57:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: perf: power_pmu_start restores incorrect
 values, breaking frequency events
Message-ID: <20120216045749.GA25364@bloggs.ozlabs.ibm.com>
References: <20120216154822.5bfad11d@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120216154822.5bfad11d@kryten>
Cc: gleb@redhat.com, peterz@infradead.org, vince@deater.net, eranian@google.com,
 linux-kernel@vger.kernel.org, andi@firstfloor.org, emunson@mgebm.net,
 mingo@elte.hu, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 wcohen@redhat.com, asharma@fb.com, imunsie@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 03:48:22PM +1100, Anton Blanchard wrote:
> 
> perf on POWER stopped working after commit e050e3f0a71b (perf: Fix
> broken interrupt rate throttling). That patch exposed a bug in
> the POWER perf_events code.
> 
> Since the PMCs count upwards and take an exception when the top bit
> is set, we want to write 0x80000000 - left in power_pmu_start. We were
> instead programming in left which effectively disables the counter
> until we eventually hit 0x80000000. This could take seconds or longer.
> 
> With the patch applied I get the expected number of samples:
> 
> # taskset -c 0 yes > /dev/null &
> # perf record -C 0 -a sleep 10
> # perf report -D | grep SAMPLE | tail -1
>           SAMPLE events:       9948
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Paul Mackerras <paulus@samba.org>
