Message-Id: <200012301127.eBUBRB728194@denx.local.net>
To: wangxuelong@0451.com
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBOOT Questions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 30 Dec 2000 14:06:30 +0800."
             <D0998769859369.13745@fmail1.hl.cninfo.net>
Date: Sat, 30 Dec 2000 12:27:11 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Micael,

in message <D0998769859369.13745@fmail1.hl.cninfo.net> you wrote:
>

> 1.I have already had a custom PBX board with a embedded CPU named
> MPC823, and a monitor has already been flashed into a EPROM on the

If you are using PPCBoot  (the  Open  source  firmware  for  embedded
PowerPC  systems)  on  your  board,  as  the  subject  suggests, such
questions  are  better  directed  to  the  PPCBoot  mailing  list  at
ppcboot-users@lists.sourceforge.net

> board. In this case, this embedded system can run the monitor
> normally. Now I get a kernel image corresponding to my PBX board
> with the format of SRECORD. How can I use the monitor command
> "netloads" to download the kernel image from a TFTP server to the
> embedded system through a LAN network?

On the other hand, PPCBoot does not have  a  "netloads"  command;  so
probably you are using any other firware?

With PPCBoot, S-Record files can be downloaded over the  serial  port
using  the  "loads" command. You can load binary images over ethernet
using the "tftp", "rarp" or "bootp"  commands;  or  can  load  binary
images  over  the  serial port with the "loadb" command (using kermit
binary protocol).

You can convert a S-record file into a binary image with the help  of
the  "objcopy"  command  which  is  part of the binutils package (and
probably also part of your CDK).

> 2.I think, the TFTP server is also a BOOTP server, and it should
> provide NFS function. How can I set this server to play such a
> important role.

Well, BOOTP is just used to retrieve configuration information;  TFTP
is  then  used to load an image. I don't know of any embedded PowerPC
firmware that supports NFS, so you probably mean mounting  the  Linux
root  filesystem  over  NFS  - but that's a Linux kernel issue, not a
problem of the firmware.

Hope that helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
For every problem there is one solution which is  simple,  neat,  and
wrong.                                                - H. L. Mencken

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
