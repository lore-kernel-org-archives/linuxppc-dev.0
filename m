Date: Tue, 20 Jul 1999 16:10:53 +1000
Message-Id: <199907200610.QAA09787@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: jquinn@nortelnetworks.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <14227.17537.383252.433328@gargle.gargle.HOWL>
	(jquinn@nortelnetworks.com)
Subject: Re: Broken sound?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <14222.9603.505701.976724@gargle.gargle.HOWL> <14227.17537.383252.433328@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jerry Quinn <jquinn@nortelnetworks.com> wrote:

> Hmm, junk.au started out as a wav file from Gnome.  I originally was trying to 
> get the wav files working and then figured I'd try converting with sox to au.

The .wav reader in KDE had an endianness problem in how it read the
header.  That problem is fixed in the rpms that Franz Sirl put up.
Maybe the .wav reader in gnome has the same problem.

> How is playing of other sound formats handled?  How is the sample rate and
> stereo set?

Ioctls on /dev/dsp or /dev/audio.  The only difference between them is
that with /dev/dsp you get whatever was last set (or 8kHz linear 8-bit
mono at startup), whereas with /dev/audio it gets set to 8kHz mu-law
8-bit mono on the open.  There is documentation at www.opensound.com.

> What is /dev/audio1?  Is that a separate device for the internal speaker?
> Also, is there supposed to be /dev/dsp?  I seem to have /dev/dsp1 only.  I
> presume this is access to the mixer?

You should have a /dev/dsp (char device 14,3).  /dev/audio1 and
/dev/dsp1 would correspond to a second sound card, which you don't
have.  Powermacs have one (stereo) sound output channel which can be
routed to the speaker and/or the headphone.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
