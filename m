Return-Path: <wilbur512@gmail.com>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 64443B6F04
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jun 2010 04:23:38 +1000 (EST)
Received: by gxk23 with SMTP id 23so356197gxk.15
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 11:23:36 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 26 Jun 2010 02:23:35 +0800
Message-ID: <AANLkTilg7_YOy4Mj8YEYrCo690f7BAHkCdUbBW1CPV9H@mail.gmail.com>
Subject: cpio initrd booting failed on powerpc p4080
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All!


We are planning to port linux 2.6.21.7 to powerpc p4080  using ramdisk
file system,   but to find it failed at :

run_init_process(ramdisk_execute_command)

The exact failing place is at  run_init_process--->
do_execve--->search_binary_handler ---> load_elf_binary --->   if
(memcmp(loc->elf_ex.e_ident, ELFMAG, SELFMAG) != 0)


which means that, 'init'  is not of  'ELF' format .

And we ad some codes before execute  'init' ,  to sys_read content
from  'init' file , but to find it having  many 'zero'   value in it.



Then we add some test codes , before calling
run_init_process(ramdisk_execute_command) ,     which take the
following steps:

1) create a file  A  ,   using sys_open(CREATE)
2) write values into A   , using  sys_write
3) close A
4)open A again , and read content from it,using sys_read

We found in step 4 that , we read in some 'zero' value from the file ,
that is to say,  sys_write failed at some points.



To avoid cache affect , we use sys_sync after step 3 (close A) but to
find it no use.


So, why sys_write failed to update the file content?

Thx
