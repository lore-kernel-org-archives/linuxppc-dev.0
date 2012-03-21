Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 62CCDB6F98
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2012 03:25:56 +1100 (EST)
To: Josh Boyer <jwboyer@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
Date: Wed, 21 Mar 2012 17:25:49 +0100
Message-Id: <20120321162549.8C1D0202A4D@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, robert.karl.berger@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Josh,

In message <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com> you wrote:
>
> > The problem is that for ppc-linux-gcc (GCC) 4.2.2 (which comes with the
> > ELDK 4.2) this assembly instruction is not known and the build breaks.
> 
> Sigh.  GCC 4.2 is pretty old at this point.

But still rock-solid ...  We use it a lot, especially as reference for
more recent (and sometimes more broken) versions of GCC.

> All of the stuff in arch/powerpc/boot/ is built regardless of the
> configured board and stuffed into a wrapper.a archive.  Then the
> individual board targets are built and the necessary pieces are pulled
> from the wrapper.a file.

This appears to be a pretty inefficient approach.  Why don't we build
only the files we actually need?  That would save a bit of build time.

> > Please advise.
> 
> If upgrading ELDK is an option for you, it will get you the quickest
> solution.  Otherwise we'll need to figure out how to stub out the
> instruction in boot/dcr.h and use the asm long trick.  Ew.  I can look
> at that next week.

Thanks a lot in advance!

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is wrong always, everywhere and for everyone to  believe  anything
upon  insufficient  evidence.  - W. K. Clifford, British philosopher,
circa 1876
