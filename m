Message-Id: <v03110702b53c10dcc4d9@[208.177.152.17]>
In-Reply-To: <200005060514.AAA05188@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 8 May 2000 00:03:57 -0700
To: linuxppc-dev@lists.linuxppc.org
From: james  woodyatt <jhw@wetware.com>
Subject: Re: Help with cross-endian bitfields?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz <drow@false.org> wrote:
>On Fri, May 05, 2000 at 03:27:21PM -0400, jlquinn@us.ibm.com wrote:
>>
[...]
>> Can someone tell me what's going on here?  Am I going to have to have
>> ifdef's on these structs, or resort to mask macros, or is there a
>> reasonable solution here.
>
>As Dan Malek said, there is no defined ordering.  The compiler is free
>to do whatever it wishes.  You can't assume that.  (I think.)
[...]

It's absolutely true.

Not only is there no defined ordering, the ANSI standard says that it
doesn't even need to use bitfield operations in the machine code.  It's
allowed to pad arbitrarily between the bitfields.  It's allowed to
completely ignore the bitfield widths and treat the members like integers.
It's even allowed to order the very bits themselves in weird ways, if it
thinks the processor will like it better that way.

Bitfields are just not even remotely portable.

C structures should not be used to represent portable serializations of
external data.  Period.  Yes, they're convenient-- but your compiler and my
compiler don't have to agree on practically anything about them.


--
j h woodyatt <jhw@wetware.com>
http://www.wetware.com/jhw
"Yeah, Mercury's going into retrograde, but
at least we're not the Kennedys."  --sean poreda


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
