Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Can I run linux without a file system?
Date: Fri, 21 Jun 2002 16:13:01 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CFE3@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>,
	"Jerry Van Baren" <vanbaren_gerald@si.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dr. Craig Hollabaugh wrote:
>
> I can say that a minimum RedHat install uses 29,296 files -
> 382.020MB, debian 10,734 files - 67.428MB, my minimal root
> filesystem 82 files and 4.8MB.
>

Hmm, my minimal rootfs is (so far) 7 Mb, (as reported by du -s).
Or, is this 4Mb you cite compressed?  I wonder because my
libc.so is over 5 Mb. (which I got from DENX eldk-1.0)

Instead of ldd, I used "objdump -x $library | grep NEEDED"
which has the advantage that you can (er, that I know how to :-)
run it in a cross environment, so I don't have to fire up the
powerpc just to run ldd on a bunch of binaries.  (maybe
there's a way to cross run ldd? ) Using that, I wrote a script
(just today, as a matter of fact) to scan all the executables
and their libraries (and links to libs) iteratively until it
produced a minimal set, then deletes whatever isn't on the list,
which got me down to 7Mb with busybox and tinylogin as my only
apps.  (It occurs to me now that apps using dlopen() could be
a problem, but those are relatively rare.)

Any hints or links to into on crunching down the
individual libraries would be helpful.

BTW, nice book.

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
