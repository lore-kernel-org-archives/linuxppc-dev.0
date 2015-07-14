Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3462A1A025F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 17:57:56 +1000 (AEST)
Date: Tue, 14 Jul 2015 17:57:35 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC v4 00/25] Re-use nvram module
In-Reply-To: <CAMuHMdX+5XHWf3sVqAnF_mioS1zZmxQXurEeMGMM3OKa9acxhA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1507141045020.24654@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <CAMuHMdX+5XHWf3sVqAnF_mioS1zZmxQXurEeMGMM3OKa9acxhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 13 Jul 2015, Geert Uytterhoeven wrote:

> 
> How are we gonna merge this?

I think the series would have to be merged almost whole. For the most 
part, no maintainer can merge any of this without ACKs from others:

- to improve code re-use by replacing an API shared by arch-specific code 
  and a variety of drivers means getting ACKs from everyone concerned (or 
  the old API can't be removed).

- to move arch-specific code out of a generic driver means getting ACKs 
  from both arch maintainer and driver maintainer. Some of this 
  arch-specific code is shared by m68k, x86 and arm (but not powerpc) and 
  this complicates things.

- to adopt a new Kconfig convention in a uniform and consistent way seems 
  to require simultaneous changes in various drivers and architectures.

> Have you looked into the dependencies?

What I saw was not pretty.

> Are there (large) parts we can merge in parallel?

Not AFAICT. Two patches could be cherry picked, that might make sense to 
merge by themselves. Those are patches 2 and 12. Either or both could be 
reviewed and merged by the char device maintainers.

There are a couple of other small patches that could probably be cherry 
picked without breaking anything but these changes are not justified 
except by subsequent patches.

> 
> Thanks again!

No worries.

-- 

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
