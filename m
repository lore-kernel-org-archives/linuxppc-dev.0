Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 048CA2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 04:52:48 +1000 (EST)
In-Reply-To: <20041011175055.93158.qmail@web53805.mail.yahoo.com>
References: <20041011175055.93158.qmail@web53805.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <12CB79ED-1BB7-11D9-909B-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 11 Oct 2004 14:55:09 -0400
To: annamaya <annamaya@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 11, 2004, at 1:50 PM, annamaya wrote:

> I loaded a zImage into address 0x100000 in RAM and
> verified that this was indeed an ELF file. I then said
> "go 0x100040" which would start executing the code
> after skipping the 64 bytes of ELF header. But this is
> what I see happen.

Two problem.  First, that address for loading is too
low.  You need to load at or above 0x200000.  The
kernel lives where you loaded, so the uncompress
copied over your uncompressing code and image.

Second, the offset is 64K not 64.

You want to load at 0x200000 and 'go 0x210000'


	-- Dan
