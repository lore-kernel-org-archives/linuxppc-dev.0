Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id AB8AA2C032B
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2014 06:31:59 +1100 (EST)
Date: Thu, 6 Mar 2014 18:06:48 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH 3/3] perf: Use 64-bit value when comparing sample_regs
Message-ID: <20140306170648.GA1269@krava.brq.redhat.com>
References: <1394080919-17957-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1394080919-17957-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6D3983@AcuExch.aculab.com>
 <20140306113332.GA7827@visitor2.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140306113332.GA7827@visitor2.iram.es>
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stephane Eranian <eranian@google.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 'Sukadev Bhattiprolu' <sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 06, 2014 at 12:33:32PM +0100, Gabriel Paubert wrote:
> On Thu, Mar 06, 2014 at 09:44:47AM +0000, David Laight wrote:
> > From: Sukadev Bhattiprolu
> > > When checking whether a bit representing a register is set in
> > > sample_regs, a 64-bit mask, use 64-bit value (1LL).
> > > 
> > > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > > ---
> > >  tools/perf/util/unwind.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/unwind.c b/tools/perf/util/unwind.c
> > > index 742f23b..2b888c6 100644
> > > --- a/tools/perf/util/unwind.c
> > > +++ b/tools/perf/util/unwind.c
> > > @@ -396,11 +396,11 @@ static int reg_value(unw_word_t *valp, struct regs_dump *regs, int id,
> > >  {
> > >  	int i, idx = 0;
> > > 
> > > -	if (!(sample_regs & (1 << id)))
> > > +	if (!(sample_regs & (1LL << id)))
> > >  		return -EINVAL;
> > > 
> > >  	for (i = 0; i < id; i++) {
> > > -		if (sample_regs & (1 << i))
> > > +		if (sample_regs & (1LL << i))
> > >  			idx++;
> > >  	}
> > 
> > There are much faster ways to count the number of set bits, especially
> > if you might need to check a significant number of bits.
> > There might even be a function defined somewhere to do it.
> 
> Indeed, look for Hamming weight (hweight family of functions)
> in asm/hweight.h and what is included from there.
> 
> Besides that, many modern processors also have a machine instruction
> to perform this task. In the processor manuals the instruction is 
> described as population count and the mnemonic starts with "popcnt"
> on x86 and ppc.
> 
> 	Gabriel
> 
> > Basically you just add up the bits, for 16 bit it would be:
> > 	val = (val & 0x5555) + (val >> 1) & 0x5555;
> > 	val = (val & 0x3333) + (val >> 2) & 0x3333;
> > 	val = (val & 0x0f0f) + (val >> 4) & 0x0f0f;
> > 	val = (val & 0x00ff) + (val >> 8) & 0x00ff;
> > As the size of the work increases the improvement is more significant.
> > (Some of the later masking can probably be proven unnecessary.)

right I think the loop could be replaced by:

  idx = hweight(mask & ((1 << id) - 1))

Sukadev,
please also rebase against latest Arnaldo's perf/core,
this code has changed just recently, it's now in:
  util/perf_regs.c:perf_reg_value

thanks,
jirka
