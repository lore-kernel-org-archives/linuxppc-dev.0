Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0212.hostedemail.com
 [216.40.44.212])
 by lists.ozlabs.org (Postfix) with ESMTP id 4A6321A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 09:00:34 +1000 (EST)
Message-ID: <1401318025.19335.15.camel@joe-AO725>
Subject: Re: [PATCH 11/16] byteorder: provide a linux/byteorder.h with {be,
 le}_to_cpu() and cpu_to_{be, le}() macros
From: Joe Perches <joe@perches.com>
To: Cody P Schafer <dev@codyps.com>
Date: Wed, 28 May 2014 16:00:25 -0700
In-Reply-To: <CAPoQQ-11vW3Q0=LcS-myNZ6hXeYBeu==_prwHJXHvLfkUSmZHQ@mail.gmail.com>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
 <1401236684-10579-12-git-send-email-dev@codyps.com>
 <063D6719AE5E284EB5DD2968C1650D6D1724EEAF@AcuExch.aculab.com>
 <CAPoQQ-17OHotfbczJvEoq=vAzu_+6-sV3M1ZAhDaQ45wB3NB4A@mail.gmail.com>
 <CAPoQQ-11vW3Q0=LcS-myNZ6hXeYBeu==_prwHJXHvLfkUSmZHQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 David Laight <David.Laight@aculab.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-05-28 at 17:11 -0500, Cody P Schafer wrote:
> On Wed, May 28, 2014 at 5:05 PM, Cody P Schafer <dev@codyps.com> wrote:
> > On Wed, May 28, 2014 at 3:45 AM, David Laight <David.Laight@aculab.com> wrote:
> >> From: Cody P Schafer
> >>> Rather manually specifying the size of the integer to be converted, key
> >>> off of the type size. Reduces duplicate size info and the occurance of
> >>> certain types of bugs (using the wrong sized conversion).
> >> ...
> >>> +#define be_to_cpu(v) \
> >>> +     __builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v, \
> >>> +     __builtin_choose_expr(sizeof(v) == sizeof(uint16_t), be16_to_cpu(v), \
> >>> +     __builtin_choose_expr(sizeof(v) == sizeof(uint32_t), be32_to_cpu(v), \
> >>> +     __builtin_choose_expr(sizeof(v) == sizeof(uint64_t), be64_to_cpu(v), \
> >>> +             (void)0))))
> >> ...
> >>
> >> I'm not at all sure that using the 'size' of the constant will reduce
> >> the number of bugs - it just introduces a whole new category of bugs.
> >
> > Certainly, if you mis-size the argument (and thus have missized one of
> > the variables containing the be value, probably a bug anyhow), there
> > will be problems.
> >
> > I put this interface together because of an actual bug I wrote into
> > the initial code of the hv_24x7 driver (resized a struct member
> > without adjusting the be*_to_cpu() sizing).
> > Having this "auto sizing" macro means I can avoid encoding the size of
> > a struct field in multiple places.
> 
> To clarify, the point I'm making here is that this simply cuts out 1
> more place we can screw up endianness conversion sizing.

It does screw up other types when you do things like:

	u8 foo = some_function();

	cpu_to_be(foo + 1);

the return value is sizeof(int) not u8
