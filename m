Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9AA2FB6F6E
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Apr 2012 08:14:09 +1000 (EST)
Received: by bkcje9 with SMTP id je9so1722789bkc.15
 for <linuxppc-dev@ozlabs.org>; Sun, 01 Apr 2012 15:14:05 -0700 (PDT)
Date: Mon, 2 Apr 2012 00:14:00 +0200
From: Frank =?iso-8859-1?Q?E=2E_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
Message-ID: <20120401221359.GA31730@gnubox>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
 <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
 <1333152184.30734.3.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1333152184.30734.3.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
 robert.karl.berger@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 31, 2012 at 11:03:04AM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2012-03-31 at 00:53 +0200, Frank Svendsbøe wrote:
> 
> > Hi Josh Boyer,
> > 
> > just wanted to add that I'm experiencing the same problem that Robert
> > reported, but on 8xx instead of 4xx. The mpc8xx does not support the
> > mfdcrx instruction, so maybe it's more to it than just a binutils bug?
> 
> The kernel shouldn't have tried to build that instruction on 8xx, though
> I suppose if it's in arch/powerpc/boot, we are a bit too eager at
> building everything including what's not relevant, we might to be a bit
> more careful at excluding 4xx stuff on a 8xx kernel.
>

Yes. I agree on Wolfgangs statement regarding not building code we
don't want/need. Please explain to me why src-wlib/src-plat in
arch/powerpc/boot/Makefile includes every ppc target...

> Can you give us the exact error ?
>

Yes. The problem is caused by commit 228d550 by Tony Breeds

arch/powerpc/boot/treeboot-currituck.c:50
reg = mfdcrx(DDR3_MR0CF + i);

-- 
Best regards,
Frank
