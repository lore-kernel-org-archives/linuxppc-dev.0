Date: Tue, 13 Apr 1999 17:53:52 +0300 (EET DST)
From: "Thomas E. Arvanitis" <tharvan@ellemedia.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: LinuxPPC on FADS
Message-ID: <Pine.GSO.4.05.9904131709060.29269-100000@lucifer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello All,

I am trying Linux-2.2.0-pre7 (provided by Dan) on a FADS-860SAR with 4MB
DRAM. After a few modifications, I am now up to the point where I boot ok
and kernel runs execve for "init". 

I use initrd, because NFS_ROOT (as I have read in the list's archive)
just doesn't work (is that true by the way? any news on that?), and I
personally have reached a dead-end: although root over NFS mounted ok,
never worked properly after that.
In the initrd case, ramdisk image is based on mbxroot.min (By Dan
again). I boot with the following args:

root=/dev/ram ramdsik_size=1536 ip=###.###.###.### init=/bin/sh

So what I get is:
- kernel uncompresses fine
- uart and ethernet initialize ok
- ramdisk also starts up ok
- ramdisk is uncompressed ok and mounted
- unused memory (28k init) is freed
- elf proccessing of sh is done also (I think) normally

After or around setup_arg_pages the kernel starts behaving realy weirdly.
Either it just hangs or I get a panic for a "page fault in interrupt".
In almost all cases I find that memory especially in the range of
0x300-0x1200 (ISRs) is strangely modified. In many places I find instead 
of expected code (e.g. EXCEPTION PROLOG instructions) virtual addresses or
physical addresses numbers. It seems like it goes crazy running arround
and writting where it shouldn't.

Has anyone any idea what's going on? Has anybody seen something like that
again?

Thanks for your help,
-Thomas.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
