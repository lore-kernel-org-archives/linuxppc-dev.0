Date: Mon, 11 Oct 1999 02:06:49 -0400
From: Eric Dorland <dorland@lords.com>
To: Elliot Lee <sopwith@redhat.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
Message-ID: <19991011020649.A804@HSE-MTL-ppp4447.qc.sympatico.ca>
References: <19991005105431.012853@mailhost.mipsys.com> <Pine.LNX.4.10.9910050733100.1006-100000@lacrosse.corp.redhat.com> <19991005204016.A3979@HSE-MTL-ppp4439.qc.sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991005204016.A3979@HSE-MTL-ppp4439.qc.sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 05, 1999 at 08:40:16PM -0400, Eric Dorland wrote:
> 
> On Tue, Oct 05, 1999 at 07:36:19AM -0400, Elliot Lee wrote:
> > In ftp://people.redhat.com/sopwith/esound-0.2.15.tar.gz (not a final
> > release), it explicitly sets big-endian mode on big-endian machines, so
> > things should work a bit better. There is also a related bug in the sound
> > file playback code fixed, that should help davem's "esdplay plays garbage"
> > problems. Please try this out and let me know.
> 
> Unfortunately, under my machine (G3/266 DT) this version works even more
> poorly than the one I was using before. The startup beeps are now more like
> startup hisses, and wavs (whether 8-bit or 16) sound like a bunch of
> hissing. To compile it I just did a vanilla ./configure; make; make install
> which seemed to be the right thing to do.

Well, I've been following the development of enlightenment (0.16 just been
released, BTW) and they've got a fix in their sound code which fixes sound
playing (in E anyway). The fix has more to do with libaudiofile than esd. On
lines 80-84 in sound.c (the LoadWav function) we find:

#ifdef WORDS_BIGENDIAN
      afSetVirtualByteOrder(in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_BIGENDIAN);
   #else
      afSetVirtualByteOrder(in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_LITTLEENDIAN);
#endif

I don't know audiofile particularly well, but its obvious this is telling
audiofile to output the file in as big-endian for the later afReadFrames
statement. This means any application that's using audiofile should have
this line in them, and audiofile should compile by default with the Virtual
Byte Order set to big-endian on big-endian machines (the current version may
do this, I haven't looked at the code). GNOME's sound code doesn't have this
hack, so I'm going to send them a patch, hopefully in time for 1.0.50.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
