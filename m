Message-ID: <3D2C3337.FBC1283@imc-berlin.de>
Date: Wed, 10 Jul 2002 15:14:31 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Error while rebuilding glibc for ELDK
References: <20020710123915.6ECE71086F@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
>
> In message <3D2C2468.A733D375@imc-berlin.de> you wrote:
> >
> > I am using Wolfgang's ELDK for my ppc linux development. It works very good.
> >
> > Thanks a million, Wolfgang!
>
> Thanks for the compliments :-)
>
You're welcome! :o)

> > But since I want to use a 2.4.19 kernel instead of the 2.4.4 I tried to rebuild
> > the glibc.
>
> What has the kernel  version  to  do  with  the  C  library  used  by
> applications?
>

For building an application the header files in /usr/include (i.e.
$(ELDK_ROOT)/ppc_8xx/usr/include are used.

We need newer header files than the on ethat come with your ELDK. So instead of
just copying the missing files and messing the whole system up I thought it
would be a good idea to rebuild the glibc using the 2.4.19 kernel headers. And
so getting a clean /usr/include path.

> > I pulled the glibc-2.2.1-0f.src.rpm from ftp.leo.org installed it in
> > /opt/ELDK/usr/src/denx/SRPMS and started rebuilding the glibc with
>
> Ummm... you mean you pulled the source RPM from the  ELDK  directory?
> Or what?

I meant that I did what you said in ftp.leo.org/pub/eldk/README.html in section
8 "Rebuilding ELDK Components". So I pulled
ftp://ftp.leo.org/pub/eldk/eldk-ppc-sources.tar and extracted
target\SRPMS\glibc-2.2.1-0f.src.rpm from it. This file I installed using
$(CROSS_COMPILE)rpm -i glibc-2.2.1-0f.src.rpm. So I got the glibc sources and
specs und /opt/ELDK/usr/src/denx/SOURCES.

Just like you said in your README.

>
> > scholz@pinguin:/opt/ELDK/usr/src/denx/SPECS> ppc_8xx-rpm -ba glibc.spec
> >
> > It all works well until the installation scripts:
> ...
> > So what's the problem here? Is the file "el.mo" broken? Can I skip this? (I am
> > sure I won't need el.mo)
>
> If I remember correctly, you're running on a SuSE  system?  We  never
> verified  building  in sucha n environment. Under RH-7.x (x=1,2,3) it
> works fine.

Hmm. That's right. It's SuSE 8.0. But the other .po files produced no errors.
BTW I had troubles with the file "zh_TW.po" as well.

I just deleted these two files (in /opt/ELDK/usr/src/denx/BUILD/glibc-2.2.1/po/)
and tried again: With success thsi time!

I've seen a couple of

ru_RU.KOI8-R...locales/ru_RU:1927: LC_COLLATE: syntax error
locales/ru_RU:1928: LC_COLLATE: syntax error
locales/ru_RU:1929: LC_COLLATE: syntax error
locales/ru_RU:1930: LC_COLLATE: syntax error
locales/ru_RU:1931: LC_COLLATE: syntax error
locales/ru_RU:1932: LC_COLLATE: syntax error
locales/ru_RU:1933: LC_COLLATE: syntax error
locales/ru_RU:1934: LC_COLLATE: syntax error
 done
ru_UA.KOI8-U...locales/ru_UA:1926: LC_COLLATE: syntax error
locales/ru_UA:1927: LC_COLLATE: syntax error
locales/ru_UA:1928: LC_COLLATE: syntax error
locales/ru_UA:1929: LC_COLLATE: syntax error
locales/ru_UA:1930: LC_COLLATE: syntax error
locales/ru_UA:1931: LC_COLLATE: syntax error
locales/ru_UA:1932: LC_COLLATE: syntax error
locales/ru_UA:1933: LC_COLLATE: syntax error
 done
sk_SK.ISO-8859-2... done
sl_SI.ISO-8859-2... done
sq_AL.ISO-8859-1... done
...

but now I have some new rpms to install:

scholz@pinguin:~> ls -l /opt/ELDK/usr/src/denx/RPMS/ppc
insgesamt 27392
-rw-r--r--    1 scholz   devel     8808762 Jul 10 15:09
glibc-devel-ppc_8xx-2.2.1-0f.ppc.rpm
-rw-r--r--    1 scholz   devel    11550455 Jul 10 15:08
glibc-ppc_8xx-2.2.1-0f.ppc.rpm
-rw-r--r--    1 scholz   devel     7615151 Jul 10 15:11
glibc-profile-ppc_8xx-2.2.1-0f.ppc.rpm
-rw-r--r--    1 scholz   devel       21174 Jul 10 15:11
nscd-ppc_8xx-2.2.1-0f.ppc.rpm


Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
