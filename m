Message-Id: <20010826005515.Postino-022357@smtp01.highway.ne.jp>
Date: Sun, 26 Aug 2001 00:55:15 +0900
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: Keith Clayton <keith@claytons.org>,
	linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: glibc 2.1 -> 2.2 gotchas?
In-Reply-To: <01082511424509.15847@localhost.localdomain>
References: <998751333.12597.3.camel@yoda>
 <01082511314308.15847@localhost.localdomain>
 <3B87C5AE.2803935D@iiic.ethz.ch>
 <01082511424509.15847@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>


>  I always do a ldconfig -v; sync; sync; shutdown -r now and
> invariably I see inodes that need repairing after a glibc update.
>

it's no needs.
Please read glibc's FAQ  which has glibc source

I have here also at

 ftp://ftp.linuxppc.org/users/kfukui/glibc-2.2.x-room/RPMS/FAQ.glibc-2.2.3

Kaoru


------------ glibc-2.2.3.FAQ (only 2.32)--------------------
2.32.	What has do be done when upgrading to glibc 2.2?

{AJ} The upgrade to glibc 2.2 should run smoothly, there's in general no
need to recompile programs or libraries.  Nevertheless, some changes might
be needed after upgrading:
- The utmp daemon has been removed and is not supported by glibc anymore.
  If it has been in use, it should be switched off.
- Programs using IPv6 have to be recompiled due to incompatible changes in
  sockaddr_in6 by the IPv6 working group.
- The Berkeley db libraries have been removed (for details see question 2.31).
- The format of the locale files has changed, all locales should be
  regenerated with localedef.  All statically linked applications which use
  i18n should be recompiled, otherwise they'll not be localized.
- glibc comes with a number of new applications.  For example ldconfig has
  been implemented for glibc, the libc5 version of ldconfig is not needed
  anymore.
- There's no more K&R compatibility in the glibc headers.  The GNU C library
  requires a C compiler that handles especially prototypes correctly.
  Especially gcc -traditional will not work with glibc headers.

Please read also the NEWS file which is the authoritative source for this
and gives more details for some topics.
---------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
