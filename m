Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DD2D4DDE23
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 09:50:14 +1100 (EST)
Message-ID: <473392A3.4010203@freescale.com>
Date: Thu, 08 Nov 2007 16:50:11 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/4] Use embedded libfdt in the bootwrapper
References: <20071108033241.GA11695@localhost.localdomain>
	<20071108033603.8A29FDDE0F@ozlabs.org>
	<20071108160839.GA4356@loki.buserror.net>
	<20071108224051.GB18592@localhost.localdomain>
In-Reply-To: <20071108224051.GB18592@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>> How hard would it be to get libfdt to dynamically allocate any extra space
>> it needs?  This is a regression from the current flat device tree code...
> 
> Uh.. it already does.  Or rather, the shims in libfdt-wrapper.c do so,
> when libfdt functions which can expand the tree report that they've
> run out of room.

Ah, good -- I was looking in libfdt itself, not the wrapper.  Now if 
only we could get something similar into u-boot... maybe libfdt proper 
could accept an optional realloc() function pointer in fdt_init(), and 
eliminate the need for the caller to provide such a wrapper?

-Scott
