From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14227.17537.383252.433328@gargle.gargle.HOWL>
Date: Mon, 19 Jul 1999 11:30:09 -0400 (EDT)
To: Paul Mackerras <paulus@cs.anu.edu.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Broken sound?
References: <14222.9603.505701.976724@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


pm=Paul Mackerras writes:
pm> Jerry Quinn <jquinn@nortelnetworks.com> wrote:
pm> 
pm> > I have a Powercenter 120 with 200Mhz 604e card running vanilla 2.2.10.  Sound
pm> > seems to be broken.  I do 'cat junk.au > /dev/audio' and get very interesting
pm> > sounding static.  Is there a patch in vger I should be using that hasn't made
pm> 
pm> What is the nature of junk.au?  Is it 16-bit or 8-bit, stereo or mono,
pm> linear, mu-law or A-law encoded, and if it's 16-bit, is it big-endian
pm> or little-endian?

Hmm, junk.au started out as a wav file from Gnome.  I originally was trying to 
get the wav files working and then figured I'd try converting with sox to au.
I think I used error.wav in /usr/share/sounds (R5 dist).  

Since the wav file wasn't working, I tried using sox with -x in an attempt to
swap endianness.  The result was identical, so I thought I was dealing with
8-bit sound.  I then tried a simple conversion to au.  Which doesn't seem to
do any better.

What's the best way to figure out what format it really is?

pm> When you open /dev/audio, the driver sets it to 8kHz, mono, mu-law
pm> encoded.  It's possible that the mu-law decoding is stuffed, I've
pm> never used it myself.  I just tried catting a .au file to /dev/audio
pm> and it worked fine, though.

How is playing of other sound formats handled?  How is the sample rate and
stereo set?

pm> 
pm> > Also, if I send a sound to /dev/audio, it plays through both internal and
pm> > external speakers.  If I try to send the sound to /dev/audio1, bash claims it
pm> > doesn't exist even though it shows up on 'ls'.
pm> 
pm> You can use one of the many mixer programs to set the volume levels
pm> for the internal speaker and the headphone output.

OK.

What is /dev/audio1?  Is that a separate device for the internal speaker?
Also, is there supposed to be /dev/dsp?  I seem to have /dev/dsp1 only.  I
presume this is access to the mixer?

In a somewhat related question, is there a correct place where docs on this
stuff should go?  Using man didn't turn up as much as I'd like, so if I figure
out what it all does, I'd be glad to write a couple pages of docs :-)

Jerry

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
