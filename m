Message-ID: <388BF52B.213CCD61@huawei.com.cn>
Date: Mon, 24 Jan 2000 14:46:03 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au
CC: Grant Carter <gcarter@eng.uct.ac.za>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile dynamic apps for mpc860 on ix86
References: <386C150F.22B1A3D0@huawei.com.cn> <38704D0B.94438516@huawei.com.cn> <386AFFC5.E0134DB8@ctam.com.au> <38708C86.2CD58E66@huawei.com.cn> <387142DF.7A3025D0@ctam.com.au> <38715DAE.B6CBC772@huawei.com.cn> <3871572F.FA4E7842@ctam.com.au> <38717C52.ECF1AFFD@huawei.com.cn> <3871953B.345DDA23@ctam.com.au> <38754F28.B6B4CE70@huawei.com.cn> <38754419.20D95C5A@ctam.com.au> <3876A6E5.3488738B@huawei.com.cn> <3876C6FD.794BD1BF@ctam.com.au> <387A87DF.4ED23CA6@huawei.com.cn> <387A81F3.702B29A2@ctam.com.au> <387C4D8D.9C058F1C@huawei.com.cn> <387D3212.A4E9904F@ctam.com.au> <387DAFAF.DB0096C7@huawei.com.cn> <387E460F.B007CE56@ctam.com.au> <387E7F82.99AF83CE@huawei.com.cn> <387E7AF5.A92A6122@ctam.com.au> <387E9927.48689C08@huawei.com.cn> <387EBEB9.B69B1680@ctam.com.au> <387EDEF5.DBD612FA@huawei.com.cn> <3881266E.828DAED5@ctam.com.au> <388ABF55.5BD3A031@eng.uct.ac.za> <388B9C86.8970590A@ctam.com.au> <388BA902.B41A2E11@huawei.com.cn> <388BC036.7BC21AE1@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Brendan J Simon wrote:

> dony wrote:
>
> > In fact, I have posted ALL howtos (not brief howtos)  that I have done when compiling the cross-compile environment. And
> > these are all stealed from CrossGcc FAQ. See http://www.objsw.com.
> > I do these successfully on SuSE linux (European version), kernel 2.2.13. But the same steps on Redhat linux cannot work
> > and some errors occur. I don't know why and are checking these.
> > Since Redhat linux is widely used by most linux fans, I will research some effective and stable steps on this. I will
> > post to this mail list later when I succeed on Redhat linux.
>
> I am using RedHat-5.2 and I don't have any problems.  There might be some problems with RedHad-6.0 and/or RedHat-6.1.  I
> have heard of some people having problems with RedHat-6.x but I think that might be with RTEMS.  Anyway, RedHat-5.2 works
> for me.

Yes, I have problems with Redhat-6.0.

>
>
> > > He is using egcs-1.1.2, glibc-2.1 and binutils-2.9.1.0.19a.
> > >
> > > I have just managed to cross-compile glibc-2.1.1 and glibc-2.1.2 with egcs-1.1.2.  I haven't tested them out yet but
> > > will do it this week.  I am running with the embedded-2.2.5.tgz kernel and should upgrade to mpc8xx-2.2.13.tgz
> > > kernel.  I assume things should still work with the 2.2.5 kernel and I will let you know soon.
> > >
> > > I couldn't get glibc-2.1.1 nor glibc-2.1.2 to compile using the cpu=860 flag.  I was setting CC="powerpc-linux-gcc
> > > -mcpu=860".
> >
> > I think maybe you should use "export CC=powerpc-linux-gcc" and not use "-mcpu=860". I don't know why, but I do this and
> > succeed.
>
> Yes.  I have successfully built glibc-2.1.1 and glibc-2.1.2 with egcs-1.1.2 and binutils-2.9.1.0.19a.
> I have copied all the shared libraries to my nfs root filesystem under /lib.  I still get segmentation faults when I try to
> run the dynamic application.  Arghh !!!  This is so annoying.

Hi, Brendan:
    Here are some notes:
    1      Make sure you copy all your libraries under $(prefix)/$(target)/lib and $(prefix)/lib/gcc-lib to your target's root
filesystem /lib.
   2        Make sure you keep their property unchangeable. i.e, if a library is symbol link , you must keep it unchangeable
after copying. Especially, libc.so.6 is a symbol link pointing to libc-2.1.so .
   3         Make sure all  these libraries you are copying are generated when buiding your cross-compile environment.
  4          When cross-compiling your test app, you can specify its running share libraries path using "-Wl,--rpath,/lib".
i.e:
               powerpc-linux-gcc -O2 -mcpu=860 -Wl,--rpath,lib -o mytest mytest.c
              An easyest way to test this is to replace your target NFS root filesystem's /bin/sh with the above "mytest" and
reset your board. And running "rpc.nfsd -F -d call" on your x86 host to monitor whether it can run correctly. If not, what file
it cannot find? In my case , First , it can not find "/etc/ld.so.preload" and "/etc/ld.so.cache". then I run "touch
/tftpboot/etc/{ld.so.preload,ld.so.cache}". Then reset. And continue monitoring.
In my case, this time it cannot find some libraries under /usr/local/lib.Copy all the files it cannot find to its proper
place(where rpc.nfsd reports). In fact you can specify its running share libraries path using "-Wl, --rpath, /lib" to avoid
these.
Keep patient and you will find you are succeeding at this moment.

>
>
> I'm using embedded-2.2.5 sourece.  Maybe I should try mpc8xx-2.2.13 or linux-2.2.14 ?

I use mpc8xx-2.2.13. But I think it makes no difference.

>
> Dony, have you modified any of the kernel source code ?

No.

>
>
> Does any body out there in linuxppc-embedded land have a clue as to what could be causing the segfaults ?
> Can someone suggest a way of getting more debugging information.  I'm using nfsd with "-F -d" call options at the moment.

I think this is enough to debug your problem. This is what I use.

>
> I can see the ld.so.1 gets called which causes lots of reads from ld-2.1.2.so and then that's it.  I would expect to get
> calls to libc.so.6 but it never gets that far.

Then where does it go after it accesses ld.so.1?
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
