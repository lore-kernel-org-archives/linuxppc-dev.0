Return-Path: <ramkumarj2000@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 1A7E5DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Dec 2007 20:20:12 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2597343wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Dec 2007 01:20:11 -0800 (PST)
Message-ID: <4f8c3030712240120m30d68b37g8b5f099294c6d769@mail.gmail.com>
Date: Mon, 24 Dec 2007 17:20:10 +0800
From: "ramkumarj Ramkumar" <ramkumarj2000@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: Loop at starting pid 164, tty '': '/sbin/getty'
In-Reply-To: <20071224040915.GA20380@lixom.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7489_25077477.1198488010847"
References: <4f8c3030712220051if731af9g350af9d45a75c244@mail.gmail.com>
	<20071224040915.GA20380@lixom.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_7489_25077477.1198488010847
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Olof,

Thanks a lot for replying to the query posted. It works now. Initially I had
created the device file tts/0 instead of ttyS0 and still faced the same
issue. Now I have the ttyS0 created and created tty0 and also modified the
inittab as below,

--------------------------------------------------------------------------
Original Config ( Not Working )
--------------------------------------------------------------------------
::sysinit:/etc/init.d/rcS
#::askfirst:-/bin/sh
::ctrlaltdel:/sbin/reboot
::shutdown:/sbin/swapoff -a
::shutdown:/bin/umount -a -r
::restart:/sbin/init
::respawn:/sbin/getty 38400 tts/0

Created the following devices in /dev through
mknod -m 660 console c 5 1
mknod -m 660 xsa b 254 0
mknod -m 660 xsa1 b 254 1
mknod -m 660 xsa2 b 254 2
mknod -m 660 xsa3 b 254 3
mkdir tts
cd tts
mknod -m 660 0 b 4 64
cd ..
mknod -m 660 null c 1 3

-------------------------------------------------------------------------
Working Config
-------------------------------------------------------------------------
# cat inittab
::sysinit:/etc/init.d/rcS
#::askfirst:-/bin/sh
::ctrlaltdel:/sbin/reboot
::shutdown:/sbin/swapoff -a
::shutdown:/bin/umount -a -r
::restart:/sbin/init
::respawn:/sbin/getty -L ttyS0 38400 vt100

Created the following devices in /dev
# ls -al
drwxr-xr-x    5 root     root         1024 Jan  1 00:00 .
drwxr-xr-x   17 root     root         1024 Dec 21  2007 ..
crw--w--w-    1 root     root       5,   1 Jan  1 00:00 console
srw-rw-rw-    1 root     root            0 Jan  1 00:00 log
crw-rw----    1 root     root       1,   3 Dec 21  2007 null
drwxr-xr-x    2 root     root         1024 Dec 21  2007 pts
drwxr-xr-x    2 root     root         1024 Dec 21  2007 shm
drwxr-xr-x    2 root     root         1024 Dec 21  2007 tts
crw--w--w-    1 root     root       4,   0 Dec 24  2007 tty0
crw-------    1 root     root       4,  64 Jan  1 00:12 ttyS0
brw-rw----    1 root     root     254,   0 Dec 21  2007 xsa
brw-rw----    1 root     root     254,   1 Dec 21  2007 xsa1
brw-rw----    1 root     root     254,   2 Dec 21  2007 xsa2
brw-rw----    1 root     root     254,   3 Dec 21  2007 xsa3
#

Now I m able to see the login prompt :) .

I would be very grateful if the following questions could be addressed,

1. Does the inittab format changed for Linux 2.6. The old one was from
mkrootfs (which I think is pretty old). I could see some changes in the
"respawn" line.

2. Is it required to run the tty0 along with ttyS0. Is this is mandatory. I
assumed all these days console and ttyS0 should be sufficient.

3. A very basic question : What is the clear difference between ttyS0 ( UART
Driver ), console and tty0. To my understanding, ttyS0 is the first port
UART 's driver (for 16550/8250) which deals with the hardware as such by
writing and reading the registers. tty0 is virtual console, something to do
with telnet sessions. But I dont clearly understand why console and tty0 are
both required or not. Please correct me if my understanding is wrong.
Merry Christmas.

Thanks and Regards,
Ramkumar



On Dec 24, 2007 12:09 PM, Olof Johansson <olof@lixom.net> wrote:

> Hi,
>
> On Sat, Dec 22, 2007 at 04:51:16PM +0800, ramkumarj Ramkumar wrote:
>
> > I m trying to run Linux 2.6 ( From Grant) on ML-403. I used the
> > busybox-1.7.2. During booting, I found the following logs and it keeps
> > trying to respawn the getty.It keeps looping and I never see the login
> > prompt.  Am I missing something.
> >
> > process '/sbin/getty 38400 tts/0' (pid 163) exited. Scheduling it for
> > restart.
>
> Do you have a /dev/ttys/0? First serial port is normally /dev/ttyS0.
>
>
> -Olof
>

------=_Part_7489_25077477.1198488010847
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&nbsp;</div>
<div>Hi Olof,<br><br>Thanks a lot for replying to the query posted. It works now. Initially I had created the device file tts/0 instead of ttyS0 and still faced the same issue. Now I have the ttyS0 created and created tty0&nbsp;and also modified the inittab as below,
</div>
<div>&nbsp;</div>
<div>--------------------------------------------------------------------------<br>Original Config ( Not Working )<br>--------------------------------------------------------------------------</div>
<div>::sysinit:/etc/init.d/rcS<br>#::askfirst:-/bin/sh<br>::ctrlaltdel:/sbin/reboot<br>::shutdown:/sbin/swapoff -a<br>::shutdown:/bin/umount -a -r<br>::restart:/sbin/init<br>::respawn:/sbin/getty 38400 tts/0</div>
<div><br>Created the following devices in /dev through</div>
<div>mknod -m 660 console c 5 1<br>mknod -m 660 xsa b 254 0<br>mknod -m 660 xsa1 b 254 1<br>mknod -m 660 xsa2 b 254 2<br>mknod -m 660 xsa3 b 254 3<br>mkdir tts<br>cd tts<br>mknod -m 660 0 b 4 64<br>cd ..<br>mknod -m 660 null c 1 3
</div>
<div><br>-------------------------------------------------------------------------<br>Working Config<br>-------------------------------------------------------------------------</div>
<div># cat inittab<br>::sysinit:/etc/init.d/rcS<br>#::askfirst:-/bin/sh<br>::ctrlaltdel:/sbin/reboot<br>::shutdown:/sbin/swapoff -a<br>::shutdown:/bin/umount -a -r<br>::restart:/sbin/init<br>::respawn:/sbin/getty -L ttyS0 38400 vt100
</div>
<div><br>Created the following devices in /dev</div>
<div># ls -al<br>drwxr-xr-x&nbsp;&nbsp;&nbsp; 5 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024 Jan&nbsp; 1 00:00 .<br>drwxr-xr-x&nbsp;&nbsp; 17 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024 Dec 21&nbsp; 2007 ..<br>crw--w--w-&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5,&nbsp;&nbsp; 1 Jan&nbsp; 1 00:00 console<br>srw-rw-rw-&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 Jan&nbsp; 1 00:00 log
<br>crw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1,&nbsp;&nbsp; 3 Dec 21&nbsp; 2007 null<br>drwxr-xr-x&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024 Dec 21&nbsp; 2007 pts<br>drwxr-xr-x&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024 Dec 21&nbsp; 2007 shm<br>drwxr-xr-x&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024 Dec 21&nbsp; 2007 tts
<br>crw--w--w-&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4,&nbsp;&nbsp; 0 Dec 24&nbsp; 2007 tty0<br>crw-------&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4,&nbsp; 64 Jan&nbsp; 1 00:12 ttyS0<br>brw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; 254,&nbsp;&nbsp; 0 Dec 21&nbsp; 2007 xsa<br>brw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; 254,&nbsp;&nbsp; 1 Dec 21&nbsp; 2007 xsa1
<br>brw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; 254,&nbsp;&nbsp; 2 Dec 21&nbsp; 2007 xsa2<br>brw-rw----&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; 254,&nbsp;&nbsp; 3 Dec 21&nbsp; 2007 xsa3<br>#</div>
<div>&nbsp;</div>
<div>Now I m able to see the login prompt :) . </div>
<div>&nbsp;</div>
<div>I would be very grateful if the following questions could be addressed,</div>
<div>&nbsp;</div>
<div>1. Does the inittab format changed for Linux 2.6. The old one was from mkrootfs (which I think is pretty old). I could see some changes in the &quot;respawn&quot; line.</div>
<div>&nbsp;</div>
<div>2. Is it required to run the tty0 along with ttyS0. Is this is mandatory. I assumed all these days console and ttyS0 should be sufficient.</div>
<div>&nbsp;</div>
<div>3. A very basic question : What is the clear difference between ttyS0 ( UART Driver ), console and tty0. To my understanding, ttyS0 is the first port UART &#39;s driver (for 16550/8250) which deals with the hardware as such by writing and reading the registers. tty0 is virtual console, something to do with telnet sessions. But I dont clearly understand why console and tty0 are both required or not. Please correct me if my understanding is wrong.&nbsp;
<br></div>
<div>Merry Christmas.</div>
<div><br>Thanks and Regards,</div>
<div>Ramkumar</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div class="gmail_quote">On Dec 24, 2007 12:09 PM, Olof Johansson &lt;<a href="mailto:olof@lixom.net" target="_blank">olof@lixom.net</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">Hi,<br>
<div><br>On Sat, Dec 22, 2007 at 04:51:16PM +0800, ramkumarj Ramkumar wrote:<br><br>&gt; I m trying to run Linux 2.6 ( From Grant) on ML-403. I used the<br>&gt; busybox-1.7.2. During booting, I found the following logs and it keeps 
<br>&gt; trying to respawn the getty.It keeps looping and I never see the login<br>&gt; prompt. &nbsp;Am I missing something.<br>&gt;<br></div>
<div>&gt; process &#39;/sbin/getty 38400 tts/0&#39; (pid 163) exited. Scheduling it for <br>&gt; restart.<br><br></div>Do you have a /dev/ttys/0? First serial port is normally /dev/ttyS0.<br><font color="#888888"><br><br>
-Olof<br></font></blockquote></div><br>

------=_Part_7489_25077477.1198488010847--
