Message-Id: <199901101714.SAA00311@piglet.cpu.lu>
Date: Sun, 10 Jan 1999 18:14:01 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Strange tar hang....
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Anybody can help with this?

For many kernel versions now, I have problems with tar. On extraction
of any archive, tar will regularly 'hang', and only continue extraction
after a few seconds of doing nothing.

The symptom does depend on kernel version. 2.1.24 does not show it,
some old dev kernels did, then around 2.1.1xx it was ok again. Now,
with late 2.1.12x and 2.2.0preX, the symptom appears again.

tar itself is from tar-1.12-1b.ppc.rpm

I tried checking with strace what goes on, and here is what I found:

	[this is the end of the previous extracted file]
	[filedescriptor 3 is the archive (fbset-2.0-pre.tar from Geert)]
	
open("fbset-2.0-pre/etc/fb.modes.ATI", O_WRONLY|O_NONBLOCK|O_APPEND|O_CREAT|O_TR
UNC, 0644) = 4
write(4, "#\n#   Sample video modes\n# \n#"..., 2560) = 2560
read(3, "mode\n \n#\n#\t640x480, 100 Hz, "..., 10240) = 10240
write(4, "mode\n \n#\n#\t640x480, 100 Hz, "..., 10240) = 10240
read(3, " chars\t\t104 lines\n#\tActive T"..., 10240) = 10240
write(4, " chars\t\t104 lines\n#\tActive T"..., 9263) = 9263
close(4)                                = 0

	[the output file is written]

utime("fbset-2.0-pre/etc/fb.modes.ATI", [99/01/10-17:05:18, 98/07/08-00:08:01]) 
= 0
chmod("fbset-2.0-pre/etc/fb.modes.ATI", 0640) = 0

	[modification time and mode are set]

open("/etc/passwd", O_RDONLY)           = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=654, ...}) = 0
mmap(0x7ffff1c8, 0, PROT_NONE, 0x4 /* MAP_??? */|MAP_FIXED|MAP_ANONYMOUS|0x18606
40, 25560692, 0x1860000) = 0x30012000
read(4, "root:DYCjOUK.G.u.Y:0:0:root:/roo"..., 4096) = 654
read(4, "", 4096)                       = 0
close(4)                                = 0

	[not sure what it does with /etc/passwd here...]
	[now comes the weird part]

munmap(0x30012000, 4096)                = 0
gettimeofday({915984318, 325776}, NULL) = 0
getpid()                                = 282
socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 4

	[why is tar opening a socket now?]
	[anyway, port 888 is not permitted (not root)]

bind(4, {sin_family=AF_INET, sin_port=htons(888), sin_addr=inet_addr("0.0.0.0")}
, 16) = -1 EACCES (Permission denied)
ioctl(4, 0x8004667e, 0x7ffff350)        = 0
sendto(4, "6\23564\0\0\0\0\0\0\0\2\0\1\206\240"..., 56, 0, {sin_family=AF_INET, 
sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}, 16) = 56

	[hmm, sending to port 111? portmapper, no?]
	[this will not work; I don't have portmapper
	 started]

select(1024, [4], NULL, NULL, {5, 0})   = 0 (Timeout)

	[this is where the 'hang' occurs (5 seconds timeout, right?)]
	[seems to me tar is waiting for a response on fd 4]

sendto(4, "6\23564\0\0\0\0\0\0\0\2\0\1\206\240"..., 56, 0, {sin_family=AF_INET, 
sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}, 16) = 56

	[send again..]

select(1024, [4], NULL, NULL, {0, 0})   = 1 (in [4], left {0, 0})

	[ah, now fd 4 is available for reading???]
	[ why not the first time?]

recvfrom(4, 0x1861110, 400, 0, 0x7ffff2b8, 0x7ffff31c) = -1 ECONNREFUSED (Connec
tion refused)

	[sure, portmapper doesn't run.]

close(4)                                = 0
------------------------------------------------

I don't have the slightest idea why tar is trying to talk to
portmapper.

Concerning the timeout, it doesn't occur on every attempt to contact
portmapper. tar does this for every file in the archive, but only a few
of them (3 out of some 20 attempts) show the timeout.

Could this be a problem in the networking code of the kernel?

Am I the only one seing this?

Any other thoughts?

For the record, I tried with portmapper started; 56 bytes are send to
portmapper; who answers with 28 bytes. That's all that is talked
between the two.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
9, Montee St. Crepin           |    Ask Questions.  Make Mistakes.
L-1365 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
