Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-69-68.roch.qwest.net [67.41.69.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EFB16802A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 03:11:40 +1000 (EST)
Message-ID: <31672.129.42.161.36.1123607983.squirrel@jdub.homelinux.org>
In-Reply-To: <17f142e1050809080053187f40@mail.gmail.com>
References: <17f142e1050809080053187f40@mail.gmail.com>
Date: Tue, 9 Aug 2005 12:19:43 -0500 (CDT)
From: "Josh Boyer" <jwboyer@jdub.homelinux.org>
To: "Jayaprakash Shanmugam" <jayaprakashns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: open() returns 0.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Hello All,
>
>   I have a 8270 based board running Linux 2.6.  I am using the i2c
> available on chip to read / write a i2c mux connected to it.  When I
> open the i2c device, it returns 0 (which shouldnt be) instead of the
> file descriptor.   The /proc/devices shows the i2c driver with major
> 89 is installed.

Does your program close all it's file descriptors before opening the i2c
device?  0 is a valid file descriptor.  It's just normally used by STDIN. 
If a program closes or doesn't inherit STDIN for some reason, 0 becomes
available.

josh
