Return-Path: <dceravigupta@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 8D406B780E
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 22:22:42 +1000 (EST)
Received: by pxi17 with SMTP id 17so2989150pxi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 05:22:41 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 16 Aug 2010 17:52:41 +0530
Message-ID: <AANLkTi=ZSeYf0apwK3Tuf3b3-OTsRrddMkNHkxgViw-x@mail.gmail.com>
Subject: Distinguish between kernel and user space
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>, MJ embd <mj.embd@gmail.com>,
	Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: multipart/alternative; boundary=00163646ca928f144e048defe380
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163646ca928f144e048defe380
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have defined a header file for ioctls macros definitions. I am including
it in both, my user space application as well as in my device driver. Now
there are some macros that I want to be visible only in device drive and
some only in user space application. Is there any set of macros defined in
linux for such purpose? This is my present header file

gpio_ioctl.h

#ifndef _GPIO_IOCTL_H_
#define _GPIO_IOCTL_H_

/*
 * Ioctl definitions
 */

/* Use 250 as type/magic number */
#define GPIO_IOC_MAGIC    250
#define GPIO_READ         _IOW (GPIO_IOC_MAGIC, 0, int)
#define GPIO_WRITE        _IOW (GPIO_IOC_MAGIC, 1, int)
#define GPIO_IOC_MAXNR    2


#ifdef _DEVICE_DRIVE_ ---> these macros should not be visible in user space
application
#define ...
...
..
#endif

#ifdef _USER_SPACE_ ---> these macros should not be visible in device driver
i.e kernel space
#define ...
...
..

#endif  /*_GPIO_IOCTL_H_ */

Thanks in advance
Ravi Gupta

--00163646ca928f144e048defe380
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>
<br>
I have defined a header file for ioctls macros definitions. I am=20
including it in both, my user space application as well as in my device=20
driver. Now there are some macros that I want to be visible only in=20
device drive and some only in user space application. Is there any set=20
of macros defined in linux for such purpose? This is my present header file=
<br><br>gpio_ioctl.h<br><br>#ifndef _GPIO_IOCTL_H_<br>#define _GPIO_IOCTL_H=
_<br><br>/*<br>=A0* Ioctl definitions<br>=A0*/<br><br>/* Use 250 as type/ma=
gic number */<br>
#define GPIO_IOC_MAGIC=A0=A0=A0 250<br>#define GPIO_READ=A0=A0=A0=A0=A0=A0=
=A0=A0 _IOW (GPIO_IOC_MAGIC, 0, int)<br>#define GPIO_WRITE=A0=A0=A0=A0=A0=
=A0=A0 _IOW (GPIO_IOC_MAGIC, 1, int)<br>#define GPIO_IOC_MAXNR=A0=A0=A0 2<b=
r><br><br>#ifdef _DEVICE_DRIVE_ ---&gt; these macros should not be visible =
in user space application<br>
#define ...<br>...<br>..<br>#endif<br><br>#ifdef _USER_SPACE_ ---&gt; these=
 macros should not be visible in device driver i.e kernel space<br>#define =
...<br>...<br>..<br><br>
#endif=A0 /*_GPIO_IOCTL_H_ */<br><br>
Thanks in advance<br>
Ravi Gupta

--00163646ca928f144e048defe380--
