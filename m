Message-Id: <200007251952.UAA21889@hyperion.valhalla.net>
Date: Tue, 25 Jul 2000 20:53:10 +0100
Subject: Re: sound again [was: Re: xf4 bug report]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: SteffenH@hyperion-software.de, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hmmm...
[...]
>>Glad to hear it boots OK (I wasn't sure that the AppleSCSI driver wouldn't
>>panic on boot - it used to on my Lombard)...
>
> Appearently the problem was a wrong entry in /etc/conf.modules... it had
>
> alias sound dmasound
>
> there while correct would be
>
> alias sound dmasound_awacs
>
> After I fixed this the sound modules can be correctly loaded during bootup,
> but there is still no sound. Maybe I should go back to the old kernel and try
> if it works with that, or don't you think this will make a difference ?

No, I'm afraid it won't make any difference.

The dmasound_awacs entry only arrives with the back-port.  As Franz said,
the error you were getting before was probably due to the conf.modules entry
- when Ben had built the dmasound in.

So the long & short of it is that you don't get sound out with the "current"
set of code.  == there *should* be no difference in the implementation
between 2.2.17pre10 and the back-port (I checked that fairly carefully)...
and this seems to bear that out.

So.. the next thing to do is to find out why you get no sound.

1. what does dmesg now show?
2. have you tried headphones/versus built-in speaker?  (others have reported
a problem here - which is why the finger of blame is currently pointing at
the mixer abstraction)...

3. what does cat /dev/sndstat say?

4. what are you using to try and get sound out (e.g. some of the kde
implementations had broken sound anyway) - I never got *any* beeps &
whistles until I upgraded.

I can send or post a prog. that sets the snd output to 16bit LE - so that
you can just cat <some_file.wav> >/dev/dsp  if that's any use.

xmms usually works for me (although I've been using the cvs version)...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
