Date: Mon, 11 Oct 1999 15:43:25 -0400
From: Eric Dorland <dorland@lords.com>
To: Elliot Lee <sopwith@redhat.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
Message-ID: <19991011154325.A14359@HSE-MTL-ppp4363.qc.sympatico.ca>
References: <19991005105431.012853@mailhost.mipsys.com> <Pine.LNX.4.10.9910050733100.1006-100000@lacrosse.corp.redhat.com> <19991005204016.A3979@HSE-MTL-ppp4439.qc.sympatico.ca> <19991011020649.A804@HSE-MTL-ppp4447.qc.sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991011020649.A804@HSE-MTL-ppp4447.qc.sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 11, 1999 at 02:06:49AM -0400, Eric Dorland wrote:
> Well, I've been following the development of enlightenment (0.16 just been
> released, BTW) and they've got a fix in their sound code which fixes sound
> playing (in E anyway). The fix has more to do with libaudiofile than esd. On
> lines 80-84 in sound.c (the LoadWav function) we find:
> 
> #ifdef WORDS_BIGENDIAN
>       afSetVirtualByteOrder(in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_BIGENDIAN);
>    #else
>       afSetVirtualByteOrder(in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_LITTLEENDIAN);
> #endif
> 
> I don't know audiofile particularly well, but its obvious this is telling
> audiofile to output the file in as big-endian for the later afReadFrames
> statement. This means any application that's using audiofile should have
> this line in them, and audiofile should compile by default with the Virtual
> Byte Order set to big-endian on big-endian machines (the current version may
> do this, I haven't looked at the code). GNOME's sound code doesn't have this
> hack, so I'm going to send them a patch, hopefully in time for 1.0.50.

I little browsing of the code does show that libaudiofile sets the virtual
byte order, by default, to the correct setting for the current architecture.
And looking at gnome-libs, up in till last week, the sound code was
explicitly setting the virtual byte order to little-endian. Thankfully now
its fixed, so the next build of GNOME should have working sound.

It appears I spoke to soon about sound working perfectly. Whenever esd plays
a 16bit wav file, the sound plays at about half speed. Ugg. At least its not
static anymore. I'm going to see if I can track down why this is happening
(maybe its some on-the-fly endianess swaping slowing it down), but I don't
know sound code all that well, so anyone that does, please lend a hand.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
