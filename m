Message-ID: <762A181C0D966E459A2EB3B810142C770386143A@nmrusdunsx12.nmrlan.net>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "'Carlo Parravicini'" <c.parravicini@sehitaly.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: ELDK 3.0 C++ Problem
Date: Fri, 21 May 2004 12:46:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Carlo.

> Lost the beer, the code is wrong but the segfaulted is in the "new"
> (checked with a printf before the memset & also with gdb eh eh)

I'll bet _two_ cases of beer that Wolfgang won the beer. The seg. fault is
happening in the memset.

"printf before the memset" is the wrong debugging tool to use here because
the segment fault happens _before_ the printf output gets printed.  Why gdb
didn't show that you got to the memset call is a puzzle.

One thing is sure.  Your program allocates 4 bytes on the heap.  It then
clears those 4 bytes and the 9,996 bytes that follow.  That's _guaranteed_
to mess up the heap.

BTW, give your program a try in Developer Studio on your PC.  You get a
segment fault out of memset.

Regards,
Charlie

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
