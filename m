Date: Fri, 09 Nov 2001 15:35:12 -0500
From: ultrapenguin@netscape.net (jeramy b smith)
To: hobold@informatik.uni-bremen.de (Holger Bettag)
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] aty128fb.c
Message-ID: <0B82E46E.672580C0.A41E0FAA@netscape.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Holger Bettag <hobold@Informatik.Uni-Bremen.DE> wrote:

>"Jeramy B. Smith" <jeramy@penguinppc.org> writes:
>
>>
>> http://penguinppc.org/projects/jeramy/aty128fb.c.diff
>>
>> This removes a block of cruft leftover from the iMac days and sets the
>> default resolution for aty128fb on PPCs to 640x480-60 (ensuring even the
>> cruddiest of monitors will work).
>>
>Cinema Displays can only sync to their native mode. (Not that many of them
>were out there, but...)
>
>  Holger
>

We look for monitor sense values for the cinema display. That's elsewhere in the driver. The way aty128fb sets the default res is like this with my patch:

it looks at machine specific vmodes (powerbook, imac)
it looks at monitor sense info
it looks at user specified vmode args and checks to make sure they are sane
if all of that fails, it uses the aforementioned default
Even if we don't want 640x480 as the default, we dont have to set it with that first hunk I removed, there is another place later in the driver to set the default. I removed the big hunk just as a way to say 'lets be clear about where we set the default res'.

--
-jeramy b smith


"Linux is Fun!" -Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
