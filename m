From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bryce McKinlay <bryce@waitaki.otago.ac.nz>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Jeff Koftinoff <jeffk@jdkoftinoff.com>, <havardk@xmms.org>
Subject: Re: Byte order in sound drivers
Date: Sun, 2 Dec 2001 10:56:51 +0100
Message-Id: <20011202095651.24942@smtp.wanadoo.fr>
In-Reply-To: <3C099A81.6040506@waitaki.otago.ac.nz>
References: <3C099A81.6040506@waitaki.otago.ac.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The most recent release of XMMS (0.9.5) works correctly for me for both
>MP3 and WAV files, but not CD audio for which the input plugin returns
>sound in the native endian-ness.

So far, I had MP3s working but not WAV nor cdread (blank noise in both
cases). I didn't yet try 0.9.5 though.

>But, since that release, the following change was made in XMMS CVS:
>
>Thu Jul  5 12:25:51 CEST 2001  Håvard Kvålen  <havardk@xmms.org>
>
>    * Output/OSS/audio.c (oss_set_audio_params): Do endian/sign
>    conversion if necessary.
>
>
>This breaks it on LinuxPPC 2.4.14-ben0 with both the dmasound and
>usb/audio drivers (but, amusingly, fixes the CD audio). Another
>application, mplayer, also seems to have the same problem - it says
>something like "big endian detected, byte conversion enabled" and
>doesn't work, except for 8-bit sound files.
>
>What I want to know is whether these applications are wrong to do this -
>does the Linux PPC audio drivers expect audio to be little endian?

It depends on the HW you have. Most recent machines don't do HW
byteswap, and so accept only big-endian samples. The way this is
implemented in our driver currently is a bit weird though, the
setformat ioctl won't fail when trying to set an LE format, but
it will set the equivalent BE format. So the application is
expected to read back the format to figure out what had to be
done.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
