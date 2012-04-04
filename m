Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 04A9EB702F
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2012 05:21:14 +1000 (EST)
To: Josh Boyer <jwboyer@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <CA+5PVA6jQgme0sS=i8yYX6b_R5179+BtWPh7QXCGNfoLTCt46A@mail.gmail.com>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
 <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
 <1333152184.30734.3.camel@pasglop>
 <CA+5PVA6jQgme0sS=i8yYX6b_R5179+BtWPh7QXCGNfoLTCt46A@mail.gmail.com>
Date: Wed, 04 Apr 2012 21:21:01 +0200
Message-Id: <20120404192101.2A558200243@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, robert.karl.berger@gmail.com,
 =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Josh,

In message <CA+5PVA6jQgme0sS=i8yYX6b_R5179+BtWPh7QXCGNfoLTCt46A@mail.gmail.com> you wrote:
>
> > The kernel shouldn't have tried to build that instruction on 8xx, though
> > I suppose if it's in arch/powerpc/boot, we are a bit too eager at
> > building everything including what's not relevant, we might to be a bit
> > more careful at excluding 4xx stuff on a 8xx kernel.
> 
> It's still a binutils issue.  Sounds like the toolchain being used to
> build the 8xx kernel is specifically built for 8xx.  A generally built
> binutils should have worked fine (assuming it was new enough), since
> we pass -mcpu=405.

The problem is the "assuming it was new enough" part.

The kernel README says nothing about binutils requirements, the only
tool related statement is "Make sure you have at least gcc 3.2
available."  Actually I doubt if gcc 3.2 wouldbuild a working kernel
image.

ELDK 4.2 is based on gcc version 4.2.2 / binutils version 2.17.50.0.12
20070128.  This is obviously to old for this code.  I do not see an
actual problem with that - nobody can expect that we support old tol
chain versions forever.

But then, I think if we make assumptions about tool versions, we
should add appropriate tests and issue helpful error messages. Here,
we should issue an error "binutils versions x.y.z or later needed" or
similar.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I have made mistakes, but have never made the mistake of  claiming  I
never made one.                                     - James G. Bennet
