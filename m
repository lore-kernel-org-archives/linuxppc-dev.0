Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3F102C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 21:26:26 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 20:22:40 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A07552BB004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 21:26:22 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1BAECeo7930362
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 21:14:13 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1BAQLbA023876
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 21:26:21 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Phileas Fogg <phileas-fogg@mail.ru>, Geoff Levand <geoff@infradead.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Re[3]: PS3 platform is broken on Linux 3.7.0
In-Reply-To: <87k3qg4092.fsf@linux.vnet.ibm.com>
References: <1355488506.55692113@f147.mail.ru> <1358206641.4489.8.camel@smoke>
 <1360486777.923599245@f85.mail.ru> <1360487778.293641922@f350.mail.ru>
 <87k3qg4092.fsf@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 15:56:18 +0530
Message-ID: <87zjzb4051.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Phileas Fogg <phileas-fogg@mail.ru> writes:
>
>>  And another note.
>> I took a look at the MMU chapter in the Cell Architecture handbook and i=
ndeed the first 15 bits in VA are treated as 0 by the hardware.
>>
>> Quote:
>>
>> 1. High-order bits above 65 bits in the 80-bit virtual address (VA[0:14]=
) are not implemented. The hardware always
>> =C2=A0=C2=A0 treats these bits as `0'. Software must not set these bits =
to any other value than `0' or the results are undefined in
>> =C2=A0=C2=A0 the PPE.
>>
>>
>
> True, we missed the below part of ISA doc:
>
> ISA doc says
>
> "On implementations that support a virtual address size
> of only n bits, n < 78, bits 0:77-n of the AVA field must be
> zeros. "
>
> The Cell document I found at=20
>
> https://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/7A77CCDF14FE70D=
5852575CA0074E8ED/$file/CellBE_Handbook_v1.12_3Apr09_pub.pdf
>
> gives=20
>
> Virtual Address (VA) Size -> 65 bits
>
> So as per ISA, bits 0:12 should be zero, which should make 0:14 of PTE
> fields zero for Cell.
>
> I will try to do a patch.=20
>

Can you try this patch ?

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/a=
sm/mmu-hash64.h
index 2fdb47a..f01fd9a 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -381,21 +381,37 @@ extern void slb_set_size(u16 size);
  * hash collisions.
  */
=20
+/* This should go in Kconfig */
+/*
+ * Be careful with this value. This determines the VSID_MODULUS_*  and that
+ * need to be co-prime with VSID_MULTIPLIER*
+ */
+#if 1
+#define MAX_VIRTUAL_ADDR_BITS	65
+#else
+#define MAX_VIRTUAL_ADDR_BITS	66
+#endif
+/*
+ * One bit is taken by the kernel, only the rest of space is available for=
 the
+ * user space.
+ */
+#define CONTEXT_BITS		(MAX_VIRTUAL_ADDR_BITS - \
+				 (USER_ESID_BITS + SID_SHIFT + 1))
+#define USER_ESID_BITS		18
+#define USER_ESID_BITS_1T	6
+
 /*
  * This should be computed such that protovosid * vsid_mulitplier
  * doesn't overflow 64 bits. It should also be co-prime to vsid_modulus
  */
 #define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_256M		38
+#define VSID_BITS_256M		(CONTEXT_BITS + USER_ESID_BITS + 1)
 #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
=20
 #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_1T		26
+#define VSID_BITS_1T		(CONTEXT_BITS + USER_ESID_BITS_1T + 1)
 #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
=20
-#define CONTEXT_BITS		19
-#define USER_ESID_BITS		18
-#define USER_ESID_BITS_1T	6
=20
 #define USER_VSID_RANGE	(1UL << (USER_ESID_BITS + SID_SHIFT))
=20
