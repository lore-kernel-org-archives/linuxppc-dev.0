Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C194D2C049E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 20:23:01 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Jul 2012 15:52:58 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6NAMuk522282324
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 15:52:57 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6NAMu4n020635
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 20:22:56 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 09/11] arch/powerpc: Use 50 bits of VSID in slbmte
In-Reply-To: <20120723093611.GA29264@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120723000658.GH17790@bloggs.ozlabs.ibm.com>
 <87394ij3aa.fsf@skywalker.in.ibm.com>
 <20120723093611.GA29264@bloggs.ozlabs.ibm.com>
Date: Mon, 23 Jul 2012 15:52:55 +0530
Message-ID: <87r4s2hj40.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 23, 2012 at 01:51:49PM +0530, Aneesh Kumar K.V wrote:
>> Paul Mackerras <paulus@samba.org> writes:
>> 
>> > On Mon, Jul 09, 2012 at 06:43:39PM +0530, Aneesh Kumar K.V wrote:
>> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> >> 
>> >> Increase the number of valid VSID bits in slbmte instruction.
>> >> We will use the new bits when we increase valid VSID bits.
>> >> 
>> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> >> ---
>> >>  arch/powerpc/mm/slb_low.S |    4 ++--
>> >>  1 file changed, 2 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
>> >> index c355af6..c1fc81c 100644
>> >> --- a/arch/powerpc/mm/slb_low.S
>> >> +++ b/arch/powerpc/mm/slb_low.S
>> >> @@ -226,7 +226,7 @@ _GLOBAL(slb_allocate_user)
>> >>   */
>> >>  slb_finish_load:
>> >>  	ASM_VSID_SCRAMBLE(r10,r9,256M)
>> >> -	rldimi	r11,r10,SLB_VSID_SHIFT,16	/* combine VSID and flags */
>> >> +	rldimi	r11,r10,SLB_VSID_SHIFT,2	/* combine VSID and flags */
>> >
>> > You can't do that without either changing ASM_VSID_SCRAMBLE or masking
>> > the VSID it generates to 36 bits, since the logic in ASM_VSID_SCRAMBLE
>> > can leave non-zero bits in the high 28 bits of the result.  Similarly
>> > for the 1T case.
>> >
>> 
>> How about change ASM_VSID_SCRAMBLE to clear the high bits ? That would
>> also make it close to vsid_scramble()
>
> One more instruction in a hot path - I'd rather not.  How about
> changing the rldimi instruction to:
> 	rldimi	r11,r10,SLB_VSID_SHIFT,(64-SLB_VSID_SHIFT-VSID_BITS_256M)
>
> and similarly for the 1T case.  That will give the proper masking
> when you change VSID_BITS_256M.
>

This is better. I have made this change.

-aneesh
