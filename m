Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta7.messagelabs.com (mail1.bemta7.messagelabs.com
 [216.82.254.100])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CDFFA2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 06:42:30 +1100 (EST)
In-Reply-To: <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
 <20140207101036.GA823@visitor2.iram.es>
 <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
To: James Yang <James.Yang@freescale.com>
MIME-Version: 1.0
Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OF80E982EC.BE15A034-ONCA257C7A.006B58B5-CA257C7A.006C3EA8@csc.com>
Date: Mon, 10 Feb 2014 05:42:19 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org,
 Stephen N Chivers <schivers@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

James Yang <James.Yang@freescale.com> wrote on 02/08/2014 07:49:40 AM:

> From: James Yang <James.Yang@freescale.com>
> To: Gabriel Paubert <paubert@iram.es>
> Cc: Stephen N Chivers <schivers@csc.com.au>, Chris Proctor 
> <cproctor@csc.com.au>, <linuxppc-dev@lists.ozlabs.org>
> Date: 02/08/2014 07:49 AM
> Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
> 
> On Fri, 7 Feb 2014, Gabriel Paubert wrote:
> 
> >    Hi Stephen,
> > 
> > On Fri, Feb 07, 2014 at 11:27:57AM +1000, Stephen N Chivers wrote:
> > > Gabriel Paubert <paubert@iram.es> wrote on 02/06/2014 07:26:37 PM:
> > > 
> > > > From: Gabriel Paubert <paubert@iram.es>
> > > > To: Stephen N Chivers <schivers@csc.com.au>
> > > > Cc: linuxppc-dev@lists.ozlabs.org, Chris Proctor 
<cproctor@csc.com.au>
> > > > Date: 02/06/2014 07:26 PM
> > > > Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
> > > > 
> > > > On Thu, Feb 06, 2014 at 12:09:00PM +1000, Stephen N Chivers wrote:
> 
> > > > > 
> > > > >                 mask = 0;
> > > > >                 if (FM & (1 << 0))
> > > > >                         mask |= 0x0000000f;
> > > > >                 if (FM & (1 << 1))
> > > > >                         mask |= 0x000000f0;
> > > > >                 if (FM & (1 << 2))
> > > > >                         mask |= 0x00000f00;
> > > > >                 if (FM & (1 << 3))
> > > > >                         mask |= 0x0000f000;
> > > > >                 if (FM & (1 << 4))
> > > > >                         mask |= 0x000f0000;
> > > > >                 if (FM & (1 << 5))
> > > > >                         mask |= 0x00f00000;
> > > > >                 if (FM & (1 << 6))
> > > > >                         mask |= 0x0f000000;
> > > > >                 if (FM & (1 << 7))
> > > > >                         mask |= 0x90000000;
> > > > > 
> > > > > With the above mask computation I get consistent results for 
> > > > > both the MPC8548 and MPC7410 boards.
> > > > > 
> > > > > Am I missing something subtle?
> > > > 
> > > > No I think you are correct. This said, this code may probably be 
> > > optimized 
> > > > to eliminate a lot of the conditional branches. I think that:
> 
> 
> If the compiler is enabled to generate isel instructions, it would not 
> use a conditional branch for this code. (ignore the andi's values, 
> this is an old compile)
> 
>From limited research, the 440GP is a processor
that doesn't implement the isel instruction and it does
not implement floating point.

The kernel emulates isel and so using that instruction
for the 440GP would have a double trap penalty.

Correct me if I am wrong, the isel instruction first appears
in PowerPC ISA v2.04 around mid 2007. 

Stephen Chivers,
CSC Australia Pty. Ltd. 
