Date: Sat, 06 Feb 1999 16:55:16 +0100 (MET)
From: Niels Roest <N.P.Roest@ITS.TUDelft.NL>
Subject: mouse, keyboard probs
To: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.HPP.3.95.990206163012.1976B-100000@elektron.et.tudelft.nl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello.

Although these are longstanding problems, I slowly am 
really getting fed up dealing with it myself.
Therefore, this is a cry for help, to sort out my
many adb-related probs.
Conditions: 7600/132, 48 meg, extra internal 3.2 quantum,
'macally' keyboard.

Without further ado, here they are:~
1) Since the origin of species (okay I'm overreacting)
I havn't been able to get 2nd & 3nd mouse button
emulation out of XFB (X Frame Buffer). It's really a
nice piece of software and it's the way to go (tm) but
it doesn't work. I tried 2.1.24, 2.1.125, 2.2.0-pre7 and
now 2.2.1. I tried adb_buttons, applied a Oe's patch
and tried adb_buttons again, nothing. I finally changed
0x7c (middle button code) to something else, still nothing.
I pushed Option-anything, left option, right option, every
other modyfier, combined with mouseclick,..
Surely this must have been solved.
Btw, Xpmac has always worked.

2) Since 2.2.1, my keyboard leds act like a binary number.
(during 2.2.0-pre7 I upgraded to glibc-2. important?)
At bootup, it's num-caps-scroll-lock off-off-on.
This is not a big deal, but since it always has worked,
why not anymore? I can only change the lights by using
mousemode (?). mousemode 2: it says handler = 2.
But when I do mousemode 2 x, the lights reflect x in
a negated-little-endian fashion. so, mousemode 2 7, all
lights off, mousemode 2 0, all on. Indeed, this is great
fun, but the question is: why??

3) Okay, the lights may be off, but caps still works.
However, everytime I push caps, I get an extra a.
this is with xkb on, 'cause I need a higher key-repeat.
So caps twice gives Aa. <-- no a pressed! really!
AaAaAaAaAaAa again, great fun, but really odd.

4) btw, small point, the numlock light works (I mean worked)
but it's without any function. I REALLY don't bother,
but is this normal? Same for scroll-lock.

5) Annoying problem: when I load a keymap whilst in
console-mode (no-X) with e.g. alt keycode 32 = exclamdown,
this should give me while pressing alt-u a nice upside
down exclamation mark. You guessed right, it doesn't.
I get beeps instead of letters. printing all ascii
characters using C shows that they're there allright.
neither does a dead key work or any key above ascii 128.
So, I tried fiddling with bash, and putting 'set meta-flag
on' and 'set convert-meta off' changes things, but instead
of beeps I get \351 or whatever. What gives???

6) X again. Since (I think) my glibc2 upgrade, I cannot
switch to VC1-4. (I removed to mingetty's).
When I ctrl-alt-F1, X restarts. ctrl-opt-F1 does nothing,
I tested this, because my option and alt where switched
so I couldn't use the Xpmac mid-right-mouse key anymore.
I got 'minimize' instead. But a bit of xmodmap tweaking did
the trick. But it didn't resolve the VC-switching problem.

So, that's the list. 
You can say, I saved it all up :-)
So kernel-hackers rejoice, and tell me what I can do.
Thanks a lot in advance,
Niels

btw, everything else works. :-)



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
