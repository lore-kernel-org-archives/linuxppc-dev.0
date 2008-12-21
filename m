Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DB87DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 07:00:11 +1100 (EST)
Date: Sun, 21 Dec 2008 23:00:07 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <947420693.20081221230007@emcraft.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re[2]: [PATCH][v2] powerpc 44x: support for 256KB PAGE_SIZE
In-Reply-To: <je4p0x319s.fsf@sykes.suse.de>
References: <200812211446.56783.yur@emcraft.com> <je4p0x319s.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: wd@denx.de, dzu@denx.de, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AHello Andreas,

On Sunday, December 21, 2008 you wrote:

> Yuri Tikhonov <yur@emcraft.com> writes:

>> Because ELF standard supports only page sizes up to 64K, then you should
>> use patched binutils for building applications to be run with the 256KB-
>> page sized kernel. The patch for binutils is rather trivial, and may
>> look as follows:
>>
>> --- binutils/bfd/elf32-ppc.c.orig
>> +++ binutils/bfd/elf32-ppc.c
>>
>> -#define ELF_MAXPAGESIZE                0x10000
>> +#define ELF_MAXPAGESIZE                0x40000

> You don't have to patch it, it's enough to pass -zmax-page-size=3D0x40000
> to the linker.

 Thanks for pointing this. I guess, the -zmax-page-size option is new=20
to binutils 2.17.50.0.10. Right?

 I'll remove the STDBINUTILS config option from this patch then, and=20
correspondingly update the description.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
