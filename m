Message-Id: <200004122218.AAA07965@denx.local.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Apr 2000 13:10:02 CDT."
             <38F4BBFA.B3CE8273@execpc.com>
Date: Thu, 13 Apr 2000 00:18:35 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <38F4BBFA.B3CE8273@execpc.com> Joseph Garcia wrote:
>
> Any out-going FTP transfer maxes around 100K/s, and has potential to corrupt.
> NFS, atalk, etc seem to be ok.  Incoming transfers also seem to be ok.  By
> outgoing, I do mean out going.  Whether its with a server (wu or pro), or a
> client, if the file originates from my powerbook, it has this common problem.

This is exactly what I am seeing.

> During the time of transfer, the collision light on the hub blares.  I have
> tried this with a normal hub and a switch.  As far as I can tell, this would
> mean it is colliding with itself.  How else could a switched hub get collisions
> this prevalent?

Same for me. And another observation:  the  collision  count  of  the
Ethernet interface n the Mac stays at "2" (yes, two) all the time.

> ms.  I tried switching it back, but there was no change.  so its not that.
> Anything else that could be causing it?  I don't remember this problem with
> earlier 2.2 kernels.  Anyone confirm this?  2.1.x maybe?

I think I had LinuxPPC R4 without this problem. Maybe I will dig out
the old CD-ROMs.

> I severly doubt it is a pure TCP problem, because ftp using the lo device
> regards high return.  The only possible cause is the BMAC driver IMO.  But how
> would it only effect FTP outgoing?  I've heard that FTP uses raw bandwidth, so
> does that mean it uses some low level handshaking that nothing else uses, and
> depends on the file's host?   So where do FTP-out and BMAC collide in such a way
> that it doesnt affect lo, nor incoming files?

I'm trying to figure out what triggers the  problem,  and  what  gets
corrupted. First, I seem to have no problems (in terms of corruption;
the  slow  speed  is  always there) when the PB ist mostly idle, just
doing FTP'ing an existing file. However, when  I'm  running  a  "gtar
-zcf  -  | rsh somewhere_else "cat >foo.gz" I can be pretty sure that
"foo.gz" gets corrupted.

I also get corruptions when I'm running a "ls -lR  /"  in  the  back-
ground.

==> It seems that a lot of disk activity raises  the  probability  of
    the corruption.

I've FTP'ed a few big files; here is an example of what happens:  "0"
was  transferred  OK  while  the  disks  were  idle; "1" and "2" were
transferred with a "ls -lR /" running, and got corrupted:

-> ls -l 0 1 2
-rw-r--r--   1 wd       users    48867469 Apr 13 00:02 0
-rw-r--r--   1 wd       users    48867469 Apr 12 23:39 1
-rw-r--r--   1 wd       users    48867469 Apr 12 23:56 2
-> gzip -vt 0 ; gzip -vt 1 ; gzip -vt 2
0:                       OK
1:
gzip: 1: invalid compressed data--crc error
2:
gzip: 2: invalid compressed data--format violated


Comparing the files gives:

-> cmp -l 0 1
44003307 201  51
44003309 117 361
44003311  51 205
44003313 361  61
44003315 205 202
44003317  61 221
44003319 202 170
44003321 221 217
44003323 170  64
44003325 217 312
44003327  64 271
44003329 312  12
44003331 271 341
44003333  12 320
44003335 341 345
44003337 320  47
...

-> cmp -l 0 2
6572503  57 315
6572505 310  22
6572507 315 165
6572509  22 141
6572511 165  60
6572513 141  36
6572515  60 112
6572517  36 320
6572519 112 243
6572521 320 303
6572523 243 250
6572525 303  26
6572527 250  32
6572529  26 142
6572531  32 150
6572533 142 233
...


This shows an interesting  problem:  only  the  ODD  data  bytes  get
corrupted,  being "shifted down" with an offset of 4 (two "odd bytes"
are missing); but the total size of the files is OK again...

-> xd 0 +0x6449d0 | head
  6449d0  c5fee1f0 a7392f93  c80dcdda 127575c2  |     9/      uu |
First corruption here -^^    ^^  ^^   ^^  ^^
  6449e0  612030d7 1e5e4a2f  d02aa352 c3f3a887  |a 0  ^J/ * R    |
  6449f0  16361ace 623768e1  9b2724f4 299b8530  | 6  b7h  '$ )  0|
  644a00  024d53ab b7e6a185  86cc7448 3741c0dc  | MS       tH7A  |
  644a10  cf49887c 8470e8e5  01bd1b65 d9dd1b44  | I | p     e   D|
  644a20  a1bf7924 42154515  4d515c74 34593432  |  y$B E MQ\t4Y42|
  644a30  f416deb6 1885ea08  f3d53604 85847255  |          6   rU|
  644a40  4f061242 e401e067  458894e4 21d01233  |O  B   gE   !  3|
  644a50  6fb929eb f2f98b1f  eb3df035 af1805e0  |o )      = 5    |
  644a60  bc0702a6 5f812a08  09d103c0 a4bae645  |    _ *        E|
  ...
-> xd 2 +0x6449d0 | head
  6449d0  c5fee1f0 a739cd93  120d75da 617530c2  |     9    u au0 |
First corruption here -^^    ^^  ^^   ^^  ^^
  6449e0  1e204ad7 d05ea32f  c32aa852 16f31a87  |  J  ^ / * R    |
  6449f0  623668ce 9b3724e1  292785f4 029b5330  |b6h  7$ )'    S0|
  644a00  b74da1ab 86e67485  37ccc048 cf4188dc  | M    t 7  H A  |
  644a10  8449e87c 01701be5  d9bd1b65 a1dd7944  | I | p     e  yD|
  644a20  42bf4524 4d155c15  34513474 f459de32  |B E$M \ 4Q4t Y 2|
  644a30  1816eab6 f3853608  85d57204 4f841255  |      6   r O  U|
  644a40  e406e042 45019467  218812e4 6fd02933  |   BE  g!   o )3|
  644a50  f2b98beb ebf9f01f  af3d0535 bc1802e0  |         = 5    |
  644a60  5f072aa6 09810308  a4d1e6c0 ddbaec45  |_ *            E|
  ...

Does this trigger any ideas in anybody?

Wolfgang

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Harrison's Postulate:
	For every action, there is an equal and opposite criticism.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
