Message-ID: <385725A3.A1C110DF@ctam.com.au>
Date: Wed, 15 Dec 1999 16:22:44 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I have made progress now that the caches are disabled.  I will leave
them disabled for now until I have a full working system via NFS (unless
someone advises me otherwise).

My system was getting stuck at the following piece of code.  I don't
know was SASH is but it is defined at the top of the file.  I commented
it out to see what would happen.  I also noticed that Magnus Damm's ADS
modifications also has the "#define SASH 1" commented out.  What is the
purpose of SASH and the implication of undefining it ?

#ifdef SASH
    {
        int i, pid;

        pid = kernel_thread(do_linux_sash, "sash", SIGCHLD);
        if (pid > 0)
            while (pid != wait(&i));
    }
#else
    ....
#endif


After undefining it, the kernel got further.  It gets to the point where
it tries to run /bin/sh and then just sits there.  Here is the last part
of the console ouput.  Any ideas where to go from here.

Brendan.

eth0: CPM ENET Version 0.2, 00:d0:1f:11:22:33
IP-Config: Guessing netmask 255.255.255.0
Looking up port of RPC 100003/2 on 203.21.127.160
Looking up port of RPC 100005/1 on 203.21.127.160
VFS: Mounted root (NFS filesystem) readonly.
BJS: INITRD: 1
Freeing unused kernel memory: 32k init
BJS: opening console
BJS: console opended
BJS: trying /sbin/init
BJS: trying /etc/init
BJS: trying /bin/init
BJS: trying /bin/sh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
