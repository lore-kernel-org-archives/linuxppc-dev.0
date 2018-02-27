Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x230.google.com (mail-pg0-x230.google.com
 [IPv6:2607:f8b0:400e:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrCXv3lGNzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 20:08:30 +1100 (AEDT)
Received: by mail-pg0-x230.google.com with SMTP id l4so7283675pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 01:08:30 -0800 (PST)
Date: Tue, 27 Feb 2018 19:08:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 4/5] powerpc/mm/slice: Use const pointers to
 cached slice masks where possible
Message-ID: <20180227190818.3f3673e4@roar.ozlabs.ibm.com>
In-Reply-To: <87h8q27uvi.fsf@linux.vnet.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
 <6a8c9183257dfcfeb1d8ed1ecc778ec3da19dcd4.1518382747.git.christophe.leroy@c-s.fr>
 <87h8q27uvi.fsf@linux.vnet.ibm.com>
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

On Tue, 27 Feb 2018 12:59:53 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
> > The slice_mask cache was a basic conversion which copied the slice
> > mask into caller's structures, because that's how the original code
> > worked. In most cases the pointer can be used directly instead, saving
> > a copy and an on-stack structure.
> >
> > This also converts the slice_mask bit operation helpers to be the usual
> > 3-operand kind, which is clearer to work with. And we remove some
> > unnecessary intermediate bitmaps, reducing stack and copy overhead
> > further.  
> 
> Can we move the reduce unncessary intermediate bitmaps as another patch?

This was rightly split out -- it moved to Christophe's patch he already
made in his series. The changelog can just be adjusted.

Thanks,
Nick
