From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>
Subject: Occasional crash reports
Date: Mon, 13 Aug 2001 18:35:21 +0200
Message-Id: <20010813163521.17302@smtp.adsl.oleane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm getting regular crash reports for which I'm having trouble figuring
out what's going on exactly. Those are with my tree or bk 2_4_devel, but
the problem may be present elsewhere.

So basically, the kernel tends to die in various locations where things
should be just fine, but I did notice one thing: In most of these cases,
I had softirq around in the backtrace (either running in softirqs, or
having do_softirq() in the backtrace). There is one case where I didn't
have it: it dies inside power_save(), so probably because an interrupt
that happened just before messed things up.

I'm wondering if we might be running into some stack overflow...

Any clue ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
