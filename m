Return-Path: <paubert@iram.es>
Received: from torres.puc.rediris.es (torres.puc.rediris.es
 [IPv6:2001:720:418:ca00::9])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF2611A0A0C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 04:08:02 +1100 (AEDT)
Date: Wed, 3 Dec 2014 18:07:43 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/2]powerpc: foundation code to handle CR5 for local_t
Message-ID: <20141203170743.GA11062@visitor2.iram.es>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20141201213527.GA2278@visitor2.iram.es>
 <547F2559.9060404@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547F2559.9060404@linux.vnet.ibm.com>
Cc: rusty@rustcorp.com.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 03, 2014 at 08:29:37PM +0530, Madhavan Srinivasan wrote:
> On Tuesday 02 December 2014 03:05 AM, Gabriel Paubert wrote:
> > On Thu, Nov 27, 2014 at 05:48:40PM +0530, Madhavan Srinivasan wrote:
> >> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> >> index 77f52b2..c42919a 100644
> >> --- a/arch/powerpc/include/asm/exception-64s.h
> >> +++ b/arch/powerpc/include/asm/exception-64s.h
> >> @@ -306,7 +306,26 @@ do_kvm_##n:								\
> >>  	std	r10,0(r1);		/* make stack chain pointer	*/ \
> >>  	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
> >>  	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
> >> -	beq	4f;			/* if from kernel mode		*/ \
> >> +BEGIN_FTR_SECTION;							   \
> >> +	lis	r9,4096;		/* Create a mask with HV and PR */ \
> >> +	rldicr	r9,r9,32,31;		/* bits, AND with the MSR       */ \
> >> +	mr	r10,r9;			/* to check for Hyp state       */ \
> >> +	ori	r9,r9,16384;						   \
> >> +	and	r9,r12,r9;						   \
> >> +	cmpd	cr3,r10,r9;							   \
> >> +	beq	cr3,66f;		/* Jump if we come from Hyp mode*/ \
> >> +	mtcrf	0x04,r10;		/* Clear CR5 if coming from usr */ \
> > 
> > I think you can do better than this, powerpc has a fantastic set
> > of rotate and mask instructions. If I understand correctly your
> > code you can replace it with the following:
> > 
> > 	rldicl	r10,r12,4,63       /* Extract HV bit to LSB of r10*/
> > 	rlwinm  r9,r12,19,0x02     /* Extract PR bit to 2nd to last bit of r9 */
> > 	or	r9,r9,10
> > 	cmplwi  cr3,r9,1           /* Check for HV=1 and PR=0 */		
> > 	beq     cr3,66f
> > 	mtcrf   0x04,r10           /* Bits going to cr5 bits are 0 in r10 */
> > 
> 
> >From previous comment, at this point, CR0 already has MSR[PR], and only
> HV need to be checked. So I guess there still room for optimization.
> But good to learn this seq.

Actually the sequence I suggested can even be shortened again since the or
is not necessary and you can use an rlwimi instead.

	rldicl r9,r12,5,62      /*  r9 = 62 zeroes | HV | ?  */
	rlwimi r9,r12,18,0x01   /*  r9 = 62 zeroes | HV | PR */
	cmplwi cr3,r9,2         /* Check for HV=1 and PR=0 */

For 32 bit operands, rlwimi is a generic bit field to bit field move, but
GCC is (was, maybe GCC5 is better?) quite bad at recognizing opportunities
to use it.

I'm not sure that it is better to have two separate branches, one for
testing PR and the other for testing HV. Through how many branches can
the hardware speculate? 

Unless I'm mistaken, this is code which is likely not to be in the
cache so I would optimize it first towards minimal code size.

	Regards,
	Gabriel
