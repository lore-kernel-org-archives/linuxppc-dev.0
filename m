Date: Mon, 11 Dec 2000 01:57:23 -0500 (EST)
From: "Peter R. Wood" <pwood@gordon.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: CUDA related crash in 2.4 ?
Message-ID: <Pine.LNX.4.30.0012110150010.745-100000@dyn-134-168.gordon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've been using the linux-pmac-devel kernel for a while, and haven't had
too many problems. Recently, however, my system has frozen up hard a few
times, un-pingable, and I've had to do a hard reboot. I haven't been able
to detect a common thread, but at one point I was in console mode, when
I suddenly lost control - a message printed out to the console:

cuda: state=idle, status=28

I tracked this error message down to
linux-pmac-devel/drivers/macintosh/via-cuda.c line 444, which is within
the cuda_interrupt method, in this case:

    switch (cuda_state) {
    case idle:
        /* CUDA has sent us the first byte of data - unsolicited */
        if (status != TREQ)
            printk("cuda: state=idle, status=%x\n", status);
        x = via[SR]; eieio();
        via[B] &= ~TIP; eieio();
        cuda_state = reading;
        reply_ptr = cuda_rbuf;
        reading_reply = 0;
        break;


After it prints out the error message, it repeats the last character that
I typed about 30 or 40 times, and then the hard freeze occurs.  I don't
know if this is the same thing that happened the other three or four
times, but I suspect it may be related.

Any ideas as to why this might be causing my system to hang?

I am using a SuperMac J700, which is based on the Tsunami logic
board with CUDA, and I have both an ADB keyboard and trackball attached.

Thanks,

Peter
--
Peter R. Wood * pwood@gordon.edu * Watch it... <>< 1 Cor. 10:12
[ "You left me high and dry and changed me." - VAST ] * * * * *
[ http://www.cs.gordon.edu/~pwood/ ]  * * * * * * * * * * * * *


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
