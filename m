Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxQ81Zk3zDrK7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 23:57:35 +1000 (AEST)
Received: by mail-pa0-x234.google.com with SMTP id iw10so10720175pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 06:57:35 -0700 (PDT)
Date: Wed, 27 Jul 2016 23:57:28 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH] Make system_reset_pSeries relocatable
Message-ID: <20160727135728.GC3720@350D>
Reply-To: bsingharora@gmail.com
References: <48aad8b6-a27f-44c5-2b0b-f276595e9c04@gmail.com>
 <20160727215003.16b9feaf@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160727215003.16b9feaf@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2016 at 09:50:03PM +1000, Nicholas Piggin wrote:
> On Wed, 27 Jul 2016 17:32:06 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
> 
> > +#ifndef CONFIG_RELOCATABLE
> > +	b	power7_wakeup_common
> > +#else
> > +	/*
> > +	 * We can't just use a direct branch to power7_wakeup_common
> > +	 * because the distance from here to there depends on where
> > +	 * the kernel ends up being put.
> > +	 */
> > +	mfctr	r11
> > +	ld	r10, PACAKBASE(r13)
> > +	LOAD_HANDLER(r10, power7_wakeup_common)
> > +	mtctr	r10
> > +	bctr
> >  #endif
> 
> So r10 and r11 are safe to use (as well as existing registers
> being used without saving) because we are returning via the nap
> functions that caller will expect te trash volatile registers,
> yes?
>

r10, r11 are volatile as per the ABI, so yes.

 
> In that caie I can't see a problem with this.
>

Thanks for the review

Balbir 
