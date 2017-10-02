Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5YC61MxnzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 07:08:49 +1100 (AEDT)
Date: Mon, 2 Oct 2017 15:08:05 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Kees Cook <keescook@chromium.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 David Laight <David.Laight@aculab.com>, Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, Jinbum Park <jinb.park7@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] mm: fix RODATA_TEST failure "rodata_test: test data was
 not read only"
Message-ID: <20171002200805.GF8421@gate.crashing.org>
References: <20170921093729.1080368AC1@po15668-vm-win7.idsi0.si.c-s.fr>
 <CAGXu5jJ54+bCcXaPK1ExsxtTDPHNn1+1gywb3TDbe-SEtt1zuQ@mail.gmail.com>
 <20170925073721.GM8421@gate.crashing.org>
 <063D6719AE5E284EB5DD2968C1650D6DD007F58B@AcuExch.aculab.com>
 <20170925194130.GV8421@gate.crashing.org>
 <CAGXu5j+bj1NHmrrEmcwPavKubavLh1b01AyyJEFRvycg9FkLpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXu5j+bj1NHmrrEmcwPavKubavLh1b01AyyJEFRvycg9FkLpg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 02, 2017 at 12:29:45PM -0700, Kees Cook wrote:
> On Mon, Sep 25, 2017 at 12:41 PM, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Mon, Sep 25, 2017 at 04:01:55PM +0000, David Laight wrote:
> >> From: Segher Boessenkool
> >> > The compiler puts this item in .sdata, for 32-bit.  There is no .srodata,
> >> > so if it wants to use a small data section, it must use .sdata .
> >> >
> >> > Non-external, non-referenced symbols are not put in .sdata, that is the
> >> > difference you see with the "static".
> >> >
> >> > I don't think there is a bug here.  If you think there is, please open
> >> > a GCC bug.
> >>
> >> The .sxxx sections are for 'small' data that can be accessed (typically)
> >> using small offsets from a global register.
> >> This means that all sections must be adjacent in the image.
> >> So you can't really have readonly small data.
> >>
> >> My guess is that the linker script is putting .srodata in with .sdata.
> >
> > .srodata does not *exist* (in the ABI).
> 
> So, I still think this is a bug. The variable is marked const: this is
> not a _suggestion_. :) If the compiler produces output where the
> variable is writable, that's a bug.

C11 6.7.3/6: "If an attempt is made to modify an object defined with a
const-qualified type through use of an lvalue with non-const-qualified
type, the behavior is undefined."

And that is all that "const" means.

The compiler is free to put this var in *no* data section, or to copy
it to the stack before using it, or anything else it thinks is a good
idea.

If you think it would be a good idea for the compiler to change its
behaviour here, please file a PR (or send a patch).  Please bring
arguments why we would want to change this.

> I can't tell if this bug is related:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=9571

I don't think so: the only remaining bug there is that a copy of the
constant is put in .rodata.cst8 (although there is a copy in .sdata2
already).

Thanks,


Segher
