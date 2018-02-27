Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrCSv0jfXzF132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 20:05:02 +1100 (AEDT)
Received: by mail-pf0-x22a.google.com with SMTP id f80so2597867pfa.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 01:05:02 -0800 (PST)
Date: Tue, 27 Feb 2018 19:04:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 3/5] powerpc/mm/slice: implement
 slice_check_range_fits
Message-ID: <20180227190440.45ce8641@roar.ozlabs.ibm.com>
In-Reply-To: <87k1uy7vbr.fsf@linux.vnet.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
 <caa9d52e0a8ef15719bafe8002a4ad2dc359c634.1518382747.git.christophe.leroy@c-s.fr>
 <87k1uy7vbr.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 Feb 2018 12:50:08 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>  +	if ((start + len) > SLICE_LOW_TOP) {
> > +		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
> > +		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
> > +		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
> > +		unsigned long i;
> >  
> > -	slice_bitmap_and(result, mask->high_slices, available->high_slices,
> > -			 slice_count);
> > +		for (i = start_index; i < start_index + count; i++) {
> > +			if (!test_bit(i, available->high_slices))
> > +				return false;
> > +		}
> > +	}  
> 
> why not bitmap_equal here instead of test_bit in loop?

Because we only have the available bitmap now. If we see large ranges
here we could use some bitmap operation like find_next_zero_bit perhaps.

Thanks,
Nick
