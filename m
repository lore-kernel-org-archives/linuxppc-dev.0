To: m.arturo@libero.it
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Timidity
References: <3A9CFE58.DDF8B47D@libero.it> <m3bsrga1td.fsf@appel.lilypond.org>
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: 23 Mar 2001 09:47:37 +0100
In-Reply-To: Jan Nieuwenhuizen's message of "05 Mar 2001 12:32:30 +0100"
Message-ID: <m3snk4x45y.fsf@appel.lilypond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jan Nieuwenhuizen <janneke@gnu.org> writes:

> X-Artu <m.arturo@libero.it> writes:
>
> > Why Timidity lost notes on my G4/400....help me pls.
>
> I'd like to know too, but I've got no idea how to debug this.
> Generating audio in batch may work, though, try:
>
>   timidity -Ou foo.midi
>   cat foo.au >/dev/audio

> > Playing time: ~81 seconds
> > Notes cut: 444
> > Notes lost totally: 1312


Masanao Izumo sent me a reply (see below), it works for me:

08:54:35 appel ~/usr/src/lilypond-1.3.140/mutopia/Coriolan/out$ timidity -id -k0 bassi-part.midi
Playing bassi-part.midi
MIDI file: bassi-part.midi
Format: 1  Tracks: 3  Divisions: 384
Text: Creator: GNU LilyPond 1.3.140.jcn1               .
...
Playing time: ~505 seconds
Notes cut: 0
Notes lost totally: 0


From: iz@zetabits.com
Subject: Re: playback bug in timidity-2.10.2
To: janneke@gnu.org
Date: Fri, 23 Mar 2001 11:49:35 +0900

Hi,

> Timidity 2.10.2 drops notes (in the end there is only silence) when
> using direct playback: -ig or -id.

Please try to use -k0 option:

% timidity -k0 filename.mid

It is possible that this is sound synchronization probrem.
TiMidity++ checks audio buffer size.  If the current of audio buffer data has
no enough data, (this case usually occur when high CPU load avarage)
TiMidity++ automatically cut the some notes.
-k0 option disables this feature.

Some sound drivers (such as OSS from old linux packages), could
not get the current of audio data size, correctly.
Some sound cards use individual clock, not CPU clock.  This type of
sound card, audio sampling time is different from CPU time.  Then, the
audio sychronization is fail.  To get the current of the audio data
size, it is need to use the specific audio driver interface.  But old
of the OSS (or some version of OSS), there is no such interface!  Too
cheap for multimedia!

If you have this type of sound card/driver,  please try -k0 option.

--
Masanao Izumo <iz@zetabits.com>
ZetaBITS, Inc.



--
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
