Message-ID: <3858B2D4.48821DFA@ctam.com.au>
Date: Thu, 16 Dec 1999 20:37:26 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: programs wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au> <385774B8.3405494B@iname.com> <3857EAF8.491F842@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I decided to compile (using -static) a simple test program that prints a
string to stdout every second.  I called it "test1".  I tried to run it
instead of /bin/sh by using the kernel boot option "init=/test".  I still get
the same results.  nfsd says the file has been read but there is no output.

I tried compiling the same program from an intel linux box and placed it in
the same directory as test1.  I called it test2.  I mount the nfs directory
and run the program and it succeeds.

There are a couple of differences that nfsd and tcpdump report.

1) The size of nfs reads is 4096 bytes for the mpc860 unit, as appossed to
1024 bytes for the intel unit.  (BTW. the intel box is an old 486 running
kernel 2.0.30)

2) tcpdump gives fragmentation messages as follows:
20:17:22.215317 203.21.127.150.1342443538 > k9.nfs: 120 read [|nfs]
20:17:22.225317 k9 > 203.21.127.150: (frag 44076:1244@2960)
20:17:22.225317 k9 > 203.21.127.150: (frag 44076:1480@1480+)
20:17:22.225317 k9.nfs > 203.21.127.150.1342443538: reply ok 1472 read [|nfs]
(frag 44076:1480@0+)
20:17:22.245317 203.21.127.150.1342443539 > k9.nfs: 120 read [|nfs]
20:17:22.255317 k9 > 203.21.127.150: (frag 44077:1244@2960)
20:17:22.255317 k9 > 203.21.127.150: (frag 44077:1480@1480+)
20:17:22.255317 k9.nfs > 203.21.127.150.1342443539: reply ok 1472 read [|nfs]
(frag 44077:1480@0+)

They seem ok to me at first glance but it would be nice to avoid the
fragmentation to eliminate it as a possible source of error.  My nfs server
is running on a redhat-5.2 machine (kernel 2.0.36).
Is there some way to force the mpc860 machine running 2.2.5 to use nfs reads
of 1024 instead of 4096 ?
Is there some nfs incompatability between nfs kernels 2.0.x and 2.2.x ?

Thanks for any help,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
