Message-ID: <3CAB511C.F962DCF7@lvl7.com>
Date: Wed, 03 Apr 2002 13:59:40 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: implementing callback tracing on sigsegv's
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey all!
	I've got a question regarding stack traces in user space.  I've recently
implmented a stack trace mechanism for our platform which upon receipt of a
SIGSEGV.  It all seems to work great, but there are two stack frames that appear
in every stack trace that I'm interested in.  Neither maps to an address within
the boundries of the static image which received the sigsegv.  The first I have
determined is an address within the pthreads shared library (the function is
_pthread_manager_sighandler), and it is my understanding that it is responsible
for ensuring that synchronous signals are delivered to the thread which caused
them.  The second stack frame is the real mystery to me.  Its  usually at an
address thats a little way below address 0x80000000 (the end of addressable user
program space, I think), and it has alot of data contained in the stack frame.
Stack frames beyond that start with the address about which the sigsegv occured
and procede normally up the call stack from there.  I have heard rumors this
mystery stack frame contains data which can be very usefull in debugging but I
have been unable to find any information on the frames format or what data
exactly it might contain.  If anyone knows anything about this frame and where I
might find more information about it, I would be most appreciative.  Thanks a
bunch!
Neil :)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
