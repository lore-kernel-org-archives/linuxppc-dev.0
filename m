Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8BF01A070E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 16:58:09 +1000 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 3 Oct 2014 07:58:05 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7A03E17D8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 08:00:14 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s936w39i61931710
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 06:58:03 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s936w28L029454
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 00:58:02 -0600
Date: Fri, 3 Oct 2014 08:57:58 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] [RFC] powerpc/vphn: fix endian issue in NUMA device
 node code
Message-ID: <20141003085758.1b0f39af@bahia.local>
In-Reply-To: <20141002234340.GB20262@linux.vnet.ibm.com>
References: <20141002210621.5615.97402.stgit@bahia.local>
 <20141002234340.GB20262@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Oct 2014 16:43:41 -0700
Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:

> On 02.10.2014 [23:59:15 +0200], Greg Kurz wrote:
> > The associativity domain numbers are obtained from the hypervisor through
> > registers and written into memory by the guest: the packed array passed to
> > vphn_unpack_associativity() is then native-endian, unlike what was assumed
> > in the following commit:
> > 
> > commit b08a2a12e44eaec5024b2b969f4fcb98169d1ca3
> > Author: Alistair Popple <alistair@popple.id.au>
> > Date:   Wed Aug 7 02:01:44 2013 +1000
> > 
> >     powerpc: Make NUMA device node code endian safe
> > 
> > If a CPU home node changes, the topology gets filled with
> > bogus values. This leads to severe performance breakdowns.
> > 
> > This patch does two things:
> > - extract values from the packed array with shifts, in order to be endian
> >   neutral
> > - convert the resulting values to be32 as expected
> > 
> > Suggested-by: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> > 
> > I could test this code in a userland program and obtain the same
> > result in little and big endian. If the 64-bit packed values
> > are:
> > 
> > 0x8001ffffffff0000
> > 0x112200003344ffff
> > 0xffff000055660000
> > 0x7788000099aaffff
> > 0xffff8002ffffffff
> > 0xffffffffffffffff
> > 
> > then the unpacked array is:
> > 
> > 0x00000007
> > 0x00000001
> > 0xffffffff
> > 0x00001122
> > 0x00003344
> > 0xffffffff
> > 0x00005566
> > 0x00007788
> > 0x000099aa
> > 0xffffffff
> > 0x00000002
> > 0xffffffff
> > 0xffffffff
> > 
> > I could not test in a PowerVM guest though, hence the RFC.
> > 
> > --
> > Greg
> > 
> >  arch/powerpc/mm/numa.c |   50 ++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 40 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index b835bf0..06af179 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -1369,38 +1369,68 @@ static int update_cpu_associativity_changes_mask(void)
> >  #define VPHN_ASSOC_BUFSIZE (6*sizeof(u64)/sizeof(u32) + 1)
> >  
> >  /*
> > + * The associativity values are either 16-bit (VPHN_FIELD_MSB) or 32-bit (data
> > + * or VPHN_FIELD_UNUSED). We hence need to parse the packed array into 16-bit
> > + * chunks. Let's do that with bit shifts to be endian neutral.
> > + *
> > + *    --- 16-bit chunks -->
> > + *  _________________________
> > + *  |  0  |  1  |  2  |  3  |   packed[0]
> > + *  -------------------------
> > + *  _________________________
> > + *  |  4  |  5  |  6  |  7  |   packed[1]
> > + *  -------------------------
> > + *            ...
> > + *  _________________________
> > + *  | 20  | 21  | 22  | 23  |   packed[5]
> > + *  -------------------------
> > + *
> > + *   >>48  >>32  >>16  >>0      <-- needed bit shift
> > + *
> > + * We only care for the 2 lower bits of the chunk index to compute the shift.
> > + */
> > +static inline u16 read_vphn_chunk(const long *packed, unsigned int i)
> > +{
> > +	return packed[i >> 2] >> ((~i & 3) << 4);
> 
> This is some excellent magic and the comment *should* be sufficient, but
> maybe an example would be good? i is the index we want to read from in
> the packed array?
> 

Yes, i is the index of the 16-bit chunk we want to read. I will add
numerical examples:

chunk #0 is (u16) packed[0] >> 48
chunk #1 is (u16) packed[0] >> 32
chunk #2 is (u16) packed[0] >> 16
chunk #3 is (u16) packed[0] >> 0
chunk #4 is (u16) packed[1] >> 48
chunk #5 is (u16) packed[1] >> 32
...
chunk #22 is (u16) packed[1] >> 16
chunk #23 is (u16) packed[1] >> 0


> > +}
> > +
> > +/*
> >   * Convert the associativity domain numbers returned from the hypervisor
> >   * to the sequence they would appear in the ibm,associativity property.
> >   */
> >  static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
> >  {
> > -	int i, nr_assoc_doms = 0;
> > +	unsigned int i, j, nr_assoc_doms = 0;
> >  	const __be16 *field = (const __be16 *) packed;
> >  
> >  #define VPHN_FIELD_UNUSED	(0xffff)
> >  #define VPHN_FIELD_MSB		(0x8000)
> >  #define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
> >  
> > -	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
> > -		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED) {
> > +	for (i = 1, j = 0; i < VPHN_ASSOC_BUFSIZE; i++) {
> > +		u16 field = read_vphn_chunk(packed, j);
> 
> Maybe I'm super dense here, but isn't there are already a variable named
> field in this context? With a different annotation?
> 

Oops ! The u16 one is supposed to supersede the __be16 * one :)

-       const __be16 *field = (const __be16 *) packed;

> > +
> > +		if (field == VPHN_FIELD_UNUSED) {
> >  			/* All significant fields processed, and remaining
> >  			 * fields contain the reserved value of all 1's.
> >  			 * Just store them.
> >  			 */
> > -			unpacked[i] = *((__be32 *)field);
> > -			field += 2;
> > +			unpacked[i] = (VPHN_FIELD_UNUSED << 16 |
> > +				       VPHN_FIELD_UNUSED);
> > +			j += 2;
> >  		} else if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
> 
> Why do we need to do be16_to_cpup(field) here if field is now a u16? Or
> more explicitly, if we don't performe be16_to_cpup(field) anywhere else
> in this function now, why do we need to here?

Same as above ^^

-               } else if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
+               } else if (field & VPHN_FIELD_MSB) {

Bad copy/paste from the prototype code... :\

Thanks for the review.

> 
> >  			/* Data is in the lower 15 bits of this field */
> > -			unpacked[i] = cpu_to_be32(
> > -				be16_to_cpup(field) & VPHN_FIELD_MASK);
> > -			field++;
> > +			unpacked[i] = cpu_to_be32(field & VPHN_FIELD_MASK);
> > +			j++;
> >  			nr_assoc_doms++;
> >  		} else {
> >  			/* Data is in the lower 15 bits of this field
> >  			 * concatenated with the next 16 bit field
> >  			 */
> > -			unpacked[i] = *((__be32 *)field);
> > -			field += 2;
> > +			unpacked[i] =
> > +				cpu_to_be32((u32) field << 16 |
> > +					    read_vphn_chunk(packed, j + 1));
> > +			j += 2;
> >  			nr_assoc_doms++;
> >  		}
> >  	}
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
