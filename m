Message-ID: <B25E2E5A003CD311B61E00902778AF2A02044638@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: dcache BUG()
Date: Mon, 7 May 2001 10:21:27 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I posted this to message linux-kernel too, but maybe someone here has seen
this, or can duplicate this problem...

Running snmpd or httpd overnight causes this oops: (kernel BUG at
/home/brian/linux/include/linux/dcache.h:251! - in dget() called from
d_alloc()).  Occasionally I see: de_put: entry net already free! before the
oops.

I've been able to reliably reproduce the problem in 15 minutes by running
this instead:
while /bin/true; do cat /proc/net/* 2>/dev/null > /tmp/junk; done;

The dget() fails when trying to open /proc/net/tcp, for example, and finds
that net has a zero dentry->d_count.

Montavista 2.4.2, patched to 2.4.3 on a 405GP, with root fs on ramdisk. Any
ideas on why this is happening? The system is stable otherwise.

Thanks, Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
