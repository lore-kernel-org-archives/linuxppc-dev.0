Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfC142mrkzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 15:08:56 +1000 (AEST)
Received: by mail-pf0-x231.google.com with SMTP id m17so46454842pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 22:08:56 -0700 (PDT)
Date: Fri, 2 Jun 2017 15:08:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: machine check handle ifetch from foreign
 real address for POWER9
Message-ID: <20170602150843.78db5b20@roar.ozlabs.ibm.com>
In-Reply-To: <8760gf2i8v.fsf@concordia.ellerman.id.au>
References: <20170529062644.21634-1-npiggin@gmail.com>
 <8760gf2i8v.fsf@concordia.ellerman.id.au>
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

On Fri, 02 Jun 2017 13:14:40 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > The i-side 0111b case was missed by 7b9f71f974 ("powerpc/64s: POWER9
> > machine check handler").
> >
> > It is possible to trigger this exception by branching to a foreign real
> > address (bits [8:12] != 0) with instruction relocation off, and verify
> > the exception cause is found after this patch.  
> 
> Can you define "foreign" for people who aren't reading the chip docs :)

Yes I guess we can copy&paste the relevant part. Updated changelog:

The i-side 0111b machine check, which is "Instruction Fetch to foreign
address space", was missed by 7b9f71f974 ("powerpc/64s: POWER9 machine
check handler").

    The POWER9 processor core considers host real addresses with a
    nonzero value in RA(8:12) as foreign address space, accessible only
    by the copy and paste instructions. The copy and paste instruction
    pair can be used to invoke the Nest accelerators via the Virtual
    Accelerator Switchboard (VAS).

It is an error for any regular load/store or ifetch to go to a foreign
addresses. When relocation is on, this causes an MMU exception. When
relocation is off, a machine check exception. It is possible to trigger
this machine check by branching to a foreign address with MSR[IR]=0.

Any better?

Thanks,
Nick
