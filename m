Date: Sat, 25 Jan 2003 19:04:27 +0100
From: Till Straumann <till.straumann@tu-berlin.de>
Subject: Re: [patch] ignore trackpad/mouse while typing
In-reply-to: <1043529955.3683.41.camel@zion.wanadoo.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
	linuxppc-dev@lists.linuxppc.org, George Staikos <staikos@kde.org>
Message-id: <71575D98-308F-11D7-9BDB-0003934F7CE4@tu-berlin.de>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.

Thanks for your feedback. Please let me work on this a little more.
The first version of the patch has 2 flaws:

   - emulated mouse buttons are treated as normal key events and
     are hence suppressed (that's already fixed but introduces a very
     ugly dependency on the mac-hid driver).
  - the same applies to modifier keys. Unfortunately, we need a list
    of these keys (and there is obviously no way to know what keys
    are 'modifiers' for a specific application program (such as X)).

Unfortunately, I still see the kernel as the proper place to handle this
(feature shared by all applications; 'semi-real time' nature of the
feature.
'input' is the place where mouse and key events come together.)

Then, there is one more problem: I had a disk-crash and I have to wait
for my new disk before I can continue working (or even look at the code).

:-(

Regards
-- Till

PS: I added a few comments to the discussion below

On Saturday, January 25, 2003, at 10:25 , Benjamin Herrenschmidt wrote:

> On Sat, 2003-01-25 at 22:04, Vojtech Pavlik wrote:
>
>>>> Well... the problem happpens in console as well, and with other
>>>> non-X apps like MacOnLinux. Some Apple PowerBooks have over-sensitive
>>>> trackpad. Apple themselves implement a similar mecanism in the kernel
>>>> driver of OS X.

I agree.

>>>
>>>   Mine is one of those machines.  I have to turn off gpm for sure,
>>> and X is
>>> quite oversensitive too (tuned it in KDE, but still this
>>> functionality would
>>> be very nice).
>>
>> How about implementing it in mousedev.c?
>
> Right, though it would need hooks in kbddev or something to know
> about keystrokes.

Yeah - that's why I put it into 'input' - that's the only piece of code
who knows about both, key and mouse events. BTW: I put the control
file into /proc/sys../input and not mac-hid because the feature is not
limited to macs.

> Also, I don't like the sysctl's as those need
> allocating sysctl numbers,

Unfortunately, the list of 'modifier' keys needs to be configurable as
well.
How can we do that without sysctl?

> which are always a problem. In 2.5,
> we could have these in sysfs, though for 2.4 I'm not sure what
> to do.
>
> Ben.
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
