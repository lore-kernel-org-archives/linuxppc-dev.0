Message-Id: <200007042223.AAA09722@denx.local.net>
To: mark phillips <msss@ne.mediaone.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with HardHat/NFS root filesystems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Jul 2000 17:21:09 EDT."
             <39625545.370FE91F@ne.mediaone.net>
Date: Wed, 05 Jul 2000 00:23:13 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi MArk,

in message <39625545.370FE91F@ne.mediaone.net> you wrote:
>
> I have been able to run the mbxroot.min filesystem (both on NFS and as
> an initrd).  However, I am unable to run either mbxroot.full or the
> HardHat "target" filesystem
> (Both obviously under NFS due to their size).  I am convinced that my
> problem has something to do with the shared libraries (But I've been
> wrong before!).

I guess you are right here.

> In addition, I've noticed that if I run ldconfig on the mbxroot.min
> filesystem, it no longer boots.  Removing etc/ld.so.cache fixes the

Don't do this. If you feel you must, get a target running  over  NFS,
and run the native PPC binary on the target.

> problem.  I believe both the mbxroot-full filesystem and the HardHat
> "target" filesystem are untouched from their original versions.

Don't believe anything; reinstall from the archive /  RPMs;  for  the
HHL RPM's, you can also check by using the "rpm --verify" option.

> My host is an i386/RedHat 6.2 Can I run this ldconfig on a ppc
> filesystem, or do I need a cross-platform version? (command line:
> /sbin/ldconfig -r <target_dir> )

I recommend NOT doing it.

> Basically, the symptoms are that the kernel can't find an init.  I ran

HHL comes wityh at least 2 statically linked shells:  /bin/ash.static
and /bin/sash - use one of them as init process by passing the option
"init=/bin/ash.static" on the boot command line.

If this works, you have a native environment which  you  can  use  to
investigate further.

If this does not work, your problem has nothing  to  do  with  shared
libraries.

> tcpdump while booting, and everything looked pretty normal; lots of NFS
> queries (but not much or no actual data transfer).  Interestingly the
> trace ends with a bunch of queries to
> /opt/hardhat/devkit/ppc/8xx/target/opt.

Please pay attention to the fact that HHL has a strange  way  to  fix
the  absolute  path problem for their shared libraries; in the target
root    directory    there    must     be     a     symbolic     link
"/opt/hardhat/devkit/ppc/8xx/powerpc-linux" pointing to "/", i.e. you
should see something like this:

-> ls -l /opt/hardhat/devkit/ppc/8xx/target/opt/hardhat/devkit/ppc/8xx/powerpc-linux
lrwxrwxrwx   1 root     root            1 May 10 23:58 /opt/hardhat/devkit/ppc/8xx/target/opt/hardhat/devkit/ppc/8xx/powerpc-linux -> /

> I would greatly appreciate it if anyone has any solution to this
> problem, or even if someone could propose a debugging strategy for me?

See above - try a shell with static linkage as init process.

> I've tried both the HardHat CDK 1.0 and the newer Journeyman (CDK 1.1),
> both with the same results.

Probably the same problem?

> Thanks in advance,

You're welcome...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I know engineers. They love to change things.             - Dr. McCoy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
