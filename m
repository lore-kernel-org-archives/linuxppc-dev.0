Message-ID: <T59373b00ffac1785c31d3@pcow058m.blueyonder.co.uk>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Alban Fellows <Alban.Fellows@blueyonder.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB audio
Date: Thu, 21 Feb 2002 22:32:01 +0000
References: <85ofii3lk9.fsf@junk.nocrew.org>
In-Reply-To: <85ofii3lk9.fsf@junk.nocrew.org>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thursday 21 February 2002 3:24 pm, Lars Brinkhoff wrote:
> I got an iSub today.  It's recognized as an USB audio device when it's
> connected, and it basically works, but there are two problems:
>
> * Whenever I kill a process (with ^C, to be precise) writing audio
>   data to the iSub, that process hangs.  From then on, all processes
>   opening the dsp or mixer devices also hang.  If I don't kill the
>   process, suspending and resuming works fine.
>
> * The "aumix" program (version 2.7) doesn't seem to think there is a
>   volume control.
>
> I'm running Linux 2.4.18-rc1-benh (from ppckernel.org).

For the group's information I have had similar hanging problems with my
Roland UA-30 USB Audio Interface. The most major issue has been the fact that
because the process cannot be killed, the filesystem is in use and cannot be
unmounted, which results in a forced fsck after reboot.
This has become less of a problem since I switched to ext3 filesystems, as
they don't need fsck.

I am running 2.4.18-rc1 from the bitkeeper ppc tree.

As a side issue to this I have noticed that the console beep does not work on
the USB audio, but does on the dmasound for the builtin audio. I now have
both installed and get console beeps from the Mac and most of my other sound
from the USB.

BTW. Is there any reason why the dsp devices appear to be single open. (ie
once one program has the sound another program can hang waiting for it)

thanks

Alban.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
