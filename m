Message-ID: <38581AF7.DD518D6E@ctam.com.au>
Date: Thu, 16 Dec 1999 09:49:28 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc-embedded: NFS boot options.
References: <3856C0D7.4E1404C9@ctam.com.au> <385703C2.AA4298E7@netx4.com> <38570544.476D42C9@ctam.com.au> <385714D8.8AD74656@netx4.com> <3857103E.6608A366@ctam.com.au> <3857E630.5B63BD3E@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Brendan Simon wrote:
>
> > I now get the attached output.  Notice the "VFS: Mounted root (NFS
> > filesystem) readonly." message.
>
> At some point, long ago, the generic kernel root mounting had
> a subtle change for some reason.  The result is that all file
> systems are now mounted read-only by default.  All you need
> to do is add "rw" to the command line.  It should look like
> this: root=/dev/nfs rw......Now, the more interesting part is
> I thought I did that as part of the default command line in
> arch/ppc/mbxboot/misc.c......where did it go?

I am working with the embedded-2.2.5.tgz archive.  The default option
for NFS is "root=/dev/nfs".  There is no rw option.  Anyway, I use the
boot prompt to specify my inet addresses rather than setup a bootp
server.  I use the following options
"root=/dev/nfs nfsaddrs=203.21.127.150:203.21.127.160
nfsroot=203.21.127.160:/sys/myroot rw debug".  The rw option works as
the VFS message no longer says readonly.  I can't see any difference
with debug option specified or not.

I still get the same results.  ie. /bin/sh gets invoked but I get no
prompt and I can't type anything.  I will try the nfsd in the foreground
as suggested by someone else.  tcpdump suggests that the nfs server is
doing arp requests for the 860 system but is getting no repsonse.  Maybe
the network driver has some problems (most likely with my port to SCC4)
?

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
