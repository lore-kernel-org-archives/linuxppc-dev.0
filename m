Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F0C8112.5060001@earthlink.net>
Date: Wed, 09 Jul 2003 13:54:42 -0700
From: Dean Matsen <deanmatsen@earthlink.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with  971/972
 chips
References: <3F0B7B28.7040902@earthlink.net> <5.1.0.14.2.20030708195315.038110e8@mail.ebshome.net> <3F0BA671.1050900@embeddededge.com> <3F0BAD39.9060708@earthlink.net> <3F0C2898.90508@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Dan Malek wrote:

>
> Dean Matsen wrote:
>
>> Yes, I see we have no pullup on that line. We do dedicated HVAC
>> applications, so we
>> don't need to do this search.
>
>
> But.......the hardware is broken.  The MDIO is supposed to be
> an open-drain with a pullup.  I guess you may be lucky the
> ends of the connection are driving the line proplerly, but it
> could be luck that will run out someday.
>
>
>     -- Dan

Actually, it turns out that this is not quite true.  The MDIO line
is classified as an I/O line (on the same page where other lines
are classified as open drain).  There are tons of application notes from
Motorola and Intel and none of them show a pullup.  I think
this issue has more to do with talking to a device at the wrong address
and  having the line float only in that case.

The actual problem I have is that the kernel panics before it even gets
to address 1 (which is where my PHY chip is in the first place).  This
happens whenever it reads a value other than FFFF from the first word
of the ID.  I see now that my first patch adds detection for the value
0000, but other people may have varying results (especially if they
follow the app notes and don't have a pullup, like we do).

I think the search should be made smarter (especially, keep going to
the next address until it has gone through ALL address w/o finding a
valid ID).  The kernel could still panic if it can't find any PHY chip,
but not the first time it reads the floating line and can't find the
answer in its table.  The odds of reading a valid PHY ID from the
floating line is phenominally low.  I'd submit a proposed patch for
this, but it doesn't sound like anyone else thinks this is important
enough to warrant a change.

Those maintaining the official kernel repositories should consider whether
or not it's friendly to require the addition of a pullup resistor just so
the automatic PHY search will work.  Unless the pullup is required for
non-search applications (which I assert it isn't), then I think the code
should be fixed, not the hardware.

Regards,

Dean


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
