Message-ID: <6B546A602AD2D211BFF00008C7A4288905843FE2@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'David Ashley '" <dash@xdr.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux 2.4.17 bug, mmap of /dev/mem
Date: Fri, 15 Feb 2002 08:17:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi David,

Yes, there are a lot of differences.

Did you try other protections flags like VM_IO (I think this is selected
automatically in mem.c) and VM_RESERVED?

Fred

-----Original Message-----
From: David Ashley
To: linuxppc-embedded@lists.linuxppc.org
Sent: 2/14/02 6:06 PM
Subject: RE: Linux 2.4.17 bug, mmap of /dev/mem


Hmmm. Too many differences, the biggest being 2.4.17 vs 2.4.2.

I forgot to mention to the mailing list that the order of reads/writes
to
a page matters.

In every mmap'd page, if the access order is:
reads only    = no problem
writes only   = no problem
write, read, then anything  = no problem
read, write   = trouble

Each page is a separate entity. Meaning if I mmap 2 pages of /dev/mem,
then write to page 0, I'll not have any trouble from page 0 from then
on.
But if I read from page 1, then write to page 1, there is a chance of
corrupting linux.

-Dave

>Hi David,
>
>I tested your application on my board (Embedded Planet CLLF (mpc860),
Linux
>2.4.2) and made a script that executes it as fast as possible.
>I let it run for 10 minutes on several telnet sessions simultaneously
but I
>do not see anything strange... The memory I write to is NVRAM.
>
>Frederic


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
