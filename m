Reply-To: <yooth@ipone.co.kr>
From: "Yoo. Jonghoon" <yooth@ipone.co.kr>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: file system for flash memory?
Date: Fri, 22 Jun 2001 11:17:37 +0900
Message-ID: <NFBBLHGHILCOPCKBODHAOEPDCAAA.yooth@ipone.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
my custom board uses one 8-kbytes flash sector to store
environmet variables, various logs and etc...
At this time, I modified sbull(simple block device driver
from 'Linux device driver', O'Reilly) and added flash driver
routine. and made minix file system on it. the minix file
system works well, but has the following problems:

a. if user once calls write() to write 8kbytes on flash, the
  minix file system calls write function of device driver
  for many times - each time writes only 512bytes.
  minix file system cuts 8kbytes into several 512bytes
  blocks and *erasse-write the whole flash sector* occurs
  for each block.

b. It has no power-down reliability.

Can anybody recommend other file system suited in
this case? eg. raw flash which ppcboot does. (I think
concurrency becomes problem in this one) or jffs.
I read a few jffs docs. but I think that's suited for system
using many flash sectors for the file system, not for my
case which uses one or two sectors. Am I right ?

Thanks in advance.

===============================================
Yoo. Jonghoon,        IPone inc.
===============================================
e-mail : yooth@ipone.co.kr
tel : 82-2-02-2222-4631
===============================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
