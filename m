Message-ID: <3C099A81.6040506@waitaki.otago.ac.nz>
Date: Sun, 02 Dec 2001 16:05:37 +1300
From: Bryce McKinlay <bryce@waitaki.otago.ac.nz>
MIME-Version: 1.0
To: Jeff Koftinoff <jeffk@jdkoftinoff.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Byte order in sound drivers
References: <9A5DA94E-E647-11D5-8040-003065709198@jdkoftinoff.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jeff Koftinoff wrote:

> XMMS has endian problems with wav files, but not mp3 files - It is
> listed as a bug as well for sparc.  The problem solely lies with
> applications that are written incorrectly.


The most recent release of XMMS (0.9.5) works correctly for me for both
MP3 and WAV files, but not CD audio for which the input plugin returns
sound in the native endian-ness.

But, since that release, the following change was made in XMMS CVS:

Thu Jul  5 12:25:51 CEST 2001  Håvard Kvålen  <havardk@xmms.org>

    * Output/OSS/audio.c (oss_set_audio_params): Do endian/sign
    conversion if necessary.


This breaks it on LinuxPPC 2.4.14-ben0 with both the dmasound and
usb/audio drivers (but, amusingly, fixes the CD audio). Another
application, mplayer, also seems to have the same problem - it says
something like "big endian detected, byte conversion enabled" and
doesn't work, except for 8-bit sound files.

What I want to know is whether these applications are wrong to do this -
does the Linux PPC audio drivers expect audio to be little endian?

regards

Bryce.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
