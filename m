Message-Id: <l03130300b7dec9c3a691@[192.168.1.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 1 Oct 2001 21:40:48 -0400
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: VFAT not endian safe?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to share a file system between macos and linux that is capable
of long filenames. Since there's no HFS+ support yet, I decided to go with
VFAT.

Unfortunately, it seems when I write files on the linux side, all the
filenames appear as "" and the files will not open under MacOS. When I
produce files under macos, linux lists the filenames as a series of
question marks.

This was all rather confusing until I mounted the VFAT partition with an
option to show unknown unicode characters as two byte hex sequences. This
revealed that linux was reading/writing the name bytes in the wrong endian
order.

A closer look at the VFAT code seems to indicate that unicode names are
handled in the native endian order by mistake instead of being converted to
little endian. Looking around the other FS code, I wonder if this is a
pan-filesystem issue.

I'm using at benh 2.4 from about a month ago. Does anybody know if there is
work underway to fix this problem or should I go ahead and start plugging
away at it?

Thanks.

____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
