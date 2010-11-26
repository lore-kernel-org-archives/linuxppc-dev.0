Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 9E9B4B70CD
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Nov 2010 18:15:55 +1100 (EST)
Received: by iwn4 with SMTP id 4so601084iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2010 23:15:54 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1290750606.9453.394.camel@concordia>
References: <1290607413.12457.44.camel@concordia>
	<1290692075.689.20.camel@concordia>
	<AANLkTiknyKi1pzvUP2WnasudZwH27-a0FxCX0BSHBdQp@mail.gmail.com>
	<1290741341.9453.377.camel@concordia> <4CEF3AB1.9060200@firmworks.com>
	<1290750606.9453.394.camel@concordia>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Nov 2010 00:15:34 -0700
Message-ID: <AANLkTi=XmuWMzmtCNtswkUBgDt3k1FWAcUVhv7WJjA4j@mail.gmail.com>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
To: michael@ellerman.id.au
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch <linux-arch@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 25, 2010 at 10:50 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Thu, 2010-11-25 at 18:42 -1000, Mitch Bradley wrote:
>> On 11/25/2010 5:15 PM, Michael Ellerman wrote:
>> > On Thu, 2010-11-25 at 09:17 -0700, Grant Likely wrote:
>> >> On Thu, Nov 25, 2010 at 6:34 AM, Michael Ellerman
>> >> <michael@ellerman.id.au> =A0wrote:
>> >>> On Thu, 2010-11-25 at 01:03 +1100, Michael Ellerman wrote:
>> >>>> Hi all,
>> >>>>
>> >>>> There were some murmurings on IRC last week about renaming the of_*=
()
>> >>>> routines.
>> >>> ...
>> >>>> The thinking is that on many platforms that use the of_() routines
>> >>>> OpenFirmware is not involved at all, this is true even on many powe=
rpc
>> >>>> platforms. Also for folks who don't know the OpenFirmware connectio=
n
>> >>>> it reads as "of", as in "a can of worms".
>> >>> ...
>> >>>> So I'm hoping people with either say "YES this is a great idea", or=
 "NO
>> >>>> this is stupid".
>> >>>
>> >>> I'm still hoping, but so far it seems most people have got better th=
ings
>> >>> to do, and of those that do have an opinion the balance is slightly
>> >>> positive.
>> >>
>> >> I assume you'll be also publishing the script that you use for
>> >> generating the massive patch. =A0I expect that there will be a few
>> >> iterations of running the rename script to convert over all the
>> >> stragglers.
>> >
>> > Yep sure, I'll just make it less crap first.
>> >
>> >> It should also be negotiated with Linus about when this
>> >> patch should get applied. =A0I do NOT want to cause massive merge pai=
n
>> >> during the merge window.
>> >
>> > Obviously.
>> >
>> >> Andrew/Linus: Before Michael proceeds too far with this rename, are
>> >> you okay with a mass rename of the device tree functions from of_* to
>> >> dt_*? =A0Nobody likes the ambiguous 'of_' prefix ("of? =A0of what?"),=
 but
>> >> to fix it means large cross-tree patches and potential merge
>> >> conflicts.
>> >
>> > It'd also be good to hear from DaveM, sparc is the platform with the
>> > strongest link to real OF AFAIK, so the of_() names make more sense
>> > there.
>>
>>
>> One Laptop Per Child ships real Open Firmware on its x86 Linux systems,
>> of which approximately 2 million have been shipped or ordered. =A0An ARM
>> version, also with OFW, is in the works.
>
> OK. I don't see any code under arch/x86 or arch/arm that uses of_()
> routines though? Or is it under drivers or something?
>
>> That said, I don't particularly like the abbreviation "of" either; I
>> abbreviate Open Firmware as "OFW".
>>
>> I don't mind using "dt_" to apply to device tree things; I think it's
>> clearer than "of_". =A0 Ideally, it would be nice to acknowledge the
>> historical connection in some way, but confusing nomenclature probably
>> is not the way to go about it.

Yes, I like the ofw_ prefix too, and briefly considered renaming to
that, but decide that dt_ was better due to the number of systems
using the device tree without real openfirmware.

However, the ofw_ prefix would make sense if any of the promtree code
is renamed.

> Cool. I think there will still be a few things that have OF in the name,
> at least for a while, and I'm sure the doco will still mention OF, so I
> don't think the connection will be lost.

Considering that pretty much all the documentation makes some
reference back to the openfirmware origins, I'm pretty sure the ofw
legacy is safe.  :-)

g.
