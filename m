Date: Mon, 27 Jan 2003 22:33:17 +0100
From: Till Straumann <till.straumann@tu-berlin.de>
Subject: Re: [patch] ignore trackpad/mouse while typing
In-reply-to: <20030127202508.A23905@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, George Staikos <staikos@kde.org>
Message-id: <F3312021-323E-11D7-BADC-0003934F7CE4@tu-berlin.de>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday, January 27, 2003, at 08:25 , Vojtech Pavlik wrote:

> On Mon, Jan 27, 2003 at 08:16:24PM +0100, Franz Sirl wrote:
>
>> On Saturday 25 January 2003 22:29, Vojtech Pavlik wrote:
>>> On Sat, Jan 25, 2003 at 10:25:56PM +0100, Benjamin Herrenschmidt
>>> wrote:
>>>>>>> Well... the problem happpens in console as well, and with other
>>>>>>> non-X apps like MacOnLinux. Some Apple PowerBooks have
>>>>>>> over-sensitive trackpad. Apple themselves implement a similar
>>>>>>> mecanism in the kernel driver of OS X.
>>>>>>
>>>>>>   Mine is one of those machines.  I have to turn off gpm for sure,
>>>>>> and X is quite oversensitive too (tuned it in KDE, but still this
>>>>>> functionality would be very nice).
>>>>>
>>>>> How about implementing it in mousedev.c?
>>>>
>>>> Right, though it would need hooks in kbddev or something to know
>>>> about keystrokes.
>>>
>>> It could accept keyboards as an event source for this purpose. I'd
>>> like
>>> to keep this out of the input core.
>>
>> Hmm, this reminds me of one feature I would need in the input core to
>> support
>> 1-button mices in userspace (or at least in a totally self-contained
>> module),
>> namely the ability to register "filters" that are called early in
>> input_event() and where a return value !=0 lets it return immediately
>> from
>> input_event() without processing the event.
>>
>> Eg. something along these lines:
>>
>> 	ret = 0;
>>         list_for_each_entry(filter, &dev->f_list, d_node)
>>                 if (filter->open)
>>                         ret |= filter->handler->event(handle, type,
>> code,
>> value);
>> 	if (ret) return;
>>
>> Comments?
>
> I don't think I want this. This *can* be solved completely in userspace,

It can, but at the expense of 2 context switches per event if you run
a filter program in user space.

-- Till.

> the only problem would be that the interface to the userspace program
> doing it wouldn't be the same as to evdev.c, and that the kernel *dev.c
> modules could not bind to do it.
>
> For mice, there is no problem - the mouse protocol can be implemented
> over a bidirectional pipe.
>
> For making another evdev device, you can use uinput.
>
> You'd only have problems should you want to create a joystick device,
> which you most likely won't need to do.
>
> --
> Vojtech Pavlik
> SuSE Labs
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
