From: Benjamin Herrenschmidt <bh40@calva.net>
To: <jcarr@linuxppc.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: call_prom & call_method_1
Date: Mon, 9 Oct 2000 22:29:40 +0200
Message-Id: <19340903140124.17579@192.168.1.10>
In-Reply-To: <Pine.LNX.4.10.10009160815360.24020-100000@jcarr.linuxppc.org>
References: <Pine.LNX.4.10.10009160815360.24020-100000@jcarr.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I'll summarize breifly what I think happens and what I can't figure out. I
>was wrong about the call_method() name. I was recalling from memory the
>first time. It's call_prom() and call_method_1() in prom.c in yaboot.
>
>Before those routines get called, yaboot_start is called from crt0.S. Then
>prom_init( r5 ) is called. I assume r5 means register 5? I couldn't figure
>out how r5 gets set before yaboot runs but would be interested to know
>just out of curiousity if anyone knows. Once prom_init starts, it calls

r5 is passed as a parameter by Open FIrmware when entering crt0.S, it's a
pointer to the OF callback mecanism.

>The confusing part here is that I can not find any reference to the string
>"finddevice" in OF. (There is a "find-device" word.) Other things sent
>to call_prom include "find-package", "getprop", etc. I guessed at
>"setprop" and that works. To make matters worse, call_method_1 is itself
>identical to call_prop( "call-method", ... ) "call-method" is not defined
>in OF either.

Those are OF client interface calls. They are not documented in the
"user" side of OF, they are calls used by client programs (like yaboot)
to talk with OF.

>call_prom("interpret", 1, 1, char *forth ) is interesting in that it will
>interpret raw forth. This is how I got the mouse to work. However, I can
>not find any example in yaboot where forth words are sent to call_prom().
>So it seems call_prom is not the right call to use.
>
>call_method_1() does infact get passed OF words like "load" and
>"block-size". So the whole syntax for that appears to be the same as:

Yup. call_method use OF client interface call "call-method" to have OF
call a method of a given package. The package method are usually
implemented in forth.

>call_prom( "call-method", prom_handle, "load", prom_handle, nargs, ... );
>
>I suspect I need to do something like:
>
>call_prom( "call-method", multiboot_handle, "get-mouse_event", 3, &x, &y
>&mouse );

You may need to open the multiboot package before that. Also, I'm not
sure it's safe to use the multiboot private methods this way. I'd rather
decrypt what multiboot "get-mouse_event" does and reproduce that
behaviour (probably by calling either the USB HID package or the ADB package).

>So these would be the questions:
>
>1) Does anyone know what other strings can be sent to call_prom besides
>"getprop", "findpackage", "interpret"?

claim, release, ... well, those are defined in the OF client interface
spec of the OF standard. Firmorks has, I think, a separate book for them

>2) Are those strings words within OF that can been looked at with see?

No, well, AFAIK...

>3) Can a phandle

but ?

>Nonetheless, without having a better correlation between the strings
>("getprop", "setprop", "findpackage", "interpret") and what those strings
>do( and what other valid strings can be used ) it will be hard to receive
>feedback from the mouse.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
