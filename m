From: jcarr@linuxppc.org
Date: Mon, 9 Oct 2000 14:42:38 -0400 (EDT)
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: call_prom & call_method_1
In-Reply-To: <14776.4770.532985.35715@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.10009160815360.24020-100000@jcarr.linuxppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'll summarize breifly what I think happens and what I can't figure out. I
was wrong about the call_method() name. I was recalling from memory the
first time. It's call_prom() and call_method_1() in prom.c in yaboot.

Before those routines get called, yaboot_start is called from crt0.S. Then
prom_init( r5 ) is called. I assume r5 means register 5? I couldn't figure
out how r5 gets set before yaboot runs but would be interested to know
just out of curiousity if anyone knows. Once prom_init starts, it calls

call_prom( "finddevice", 1, 1, "/chosen" );

All of this is fine and dandy up to the line in call_prom:
prom ( &prom_args );
Which is the miracle of the whole thing. prom being set to r5 now is
called and actually returns something from OF!

The confusing part here is that I can not find any reference to the string
"finddevice" in OF. (There is a "find-device" word.) Other things sent
to call_prom include "find-package", "getprop", etc. I guessed at
"setprop" and that works. To make matters worse, call_method_1 is itself
identical to call_prop( "call-method", ... ) "call-method" is not defined
in OF either.

call_prom("interpret", 1, 1, char *forth ) is interesting in that it will
interpret raw forth. This is how I got the mouse to work. However, I can
not find any example in yaboot where forth words are sent to call_prom().
So it seems call_prom is not the right call to use.

call_method_1() does infact get passed OF words like "load" and
"block-size". So the whole syntax for that appears to be the same as:

call_prom( "call-method", prom_handle, "load", prom_handle, nargs, ... );

I suspect I need to do something like:

call_prom( "call-method", multiboot_handle, "get-mouse_event", 3, &x, &y
&mouse );

So these would be the questions:

1) Does anyone know what other strings can be sent to call_prom besides
"getprop", "findpackage", "interpret"?

2) Are those strings words within OF that can been looked at with see?

3) Can a phandle

Nonetheless, without having a better correlation between the strings
("getprop", "setprop", "findpackage", "interpret") and what those strings
do( and what other valid strings can be used ) it will be hard to receive
feedback from the mouse.
Jeff
jcarr@linuxppc.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
