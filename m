Date: Wed, 27 Jun 2001 13:42:09 +0200 (MEST)
From: Michael Habermann <MHabermann@gmx.de>
To: Matthew Locke <mlocke@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary32197993642129"
References: <3B39524B.5090108@mvista.com>
Subject: Re: Segmentation fault while dynamic linking
Message-ID: <32197.993642129@www29.gmx.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary32197993642129
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> >>> My configuration: Kernel 2.4.4, glibc 2.2.2, bash 2.05, FADS, MPC855T
> >>
...
> > binutils 2.11.2
> > gcc 2.95.3
> > glibc 2.2.2
> >
> > Everything unpatched and downloaded from ftp.gnu.org.
>
>
> yeah, sounds like the cacheline problem. It is still in glibc 2.2.2 and
> 2.2.3.

>From what I read in the mailing list, I would also say it looks like this
problem.

I've recompiled my toolchain now with plain gnu software and the following
patches
from ftp.mvista.com and glibc-src package:
glibc22-27.patch               glibc22-getaddrinfo.dpatch
glibc22-disable-static.dpatch  glibc22-nss-upgrade.dpatch
glibc22-eo_EO.dpatch           glibcbug.dpatch

But the problem is still there.

I couldn't find 'the cacheline patch'. Is it the one mentioned here:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200003/msg00073.html

It contains for example this lines:
--- dl-machine.c.ORIG   Fri Mar  5 00:26:43 1999
+++ dl-machine.c        Sat Nov  6 14:33:47 1999
@@ -250,7 +250,11 @@
         PowerPC processors have line sizes of exactly 32 bytes.  */

       size_modified = lazy ? rel_offset_words :
PLT_INITIAL_ENTRY_WORDS;
+#ifdef PPC_CACHELINESIZE_32
       for (i = 0; i < size_modified; i+= 8)
+#else
+      for (i = 0; i < size_modified; i+= 4)
+#endif

But this increment is already at +4 in my nupatched glibc.






--
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

--
GMX Tipp:

Machen Sie Ihr Hobby zu Geld bei unserem Partner 1&1!
http://profiseller.de/info/index.php3?ac=OM.PS.PS003K00596T0409a
--========GMXBoundary32197993642129
Content-Type: application/octet-stream; name="

"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="
"

--========GMXBoundary32197993642129--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
