Date: Fri, 11 Aug 2000 13:04:12 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again... 
In-Reply-To: <14735.25805.953473.825729@argo.linuxcare.com.au>
Message-ID: <Pine.HPX.4.10.10008081055160.20140-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Aug 2000, Paul Mackerras wrote:

> Gabriel Paubert writes:
>
> > Hard reset also clears the timebase on all the processors I know, so the
> > time bases should be synchronized unless the firmware plays with them
> > (assuming the HRESET pins are wired together).
>
> Certainly on my 7600 with a 2-cpu powersurge board, with the code that
> is currently in the devel kernel to use the tb register, you don't get
> the same time on both cpus.

Yes, we need a way to check that the timebase are in sync and to sync
them if they are not. That's basically the same problem in any case.
The problem is to do it in a way that works on all machines...

However current code is so broken that, if you had a jiffy counter per
processor, you would see them drifting away.

> I haven't had a chance to look at your patch in detail yet, hopefully
> soon.  At a quick glance it seemed to be touching a lot of stuff so it
> will take more than a quick glance. :-)


It does not toch so much when you look carefully at it, only timekeeping
but it's basically an all or nothing (and some global variable name
changes to be sure that I catch all the occurences which add somewhat to
the patch size).

However,

I have still found bugs in my code (but it seems to be slowly converging).
I'm also considering switching to BitKeeper tree, and sending these
patches in smaller and more digestible chunks:

- improved timing stability (fixed interrupt rate)

- 601 support and faster gettimeofday (no divide anymore)

- preliminary SMP support (gettimeofday still would have jiffy
resolution on SMP)

The problem is that these parts are somewhat hard to disentangle.  I'm
also already running 2.4.0-test6 from kernel.org which was not yet merged
in the BK tree a few hours ago and that includes a few things that I need.

	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
