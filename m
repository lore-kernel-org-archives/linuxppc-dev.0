Subject: spurious serial console hangup in 2.4.23-pre2 and later
From: "Guy M. Streeter" <streeter@redhat.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1065122778.1035.20.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 02 Oct 2003 14:26:18 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using a board with a GT-64260 implementing the serial console. In
kernels later than 2.4.23-pre1, the console hangs in the middle of the
login procedure.
I have placed debug printks in the driver's open, close and hangup
routines, and I find two differences in the newer kernels:

1. Early in init (possibly after exec of the init app) there is one more
call to the driver's close routine than I see with the older kernel.
This difference may be OK, since it doesn't bring the use count down to
zero.

2. During login, after agetty has read the username but before login has
prompted for the password, there occurs a call to the driver's hangup
routine. This doesn't happen with the earlier kernel, and it results in
the driver returning -EIO for all subsequent requests.

I can't find any differences between pre1 and pre2 that obviously affect
this. I have noticed that adding the ac4 patch set to a 2.4.22 kernel
causes the same scenario.
Could someone clue me about changes that could make this happen, and
what to do to fix it?

thanks,
--Guy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
