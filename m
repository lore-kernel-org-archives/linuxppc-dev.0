Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0789B67B66
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 02:15:23 +1000 (EST)
Message-ID: <451168F6.3030701@ovro.caltech.edu>
Date: Wed, 20 Sep 2006 09:14:46 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: how an application program utilizes the driver.
References: <BAY110-F240E99BA0EDF765EC09402B2230@phx.gbl>
In-Reply-To: <BAY110-F240E99BA0EDF765EC09402B2230@phx.gbl>
Content-Type: text/plain; charset=GB2312
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

Hi Ming,

> My situation is: I want to write a driver for my custom device.(In the 
> driver there are some functions defined to read or write my device.) Then 
> in my application program, I use these defined functions to operate my 
> hardware device. I think this is a normal process to operate the hardware 
> with driver+app, right? 

Right, but you've missed a few critical points.

For your custom device, you'll create a driver that implements
*kernel space* functions my_driver_open(), read(), write(), close()
etc. You'll install that module and create an appropriate
device node, eg. /dev/my_driver.

In your *user-space* application code, you'll open that device

int main(argc, argv) ...

  int fd = open("/dev/my_driver" ...)


and then write to your device ...

  int write(fd, buffer, len);

or read from your device ...

  int read(fd, buffer, len);

The user-space calls open, read, write eventually call down into
your driver space code. The driver and application are not
linked, they communicate via the /dev interface.

You really should read through Linux Device Drivers by Rubini,
or check out a tutorial such as

http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-723-Hawkins.pdf
http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz
http://www.ovro.caltech.edu/~dwh/correlator/index.html

Regards,
Dave
