Date: Mon, 02 Dec 2002 21:03:44 -0800
From: Till Straumann <Till.Straumann@TU-Berlin.de>
Subject: Re: [patch] ignore trackpad/mouse while typing
To: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org, vojtech@suse.cz
Message-id: <3DEC3B30.9030701@TU-Berlin.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <3DE6C428.5000403@TU-Berlin.de> <1038880026.17922.208.camel@thor>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
> On Fre, 2002-11-29 at 02:34, Till Straumann wrote:
>
>
>>+ 		if ( jiffies - mouse_holdoff_last_jiffie < mouse_holdoff_jiffies )
>>+ 			return;
>>+ 		/* Note: we could lose mouse events when the jiffie counter rolls over... */
>
>
> I think the difference is always correct.
>
>
No: if no key is pressed for (any integer multiple of) 2^32 jiffies then
mouse events are ignored during a short period of time following the
rollover ;-)
[ i.e. the rollover of the difference, not the jiffies; the true
   relation being
    (jiffies - mouse_holdoff_last_jiffie) % 2^32 < mouse_holdoff_jiffies
]

Anyways: the patch has another problem: the trivial version cannot deal
with

  - emulated mouse buttons (ignored because input_event() first receives
    a key event which is sent to the keyboard handler who remaps it to a
    mouse/button event to be ignored since it happens shortly after the
    key event triggering it)
  - 'modifiers' (Shift, Ctrl & friends). All keys seem to be
    'auto-repeated' by the input driver resulting in repeated
    key events while a modifier is pressed, hence causing the trivial
    patch to ignore mouse events while a modifier key is held down.

I'm working on an improved version supporting a (configurable but
reasonably defaulted) list of keys who are to be considered 'modifiers'.

-- Till


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
