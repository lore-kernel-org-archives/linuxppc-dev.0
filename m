Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 0002D67B66
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 01:06:46 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so2977197ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 08:06:41 -0700 (PDT)
Message-ID: <528646bc0606280806y2ec566b1rd0d5c07c9fcc0aaf@mail.gmail.com>
Date: Wed, 28 Jun 2006 09:06:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Robert Zach" <rza1@so-logic.co.at>
Subject: Re: no login prompt with ml403 + uartlite-->major numbers?
In-Reply-To: <200606281214.k5SCEQEf039728@webmail.so-logic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200606281214.k5SCEQEf039728@webmail.so-logic.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/28/06, Robert Zach <rza1@so-logic.co.at> wrote:
> Hello!
>
> I use the "Standart" ml403 Design with the uartlite instead of the
> uart16550...
>
> my kernel parameters are:
> "console=ttl0 ip=off root=/dev/xsysace/disc0/part3 rw"
>
> It boots correctly, but i got no login prompt!!
> getty is started with init.
> my inittab looks like:
> ...
> ::respawn:/sbin/getty 9600 ttl0

Looks ok.  busybox I assume.  You might try:

ttl0::respawn:/sbin/getty 9600 ttl0

You could try just launching a shell on the console.  Then you can
look around and see what's there:

::respace:/bin/sh

> ...
>
> I use devfs.

Ugh.  You should turn off devfs and build a static /dev folder for the
time being.  Otherwise you've got no idea if devfs is putting the
right things into /dev.  If you *really* want to, you can go back to
devfs later (but I don't recommend it).

> Is the inittab entry correct?

I think so

> Which device is the uartlite in devfs?

I don't know; read the source.  Look for where it registers with devfs
to get the expected name.  Does the uartlite driver you're using even
support devfs?

>
> Which major numbers uses the uartlite?

I don't know; it should be easy to find in the driver source

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
