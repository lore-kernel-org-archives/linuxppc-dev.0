From: clark@esteem.com
Message-Id: <1.5.4.32.20001010000239.006b54d8@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 09 Oct 2000 17:02:39 -0700
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Re: Ethernet Trouble 
Cc: ppcboot-users@lists.sourceforge.net, linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 02:31 AM 10/7/00 +0200, you wrote:
>In message <1.5.4.32.20001006222031.006b6ab0@pop.esteem.com> you wrote:
>>
>> Looking up port of RPC 100003/2 on 100.100.100.11
>> Looking up port of RPC 100005/1 on 100.100.100.11
>> VFS: Mounted root (NFS filesystem).
>> Freeing unused kernel memory: 40k init
>>
>> It hangs here.
>>
>> It seems like it is not running init and/or loading inittab.
>>
>> Whats up with this?????
>
>You're running vwith Root over NFS, so you can use  a  sniffer  (like
>ethereal)  to  check  which  files  it's  trying to access. Check all
>failing accesses...
>
>Either it can't find init, or it's a shared library problem, or  your
>console device is missing, or ...

        I did some tracing with ethereal. The first thing it does after
mounting the NFS drive look up the dev directory then the console. Next it
looks in the sbin directory (realy just a link to the bin directory) and
loads the init program. Finally it goes to the lib directory an loads
ld.so.1 (which is a link to ld-2.1.3.so). After this I can't decipher the
binary messages in the packets. Then it quits.

        Right now I think that it can't talk to the console or init uses a
function in ld.so.1 to spit a message to the console and is failing to load
the library correctly. Does PPCBOOT tell the kernel to use its console or do
I need to do that somehow? I have tried to stick "console=/dev/ttyS00" in
the bootargs but then I don't get any messages after the uncompresssing
kernel message.

        I am using Hardhat version 1.2 for my development and using thier
target directory for my NFS.

>You may install a STATICALLY linked shell (like the standalone  shell
>"sash" or the simple shell "ash") and pass the boot arguments
>
>	... init=/bin/sash
>or	... init=/bin/ash
>
>This will make the situation less complex...

        Tried this. It looked up the /dev/console just as before then It
loaded sash but, I still didn't get anything on the console screen.


>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Any technology distinguishable from magic is insufficiently advanced.
>

        Sorry to be such a pain in your side lately.

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
