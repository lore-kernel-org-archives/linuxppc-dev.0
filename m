Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70F431A09EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 12:49:23 +1100 (AEDT)
Message-ID: <1417139348.2852.17.camel@kernel.crashing.org>
Subject: Re: [PATCH REPOST 3/3] powerpc/vphn: move endianness fixing to
 vphn_unpack_associativity()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Fri, 28 Nov 2014 12:49:08 +1100
In-Reply-To: <20141127102812.7d1e625b@bahia.local>
References: <20141117174216.7717.10926.stgit@bahia.local>
 <20141117174244.7717.83028.stgit@bahia.local>
 <1417045163.5089.67.camel@kernel.crashing.org>
 <20141127102812.7d1e625b@bahia.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-27 at 10:28 +0100, Greg Kurz wrote:
> On Thu, 27 Nov 2014 10:39:23 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Mon, 2014-11-17 at 18:42 +0100, Greg Kurz wrote:
> > > The first argument to vphn_unpack_associativity() is a const long *, but the
> > > parsing code expects __be64 values actually. This is inconsistent. We should
> > > either pass a const __be64 * or change vphn_unpack_associativity() so that
> > > it fixes endianness by itself.
> > > 
> > > This patch does the latter, since the caller doesn't need to know about
> > > endianness and this allows to fix significant 64-bit values only. Please
> > > note that the previous code was able to cope with 32-bit fields being split
> > > accross two consecutives 64-bit values. Since PAPR+ doesn't say this cannot
> > > happen, the behaviour was kept. It requires extra checking to know when fixing
> > > is needed though.
> > 
> > While I agree with moving the endian fixing down, the patch makes me
> > nervous. Note that I don't fully understand the format of what we are
> > parsing here so I might be wrong but ...
> > 
> 
> My understanding of PAPR+ is that H_HOME_NODE_ASSOCIATIVITY returns a sequence of
> numbers in registers R4 to R9 (that is 64 * 6 = 384 bits). The numbers are either
> 16-bit long (if high order bit is 1) or 32-bit long. The remaining unused bits are
> set to 1. 

Ok, that's the bit I was missing. What we get is thus not a memory array
but a register one, which we "incorrectly" swap when writing to memory
inside plpar_hcall9().

Now, I'm not sure that replacing:

-	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
-		retbuf[i] = cpu_to_be64(retbuf[i]);

With:

+		if (j % 4 == 0) {
+			fixed.packed[k] = cpu_to_be64(packed[k]);
+			k++;
+		}

Brings any benefit in term of readability. It makes sense to have a
"first pass" that undoes the helper swapping to re-create the original
"byte stream".

In a second pass, we parse that stream, one 16-bytes at a time, and
we could do so with a simple loop of be16_to_cpup(foo++). I wouldn't
bother with the cast to 32-bit etc... if you encounter a 32-bit case,
you just fetch another 16-bit and do value = (old << 16) | new

I think that should lead to something more readable, no ?

> Of course, in a LE guest, plpar_hcall9() stores flipped values to memory.
> 
> > >  
> > >  #define VPHN_FIELD_UNUSED	(0xffff)
> > >  #define VPHN_FIELD_MSB		(0x8000)
> > >  #define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
> > >  
> > > -	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
> > > -		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED)
> > > +	for (i = 1, j = 0, k = 0; i < VPHN_ASSOC_BUFSIZE;) {
> > > +		u16 field;
> > > +
> > > +		if (j % 4 == 0) {
> > > +			fixed.packed[k] = cpu_to_be64(packed[k]);
> > > +			k++;
> > > +		}
> > 
> > So we have essentially a bunch of 16-bit fields ... the above loads and
> > swap a whole 4 of them at once. However that means not only we byteswap
> > them individually, but we also flip the order of the fields. This is
> > ok ?
> > 
> 
> Yes. FWIW, it is exactly what the current code does.
> 
> > > +		field = be16_to_cpu(fixed.field[j]);
> > > +
> > > +		if (field == VPHN_FIELD_UNUSED)
> > >  			/* All significant fields processed.
> > >  			 */
> > >  			break;
> > 
> > For example, we might have USED,USED,USED,UNUSED ... after the swap, we
> > now have UNUSED,USED,USED,USED ... and we stop parsing in the above
> > line on the first one. Or am I missing something ? 
> > 
> 
> If we get USED,USED,USED,UNUSED from memory, that means the hypervisor
> has returned UNUSED,USED,USED,USED. My point is that it cannot happen:
> why would the hypervisor care to pack a sequence of useful numbers with
> holes in it ? 
> FWIW, I could never observe such a thing in a PowerVM guest... All ones always
> come after the payload.
> 
> > > -		if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
> > > +		if (field & VPHN_FIELD_MSB) {
> > >  			/* Data is in the lower 15 bits of this field */
> > > -			unpacked[i] = cpu_to_be32(
> > > -				be16_to_cpup(field) & VPHN_FIELD_MASK);
> > > -			field++;
> > > +			unpacked[i++] = cpu_to_be32(field & VPHN_FIELD_MASK);
> > > +			j++;
> > >  		} else {
> > >  			/* Data is in the lower 15 bits of this field
> > >  			 * concatenated with the next 16 bit field
> > >  			 */
> > > -			unpacked[i] = *((__be32 *)field);
> > > -			field += 2;
> > > +			if (unlikely(j % 4 == 3)) {
> > > +				/* The next field is to be copied from the next
> > > +				 * 64-bit input value. We must fix it now.
> > > +				 */
> > > +				fixed.packed[k] = cpu_to_be64(packed[k]);
> > > +				k++;
> > > +			}
> > > +
> > > +			unpacked[i++] = *((__be32 *)&fixed.field[j]);
> > > +			j += 2;
> > >  		}
> > >  	}
> > >  
> > > @@ -1460,11 +1479,8 @@ static long hcall_vphn(unsigned long cpu, __be32 *associativity)
> > >  	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
> > >  	u64 flags = 1;
> > >  	int hwcpu = get_hard_smp_processor_id(cpu);
> > > -	int i;
> > >  
> > >  	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
> > > -	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
> > > -		retbuf[i] = cpu_to_be64(retbuf[i]);
> > >  	vphn_unpack_associativity(retbuf, associativity);
> > >  
> > >  	return rc;
> > 
> > 
