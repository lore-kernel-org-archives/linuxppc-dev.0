Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F146FDDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jul 2007 20:23:04 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IEMyJ-0001Pl-Bu
	for linuxppc-embedded@ozlabs.org; Fri, 27 Jul 2007 03:22:59 -0700
Message-ID: <11826448.post@talk.nabble.com>
Date: Fri, 27 Jul 2007 03:22:59 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: creation of jffs2 rootfile system..
In-Reply-To: <20070727104023.78048ea4.fvoegel@carangul.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <11823840.post@talk.nabble.com>
	<20070727104023.78048ea4.fvoegel@carangul.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I m creating jffs2 root file system using devrocket,

this is the bootlog i m getting....

VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 108k init
readlink: /etc/mtab: No such file or directory
0
readlink: /etc/mtab: No such file or directory
Mounting local filesystems: mount nothing was mounted
Cleaning: /tmp BusyBox v1.01 (2005.12.18-04:27+0000) multi-call binary

Usage: find [PATH...] [EXPRESSION]

Search for files in a directory hierarchy.  The default PATH is
the current directory; default EXPRESSION is '-print'

EXPRESSION may consist of:
        -follow         Dereference symbolic links.
        -name PATTERN   File name (leading directories removed) matches
PATTERN.
        -print          Print (default and assumed).

        -type X         Filetype matches X (where X is one of:
f,d,l,b,c,...)
        -perm PERMS     Permissions match any of (+NNN); all of (-NNN);
                        or exactly (NNN)
        -mtime TIME     Modified time is greater than (+N); less than (-N);
                        or exactly (N) days

/var/lock cd: 77: can't cd to /var/lock
/var/run BusyBox v1.01 (2005.12.18-04:27+0000) multi-call binary

Usage: find [PATH...] [EXPRESSION]

Search for files in a directory hierarchy.  The default PATH is
the current directory; default EXPRESSION is '-print'

EXPRESSION may consist of:
        -follow         Dereference symbolic links.
        -name PATTERN   File name (leading directories removed) matches
PATTERN.
        -print          Print (default and assumed).

        -type X         Filetype matches X (where X is one of:
f,d,l,b,c,...)
        -perm PERMS     Permissions match any of (+NNN); all of (-NNN);
                        or exactly (NNN)
        -mtime TIME     Modified time is greater than (+N); less than (-N);
                        or exactly (N) days

grep: /etc/group: No such file or directory
done.
Setting pseudo-terminal access permissions...chown: unknown group name: tty
done.
Updating /etc/motd...sed: /etc/motd: No such file or directory
done.
/etc/rc.d/rcS.d/S55bootmisc.sh: 119: cannot create /var/log/dmesg: Directory
nonexistent
: done.

Please press Enter to activate this console.
/#

now ps command is working properly.

why i m not getting login..?


Florian A. Voegel wrote:
> 
> 
> Hi Nethra,
> 
> what does your inittab and your startup files look like? It looks like
> 
> - your inittab does not start a getty but rather a shell, thus no login
> - your /proc isn't mounted, and it's needed for ps to work properly
> 
> 
> Greets,
> 
> Florian Voegel
> Carangul.Tech
> 
> On Thu, 26 Jul 2007 23:41:32 -0700 (PDT)
> Nethra <nethra_gmit@yahoo.co.in> wrote:
> 
>> 
>> when boot the board with jffs2 rootfile system i m getting output like
>> this,
>> 
>> TCP: Hash tables configured (established 4096 bind 8192)
>> IPv4 over IPv4 tunneling driver
>> NET: Registered protocol family 1
>> NET: Registered protocol family 10
>> IPv6 over IPv4 tunneling driver
>> NET: Registered protocol family 17
>> Disabled Privacy Extensions on device c02527a0(lo)
>> IP-Config: Incomplete network configuration information.
>> Empty flash at 0x0000ffa0 ends at 0x00010000
>> Empty flash at 0x0002ffec ends at 0x00030000
>> Empty flash at 0x0004ffe8 ends at 0x00050000
>> Empty flash at 0x0006ffc8 ends at 0x00070000
>> Empty flash at 0x0008fffc ends at 0x00090000
>> Empty flash at 0x000afffc ends at 0x000b0000
>> Empty flash at 0x000cfffc ends at 0x000d0000
>> Empty flash at 0x000efffc ends at 0x000f0000
>> Empty flash at 0x0010fffc ends at 0x00110000
>> Empty flash at 0x0012fffc ends at 0x00130000
>> Empty flash at 0x0014fffc ends at 0x00150000
>> Empty flash at 0x0016fffc ends at 0x00170000
>> Empty flash at 0x0018fffc ends at 0x00190000
>> Empty flash at 0x001cfffc ends at 0x001d0000
>> Empty flash at 0x001efffc ends at 0x001f0000
>> Empty flash at 0x0020fffc ends at 0x00210000
>> Empty flash at 0x0022fffc ends at 0x00230000
>> Empty flash at 0x0024fffc ends at 0x00250000
>> Empty flash at 0x0026fffc ends at 0x00270000
>> Empty flash at 0x002afffc ends at 0x002b0000
>> Empty flash at 0x002cfffc ends at 0x002d0000
>> VFS: Mounted root (jffs2 filesystem).
>> Freeing unused kernel memory: 108k init
>> 
>> Please press Enter to activate this console.
>> / #
>> / #
>> / #
>> 
>> login prompt itself is not coming and
>>  
>> ps command is not working....
>> # ps
>>   PID  Uid     VmSize Stat Command
>> #
>> 
>> what is the problem..?
>> 
>> waiting for early response,
>> Nethra
>> 
>> -- 
>> View this message in context:
>> http://www.nabble.com/creation-of-jffs2-rootfile-system..-tf4155759.html#a11823840
>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>> 
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/creation-of-jffs2-rootfile-system..-tf4155759.html#a11826448
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
