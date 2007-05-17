Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96110DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 10:38:29 +1000 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A210@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A210@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5C1556B6-714A-4D64-AA35-B4BA539F333F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Accessing 8541 registers from user space
Date: Wed, 16 May 2007 19:36:43 -0500
To: Charles Krinke <ckrinke@istor.com>
Cc: Randy Brown <rbrown@istor.com>, Vahid Fereydounkolahi <vahidf@istor.com>,
	Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 16, 2007, at 4:59 PM, Charles Krinke wrote:

> I have a need to be able to read and write the gpio data registers  
> PDATC
> and PDATD from a user space program.
>
> We have a userspace program that succesfully mmaps an offset in / 
> dev/mem
> and reads/writes registers in a CPLD at 0xFF00_0000.
>
> The issue seems to be that when I mmap /dev/mem to 0xE000_0D50 to read
> the PDATC register, Linux-2.6.17.11 just locks up.
>
> Can anyone shed a little light on why this could be happening?

One theory is you aren't reading PDATC at the right offset.  Not sure  
what happens if you read a non-existent register offset.

I'm think you want 0xe009_0d50.

- k
