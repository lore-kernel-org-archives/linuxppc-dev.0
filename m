Message-ID: <385774B8.3405494B@iname.com>
Date: Wed, 15 Dec 1999 11:00:08 +0000
From: Jim Chapman <jim.chapman@iname.com>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:

> kernel boot stops at 

> Linux/PPC load:
> Uncompressing Linux...done.
> Now booting the kernel
> 

I have seen this before when I made a silly typo in the memory init
code. In my case, immr wasn't being setup properly such that it was left
with the board's default value (0x02200000). This value isn't high
enough for linux. Once I changed it, the kernel booted fine. Is your
immr value coming from a board configuration register or bootrom? 

Something changed between 2.2.5 and 2.2.13 to do with the virtual
address map. While 2.2.5 seemed to be able to limp along in kernel mode
with immr=02200000, 2.2.13 doesn't seem to be able to. (When I was
switching from 2.2.5 to 2.2.13, I didn't notice my immr was the wrong
value. 2.2.13 would always hang exactly as you described, but 2.2.5
would crash more randomly (at the first TLB miss). Once I fixed the immr
value in the bootrom, both kernels booted fine.)

Also, you describe adding and removing debug code, but being left with a
kernel that didn't work as before. I've also had similar problems
occasionally, but they are always cured by doing a clean rebuild. Have
you tried that?

In a followup, Brendan Simon wrote:
> 
> I have made progress now that the caches are disabled.  I will leave
> them disabled for now until I have a full working system via NFS (unless
> someone advises me otherwise).

Make sure your 860 is a rev C part or higher. If it isn't, forget trying
to use the cache.

Your CPU is a regular 8xx, not a 'P' (performance) variant, right? The
latter has "optimized" cache hardware that isn't (yet?) supported by
linuxppc.

> 
> My system was getting stuck at the following piece of code.  I don't
> know was SASH is but it is defined at the top of the file.  I commented
> it out to see what would happen.  I also noticed that Magnus Damm's ADS
> modifications also has the "#define SASH 1" commented out.  What is the
> purpose of SASH and the implication of undefining it ?

sash is a "System Admin Shell". It is a minimal /bin/sh with builtin
cut-down versions of several basic command-line utils such as ls, cd,
mount, ed, cat... It can be useful to work on systems which won't boot
from init scripts properly such that you don't get a login prompt. In
the embedded world, sash can be useful in the early stages of getting a
board running linux. It is always linked statically so you don't even
need a working libc. sash sources are available from the usual ftp
sites.

If you have SASH #define'd but you have no /bin/sash, the kernel won't
boot.

Perhaps a kernel argument could be used rather than conditional
compilation to control whether sash is used?

> 
> #ifdef SASH
>     {
>         int i, pid;
> 
>         pid = kernel_thread(do_linux_sash, "sash", SIGCHLD);
>         if (pid > 0)
>             while (pid != wait(&i));
>     }
> #else
>     ....
> #endif
> 
> After undefining it, the kernel got further.  It gets to the point where
> it tries to run /bin/sh and then just sits there.  Here is the last part
> of the console ouput.  Any ideas where to go from here.

Do you have a /bin/sh on your initrd? You'll need the shared libraries
too. 

Also, try running your NFS server in the foreground in a debug mode if
it isn't being used by other hosts. This will display exactly what files
are being accessed. You should see lots of directories, shared libraries
etc being read. I use

# rpc.nfsd -F -d call

but obviously kill any running nfsd first.

> 
> Brendan.
> 
> eth0: CPM ENET Version 0.2, 00:d0:1f:11:22:33
> IP-Config: Guessing netmask 255.255.255.0
> Looking up port of RPC 100003/2 on 203.21.127.160
> Looking up port of RPC 100005/1 on 203.21.127.160
> VFS: Mounted root (NFS filesystem) readonly.
> BJS: INITRD: 1
> Freeing unused kernel memory: 32k init
> BJS: opening console
> BJS: console opended
> BJS: trying /sbin/init
> BJS: trying /etc/init
> BJS: trying /bin/init
> BJS: trying /bin/sh

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
