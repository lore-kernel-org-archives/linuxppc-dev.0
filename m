Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y0wsc58jFzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 17:37:40 +1000 (AEST)
Date: Mon, 25 Sep 2017 02:37:21 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>, Jinbum Park <jinb.park7@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: fix RODATA_TEST failure "rodata_test: test data was
 not read only"
Message-ID: <20170925073721.GM8421@gate.crashing.org>
References: <20170921093729.1080368AC1@po15668-vm-win7.idsi0.si.c-s.fr>
 <CAGXu5jJ54+bCcXaPK1ExsxtTDPHNn1+1gywb3TDbe-SEtt1zuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXu5jJ54+bCcXaPK1ExsxtTDPHNn1+1gywb3TDbe-SEtt1zuQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 24, 2017 at 12:17:51PM -0700, Kees Cook wrote:
> On Thu, Sep 21, 2017 at 2:37 AM, Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
> > On powerpc, RODATA_TEST fails with message the following messages:
> >
> > [    6.199505] Freeing unused kernel memory: 528K
> > [    6.203935] rodata_test: test data was not read only
> >
> > This is because GCC allocates it to .data section:
> >
> > c0695034 g     O .data  00000004 rodata_test_data
> 
> Uuuh... that seems like a compiler bug. It's marked "const" -- it
> should never end up in .data. I would argue that this has done exactly
> what it was supposed to do, and shows that something has gone wrong.
> It should always be const. Adding "static" should just change
> visibility. (I'm not opposed to the static change, but it seems to
> paper over a problem with the compiler...)

The compiler puts this item in .sdata, for 32-bit.  There is no .srodata,
so if it wants to use a small data section, it must use .sdata .

Non-external, non-referenced symbols are not put in .sdata, that is the
difference you see with the "static".

I don't think there is a bug here.  If you think there is, please open
a GCC bug.


Segher
