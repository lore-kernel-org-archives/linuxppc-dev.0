To: "Luo Yanjun" <yjluo@udtech.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to run SELF without Hardhat 2.0? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Sep 2002 17:42:37 +0800."
             <03e001c257e5$48cc96d0$6100a8c0@udtech.net>
Date: Mon, 09 Sep 2002 12:08:49 +0200
Message-Id: <20020909100854.D2D16FA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Luo Yanjun,

in message <03e001c257e5$48cc96d0$6100a8c0@udtech.net> you wrote:
>
> I just installed ELDK and compiled the kernel, I don't know how to make a
> ramdisk,
> and I searched the list find that you have made a SELF can build kernel with
> ramdisk,
> so I want to try, but I found that the SELF just use Hardhat 2.0 as develop
> environment,
> I don't have Hardhat 2.0 now, only ELDK, so can I use SELF?

Of course you can.

You should see the SELF package as a construction kit  for  your  own
envrionment;  all  you  need to do to use SELF with our ELDK (version
1.x) is to create a  new  file  "config/LIB_LIST.ELDK-1.0"  with  the
following content:

----- cut here -----
lib/ld-2.2.1.so
lib/ld.so.1
lib/libc-2.2.1.so
lib/libc.so.6
lib/libcrypt-2.2.1.so
lib/libcrypt.so.1
lib/libdl-2.2.1.so
lib/libdl.so.2
lib/libnsl-2.2.1.so
lib/libnsl.so.1
lib/libnss_compat-2.2.1.so
lib/libnss_compat.so.2
lib/libnss_files-2.2.1.so
lib/libnss_files.so.2
lib/libresolv-2.2.1.so
lib/libresolv.so.2
lib/libutil-2.2.1.so
lib/libutil.so.1
----- cut here -----

Then make your board's config file look like this:

	CROSS_PREFIX    = ppc_8xx-
	CDK_DIR         = /opt/eldk/usr
	LIB_DIR         = /opt/eldk/ppc_8xx
	LIBRARIES       = LIB_LIST.ELDK-1.0

That's all.


BTW: The next version of our ELDK will contain an adapted version  of
SELF,  with pre-build images for all supported arcitectures. ELDK-2.0
is based on YD-2.3 and will be available in 2 or 3 weeks from now.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When you die, the first thing you lose is your life. The  next  thing
is the illusions.                       - Terry Pratchett, _Pyramids_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
