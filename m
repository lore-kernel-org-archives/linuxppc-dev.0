Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F83B2BDB0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 02:36:38 +1000 (EST)
In-Reply-To: <20041011160429.19065.qmail@web53804.mail.yahoo.com>
References: <20041011160429.19065.qmail@web53804.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <079593FC-1BA4-11D9-A165-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 11 Oct 2004 12:38:49 -0400
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


On Oct 11, 2004, at 12:04 PM, annamaya wrote:

> I am trying to boot a linux kernel using a PlanetCore
> BootLoader on an embedded planet board. I am used to
> always using U-Boot for my Kernel booting needs. I am
> not sure how to get this going on a PlanetCore boot
> loader.

You need to build a zImage so you get the simple
bootloader that will read the information from the EEPROM
and format the board structure.

Load the zImage file as a binary.  It has a 64K ELF header
on it, so you can either use 'dd' to strip that before the
download or add 64K to the load address to use as the
start address.  The start address is the first instruction of
the image (or +64K if you didn't remove the ELF header).


	-- Dan
