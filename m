From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [RFC] consistent_sync and non L1 cache line aligned buffers
Date: Tue, 15 Jul 2003 16:04:24 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C48A8@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> IMHO, the easiest solution is
> alignment of buffers.....plus it's likely to be a performance
> improvement.

True, it's the easiest solution for the kernel developer, but
requires more work from driver authors.  Which is ok, *if* it's
well documented and everyone knows buffers must be aligned,
and that's the problem.  I think some people implicitly understand
these issues, and assume that everyone else thinks the same way.
The driver authors on the other hand often come from completely
different environments and may be porting code that's been working
fine.

My headache example was the 4 byte buffer that MPC860 CPM
was using to talk to an I2C device, there just wasn't an
elegant solution...

A big snag is that problems in this area are not readily apparent,
and bugs may not surface early.  "Option 1", to provide assertions,
has some appeal when I think about it, because it'll point out
problems that may arise on other architectures (ie, the author
develops on PowerPC with a 'smart' invalidate_dcache_region, but
then the code mysteriously fails twice a week on a pentium).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
