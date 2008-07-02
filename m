Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA723DDF83
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 03:12:45 +1000 (EST)
Message-ID: <486BB6E3.1060602@freescale.com>
Date: Wed, 02 Jul 2008 12:12:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] mpc83xx: Power Management support
References: <20080625215051.GA11784@loki.buserror.net>
	<7B906E0F-3149-43F0-815A-8314BF5BA039@kernel.crashing.org>
In-Reply-To: <7B906E0F-3149-43F0-815A-8314BF5BA039@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> +#define SS_MEMSAVE    0x00
> 
> What is this? add a comment?

There's a comment where MEMSAVE is used:

         /* The first 2 words of memory are used to communicate with the
          * bootloader, to tell it how to resume.
          *
          * The first word is the magic number 0xf5153ae5, and the second
          * is the pointer to mpc83xx_deep_resume.
          *
          * The original content of these two words is saved in the state
          * save area.
          */

We could stick a /* First 8 bytes of RAM */ after the #define if you want.

>> +#define SS_HID        0x08 /* 3 HIDs */
>> +#define SS_IABR        0x14 /* 2 IABRs */
>> +#define SS_IBCR        0x1c
>> +#define SS_DABR        0x20 /* 2 DABRs */
>> +#define SS_DBCR        0x28
>> +#define SS_SP        0x2c
>> +#define SS_SR        0x30 /* 16 segment registers */
>> +#define SS_CURRENT    0x70
> 
> How about SS_R2 to match the pmac sleep.S code.  It will make 
> refactoring all this easier in the future.

OK.

-Scott
