Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AEF2DDDE0
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 07:35:51 +1100 (EST)
Date: Sun, 21 Dec 2008 23:35:48 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <121213804.20081221233548@emcraft.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re[2]: [PATCH][v2] powerpc 44x: support for 256KB PAGE_SIZE
In-Reply-To: <jelju91e1q.fsf@sykes.suse.de>
References: <200812211446.56783.yur@emcraft.com> <je4p0x319s.fsf@sykes.suse.de>
	<947420693.20081221230007@emcraft.com>
	<jelju91e1q.fsf@sykes.suse.de>
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

=0D=0AOn Sunday, December 21, 2008 you wrote:

> Yuri Tikhonov <yur@emcraft.com> writes:

>>  Thanks for pointing this. I guess, the -zmax-page-size option is new=20
>> to binutils 2.17.50.0.10. Right?

> It was added 2=BD years ago.

 Yes, approximately: http://gcc.gnu.org/ml/gcc/2006-07/msg00361.html

"
Date: Sat, 15 Jul 2006 15:19:05 -0700
Subject: The Linux binutils 2.17.50.0.3 is released

Changes from binutils 2.17.50.0.2:
...
16. Add "-z max-page-size=3D" and "-z common-page-size=3D" to ELF linker.
"

>>  I'll remove the STDBINUTILS config option from this patch then, and=20
>> correspondingly update the description.

 I thought about this more, and I guess that we should keep the=20
dependency on the newly introduced by this patch STDBINUTILS option.=20
Perhaps, change it name to, say, STD_ELF_LINKING.

 Because, in any case, either should we patch binutils, or should we=20
pass some non-default value to the linker: the resulted application=20
doesn't match the ELF standard, and the applications which match the=20
standard simply won't work with the 256K paged kernel - so, a user has=20
to be aware of it before turning the 256K on.

 What do you think about this?

 Regards, Yuri
