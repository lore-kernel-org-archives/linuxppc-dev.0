Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 94920DE010
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:47:43 +1100 (EST)
Message-ID: <45B96BC5.3090308@am.sony.com>
Date: Thu, 25 Jan 2007 18:47:33 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/14] ps3: smp interrupt fixes
References: <45B81883.2010508@am.sony.com> <200701250707.07626.arnd@arndb.de>
In-Reply-To: <200701250707.07626.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Thursday 25 January 2007 03:40, Geoff Levand wrote:
>> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
>> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
>> @@ -317,22 +317,23 @@ struct ps3_bmp {
>> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDu=
nsigned long unused_1[3];
>> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDu=
nsigned long mask;
>> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDu=
nsigned long unused_2[3];
>> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD} __at=
tribute__ ((packed));
>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD} __at=
tribute__ ((aligned (64)));
>=20
> Is that meant to be a 64 _byte_ alignment? By default, it is
> already aligned to 64 bit.
> If 64 byte is some magic requirement by the hypervisor, you
> might want to make that explicit by using a constant definition
> for it.


The status + mask (512 bits) can't cross a page boundary, as required
by the HV.  That is the intent of the aligned (64) attribute.

Sorry, I don't quite understand what you mean by 'using a constant defini=
tion
for it'.  Could you elaborate?

As you suggested I have already changed this to:

struct ps3_bmp {
	struct {
		u64 status;
		u64 unused_1[3];
		u64 mask;
		u64 unused_2[3];
	};
	u64 ipi_debug_brk_mask;
	spinlock_t lock;
};

struct ps3_private {
	struct ps3_bmp bmp __attribute__ ((aligned (64)));
	u64 node;
	unsigned int cpu;
};


>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDcur_cp=
u_spec->cpu_features |=3D CPU_FTR_SMT;
>>=20
> CPU_FTRS_CELL already contains CPU_FTR_SMT, why do you need to enable
> it explicitly?


Yes, I questioned whether that was needed or not.  I'll remove it.

-Geoff
