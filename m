To: Prakash kanthi <pkanthi@yahoo.com>
Cc: Frederic Soulier <soulier@aztec-radiomedia.com>,
	"PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ramdisk details; execve("/bin/sh") output 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Jan 2003 20:49:11 PST."
             <20030116044911.1234.qmail@web41201.mail.yahoo.com>
Date: Thu, 16 Jan 2003 09:06:53 +0100
Message-Id: <20030116080659.073A8C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030116044911.1234.qmail@web41201.mail.yahoo.com> you wrote:
>
> 1. How can i see the contents of a ramdisk? I
> downloaded one from denx and i want to see what is in
> there?

1. [in case of PPCBoot image:] strip header
2. Uncompress
3. Mount using the loopback device

For example:

# dd if=simple-ramdisk.PPCBoot of=simple-ramdisk.gz bs=64 skip=1
8874+1 records in
8874+1 records out
# gunzip simple-ramdisk.gz
# mount -o loop simple-ramdisk /mnt
# ls -lR /mnt
/mnt:
total 17
drwxr-xr-x    2 root     root         1024 Jun  4  1999 bin
drwxr-xr-x    2 root     root         1024 Oct  2  2000 dev
drwxr-xr-x    2 root     root         1024 Jun  4  1999 etc
drwxr-xr-x    2 root     root         1024 Jun  4  1999 lib
-rwxr-xr-x    1 root     root          136 Jan 11  1999 linuxrc
drwxr-xr-x    2 root     root        12288 Jun  4  1999 lost+found

/mnt/bin:
total 463
-rwxr-xr-x    1 root     root        37480 Mar  1  1998 date
-rwxr-xr-x    1 root     root        54584 Sep  8  1998 ls
-rwxr-xr-x    1 root     root       375704 Sep  8  1998 sh

/mnt/dev:
total 0
crw-r--r--    1 root     root       5,   1 Mar 22  2000 console
crw-rw-rw-    1 root     root       5,   0 Jun  4  1999 tty
crw-rw-rw-    1 root     root       4,  64 Jun  4  1999 ttyS0

/mnt/etc:
total 0
-rw-r--r--    1 root     root            0 Jan 11  1999 mtab

/mnt/lib:
total 1042
-rwxr-xr-x    1 root     root        83138 Apr 24  2001 ld.so.1
-rwxr-xr-x    1 root     root       825404 Sep  8  1998 libc-1.99.so
-rw-r--r--    1 root     root        53356 Jan 11  1999 libcrypt.so.1
lrwxrwxrwx    1 root     root           12 Jun  4  1999 libc.so.6 -> libc-1.99.so
-rw-r--r--    1 root     root        61586 Jan 11  1999 libproc.so.1.2.6
lrwxrwxrwx    1 root     root           19 Jun  4  1999 libtermcap.so.2 -> libtermcap.so.2.0.8
-rwxr-xr-x    1 root     root        30152 Sep  8  1998 libtermcap.so.2.0.8

/mnt/lost+found:
total 0
#


> 2. In ${LINUX_ROOT}/init/main.c -> init(), after
> prepare_namespace (which basically does the inintrd
> mount), open syscall on '/dev/console' fails. But
> still control goes further and executes
> 'execve("/bin/sh")'. My question is where does the
> output of /bin/sh execution goes? Not to my dumb
> terminal? I see nothing. Infact my dumb terminal just
> stops there. No kernel panic. Any clues?

Solve problems sequentially. Why does open '/dev/console' fail ?

> Note: In my case i do not have enough infrastructure
> to have the  standard NS16550 is working. So i have to
> port some other driver as my serial driver. ANything
> related to this?

There may be some other problems. Sorry for  being  vague  -  I'm  as
precise  as you are with your statement about "some other driver". If
you want helpful answers you must provide all the little details.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Probably the best operating system in the world  is  the  [operating
system] made for the PDP-11 by Bell Laboratories."
                                           - Ted Nelson, October 1977

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
