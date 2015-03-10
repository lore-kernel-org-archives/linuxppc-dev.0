Return-Path: <olof@lixom.net>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 060FF1A0371
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 11:33:48 +1100 (AEDT)
Received: by obcwo20 with SMTP id wo20so2323692obc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2015 17:33:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1425947283.19022.8.camel@ellerman.id.au>
References: <20150305171239.3a8135e6@gandalf.local.home>
 <1425615522.4636.173.camel@kernel.crashing.org>
 <20150306100021.5637d790@gandalf.local.home>
 <1425682582.4636.197.camel@kernel.crashing.org>
 <CAOesGMjBjmVQtdA85Uc2QrVT6enVShOx-iyXdZLvH9vuq8t=wQ@mail.gmail.com>
 <1425700921.4636.213.camel@kernel.crashing.org>
 <1425947283.19022.8.camel@ellerman.id.au>
Date: Mon, 9 Mar 2015 17:33:46 -0700
Message-ID: <CAOesGMhTr2ing8wLREJ0NqVkqD_eAb4L5=YgN37-MeJ3AX-NGA@mail.gmail.com>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 9, 2015 at 5:28 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Sat, 2015-03-07 at 15:02 +1100, Benjamin Herrenschmidt wrote:
>> On Fri, 2015-03-06 at 15:50 -0800, Olof Johansson wrote:
>> > On Fri, Mar 6, 2015 at 2:56 PM, Benjamin Herrenschmidt
>> > <benh@kernel.crashing.org> wrote:
>> > > On Fri, 2015-03-06 at 10:00 -0500, Steven Rostedt wrote:
>> > >> On Fri, 06 Mar 2015 15:18:42 +1100
>> > >> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> > >>
>> > >>
>> > >> > Can you shoot me the DT (/proc/device-tree in a tarball) ?
>> > >>
>> > >> Attached.
>> > >
>> > > This is indeed a bug in their DT. We might want to add quirks for
>> > > that unless it can be fixed (or has been via FW update). Olof ?
>> >
>> > FW updates on this platform are highly unlikely. Quirk it is.
>>
>> Oh I was not expecting a new FW, I was mostly wondering whether Steven
>> had the latest one since I *think* Michael has been testing with the
>> PA board we got here and didn't see that problem ... anyway, I'll check
>> with him early next week and clean up / submit that patch.
>
> Yeah I have been testing semi-regularly.
>
> 4.0-rc2 boots fine on mine.
>
> But mine is an Athena, Steve's is an Electra. So they're not identical.

I have a chitra in my boot farm, so I run every build I do on it. I
have not hit it either, which confused me.

Turns out that Steven's machine boots with idle=doze, which is the
part that makes all the difference.


FWIW, the three machines have roughly these diffs:

* Electra: First development/eval board. Funky USB on localbus, plenty
of PCI-e. Two GigE, one 10GigE XAUI. CompactFlash and IDE on localbus
too. Usually shipped with a PCI-e SATA card and a USB card.

* Chitra: Second edition dev/eval board. Moved SATA and USB on-board,
and removed some of the localbus hardware. Might have routed three
GigE out instead of 2, can't remember.

* Athena: Never released board with a smaller package chip, there's
only a few of these around. Can't comment too much on the specifics,
but it's similar to Chitra, and the silicon is the same.

> Mine is running:
>
>   CFE version PAS-2.0.29 for ATHENA (64bit,MP,BE,PPC)
>   Build Date: Mon Jun 30 11:47:25 PDT 2008 (mpl@mitch-1)
>
> Steve is your CFE older than that?
>
> Olof do you remember if that version or something newer is available for
> Electra?

That looks about as new as they come. My board runs a .29 too.


-Olof
