Subject: Workaround for Macraigor OCD Commander download problem
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 14 Jan 2000 11:16:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000114001613.DB5031B150@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In case anyone else is thinking of using a Macraigor BDM/OCD device to download
code to their target hardware, the following advice might save you a couple of
hours of hair-pulling. Using the 1999 version of OCD Commander with a Raven,
I found that the s-records read from my input file were being silently
truncated after 20 bytes. Since GNU objcopy generates 21 bytes s-records, my
download was being corrupted.

Macraigor tell me that they're working on the problem, in response to my
report. Meanwhile, here's a patch to binutils to work around the problem:

*** bfd/srec.c.dist     Thu Dec  2 18:10:20 1999
--- bfd/srec.c  Thu Dec  2 18:10:30 1999
***************
*** 171,177 ****
  /* The maximum number of bytes on a line is FF */
  #define MAXCHUNK 0xff
  /* The number of bytes we fit onto a line on output */
! #define CHUNK 21
  
  /* When writing an S-record file, the S-records can not be output as
     they are seen.  This structure is used to hold them in memory.  */
--- 171,177 ----
  /* The maximum number of bytes on a line is FF */
  #define MAXCHUNK 0xff
  /* The number of bytes we fit onto a line on output */
! #define CHUNK 20
  
  /* When writing an S-record file, the S-records can not be output as
     they are seen.  This structure is used to hold them in memory.  */

Regards,
Graham


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
