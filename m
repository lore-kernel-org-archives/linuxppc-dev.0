Message-ID: <017c01bf8a91$0e74f460$571170c1@honda.isltd.insignia.com>
From: "jjs" <Jerry.Sexton@insignia.com>
To: "Kevin Buettner" <kev@primenet.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: gdb and multi-threaded applications.
Date: Fri, 10 Mar 2000 13:03:39 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>In order for me to be able to go further on this problem, I'll need to
>be able to reproduce it on my machine so that I can debug it.  Could
>you look at what your proprietary application is doing (with regard to
>thread creation) and attempt to create a small program which illustrates
>the problem?
>
>Kevin
>

Kevin,

Sorry I have not been back to you sooner, I have been distracted by other
things. I tried getting a test application to exhibit the same behaviour
with no luck. However, I did notice that before the call to pthread_create
to start up the new thread we have the line:

    pthread_sigmask(SIG_BLOCK, &fullSigMask, &sigMask);

All the bits in fullSigMask are set, so this call blocks all signals to the
calling thread. Commenting this line out makes everything work under gdb,
the new thread gets created and doing 'info threads' after this gives me a
list of all the threads running in the process. This implies that gdb
requires a signal to be unblocked at the point the thread is created. If
this is fact the case, which signal must we not block in order for correct
operation under gdb?

Cheers, Jerry.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
