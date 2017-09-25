Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1DxR0BFnzDsN9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 05:42:01 +1000 (AEST)
Date: Mon, 25 Sep 2017 14:41:31 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Kees Cook <keescook@chromium.org>, Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, Jinbum Park <jinb.park7@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] mm: fix RODATA_TEST failure "rodata_test: test data was
 not read only"
Message-ID: <20170925194130.GV8421@gate.crashing.org>
References: <20170921093729.1080368AC1@po15668-vm-win7.idsi0.si.c-s.fr>
 <CAGXu5jJ54+bCcXaPK1ExsxtTDPHNn1+1gywb3TDbe-SEtt1zuQ@mail.gmail.com>
 <20170925073721.GM8421@gate.crashing.org>
 <063D6719AE5E284EB5DD2968C1650D6DD007F58B@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD007F58B@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 25, 2017 at 04:01:55PM +0000, David Laight wrote:
> From: Segher Boessenkool
> > The compiler puts this item in .sdata, for 32-bit.  There is no .srodata,
> > so if it wants to use a small data section, it must use .sdata .
> > 
> > Non-external, non-referenced symbols are not put in .sdata, that is the
> > difference you see with the "static".
> > 
> > I don't think there is a bug here.  If you think there is, please open
> > a GCC bug.
> 
> The .sxxx sections are for 'small' data that can be accessed (typically)
> using small offsets from a global register.
> This means that all sections must be adjacent in the image.
> So you can't really have readonly small data.
> 
> My guess is that the linker script is putting .srodata in with .sdata.

.srodata does not *exist* (in the ABI).


Segher
