From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14228.34383.572486.889752@gargle.gargle.HOWL>
Date: Tue, 20 Jul 1999 10:23:11 -0400 (EDT)
To: Paul.Mackerras@cs.anu.edu.au
Cc: "Jerry Quinn" <jquinn@nortelnetworks.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Broken sound?
In-Reply-To: <199907200610.QAA09787@tango.anu.edu.au>
References: <14222.9603.505701.976724@gargle.gargle.HOWL> <14227.17537.383252.433328@gargle.gargle.HOWL> <199907200610.QAA09787@tango.anu.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> "Paul" == Paul Mackerras <paulus@cs.anu.edu.au> writes:

 Paul> Jerry Quinn <jquinn@nortelnetworks.com> wrote:
 >> Hmm, junk.au started out as a wav file from Gnome.  I originally was
 >> trying to get the wav files working and then figured I'd try converting
 >> with sox to au.

 Paul> The .wav reader in KDE had an endianness problem in how it read the
 Paul> header.  That problem is fixed in the rpms that Franz Sirl put up.
 Paul> Maybe the .wav reader in gnome has the same problem.

Apparently.  So I now know that I've got an application problem on my hands to 
track down.  Of course, I should have assumed that

 >> How is playing of other sound formats handled?  How is the sample rate and
 >> stereo set?

 Paul> Ioctls on /dev/dsp or /dev/audio.  The only difference between them is
 Paul> that with /dev/dsp you get whatever was last set (or 8kHz linear 8-bit
 Paul> mono at startup), whereas with /dev/audio it gets set to 8kHz mu-law
 Paul> 8-bit mono on the open.  There is documentation at www.opensound.com.

Thanks for the pointer.  That helps a lot.  I think that some basic
documentation on the devices will be helpful.  I guess they would need to be
part of the man-pages package.  Projects, projects ...

 Paul> You should have a /dev/dsp (char device 14,3).  /dev/audio1 and
 Paul> /dev/dsp1 would correspond to a second sound card, which you don't
 Paul> have.  Powermacs have one (stereo) sound output channel which can be
 Paul> routed to the speaker and/or the headphone.

After some kernel browsing and guessing, I came to the same conclusion.  I
used MAKEDEV to recreate the missing /dev/dsp.

 Paul> Paul.

Thanks for all the info.

Jerry



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
