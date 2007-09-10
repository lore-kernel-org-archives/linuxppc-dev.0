Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 5B56CDDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 02:01:35 +1000 (EST)
In-Reply-To: <20070910143006.GD21670@ld0162-tx32.am.freescale.net>
References: <20070907005803.GJ26079@localhost.localdomain>
	<d16e868937a1f77cbf080754f5742ad9@bga.com>
	<20070910142513.GB21670@ld0162-tx32.am.freescale.net>
	<20070910143006.GD21670@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d8cb883b7ae148c6f908f2bf9b4103e6@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
Date: Mon, 10 Sep 2007 11:01:46 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 10, 2007, at 9:30 AM, Scott Wood wrote:
> On Mon, Sep 10, 2007 at 09:25:13AM -0500, Scott Wood wrote:
>>> (5) space below load to decompress vmlinux (no vmlinux_alloc to
>>> fallback to malloc)
>>> (6) all space above load address available to hold malloc region
>>> (7) for console output (or input) from wrapper, on most cpus, some
>>> magic setup
>>
>> For #5, I really need to get around to implementing setting the load
>> address at build-time based on the size of vmlinux...
>
> Actually, this isn't needed for raw images -- you can just load them
> wherever you want (and thus yes, it should be documented).  cuboot 
> needs
> it, though.

Yea, raw doesn't really care about the linked address.

>>> It's on my short list to rediff and repost those anyways.
>>
>> Where can I find the existing patches?


The last rediff is patchwork id 12168-12181 posted Jul 11.  They get 
context rejects in the Makefile and ops.h, and I plan to change the 
property name from boot-file in patch 12.  Also, I need to make the 
search for rmo_end be based on device_type "memory", looking for the 
extent starting at 0.

milton
