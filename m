Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id D3500B70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 02:48:06 +1000 (EST)
Date: Wed, 11 Aug 2010 09:25:09 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
Message-ID: <20100811162509.GC27705@ovro.caltech.edu>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
	<AANLkTimJ1+d7U2SN_SSHepo6u01RJqUEXUDQXUgBfCWK@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimJ1+d7U2SN_SSHepo6u01RJqUEXUDQXUgBfCWK@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 11, 2010 at 07:49:40PM +0530, Ravi Gupta wrote:
> Also, when I try to export a gpio in sysfs
> 
> echo 9 > /sys/class/gpio/export
> 
> It gives me an error in dmesg
> gpio_request: gpio-9 (sysfs) status -22
> export_store: status -22
> 
> Here is a look of sysfs on my machine
> 
> # ls /sys/class/gpio/ -la
> drwxr-xr-x    4 root     root            0 Jan  1 00:00 .
> drwxr-xr-x   24 root     root            0 Jan  1 00:00 ..
> --w-------    1 root     root         4096 Jan  1 00:10 export
> drwxr-xr-x    3 root     root            0 Jan  1 00:00 gpiochip192
> drwxr-xr-x    3 root     root            0 Jan  1 00:00 gpiochip224
> --w-------    1 root     root         4096 Jan  1 00:00 unexport


Your GPIO pins are numbered from 192-223 on one GPIO chip, and 224-255
on the next GPIO chip. You should be exporting GPIO pin 200 or 201
(192+8 or 192+9), depending on whether your pins are numbered from zero
or one.

"status -22" is -EINVAL: Invalid Argument. You're doing something which
is invalid, so this makes sense. There is no "pin 9".

Ira
