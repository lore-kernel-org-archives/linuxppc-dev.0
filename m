Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 356A0DDEB6
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 20:07:14 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6OA7JBS4075700
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 20:07:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6OA5vHC174090
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 20:05:57 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6OA6YFI004797
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 20:06:34 +1000
Received: from [9.124.35.39] (srinivasa-laptop.in.ibm.com [9.124.35.39])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6OA6XxE004635
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 20:06:33 +1000
Message-ID: <46A5CF25.7090905@in.ibm.com>
Date: Tue, 24 Jul 2007 15:36:29 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: 2.6.23-rc1 build breaks on ppc64.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  Compilation of 2.6.23-rc1 breaks on ppc64, if CONFIG_SOFTWARE_SUSPEND
is not set.
===========================================================
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      arch/powerpc/sysdev/dart_iommu.o
arch/powerpc/sysdev/dart_iommu.c: In function âiommu_init_late_dartâ:
arch/powerpc/sysdev/dart_iommu.c:376: error: implicit declaration of
function âregister_nosave_region_lateâ
make[1]: *** [arch/powerpc/sysdev/dart_iommu.o] Error 1
make: *** [arch/powerpc/sysdev] Error 2
==============================================================
In include/linux/suspend.h
===========================================================
#ifdef CONFIG_PM
#ifdef CONFIG_SOFTWARE_SUSPEND
/* kernel/power/snapshot.c */
extern void __register_nosave_region(unsigned long b, unsigned long e,
int km);
static inline void register_nosave_region(unsigned long b, unsigned long e)
{
        __register_nosave_region(b, e, 0);
}
static inline void register_nosave_region_late(unsigned long b, unsigned
long e)
{
        __register_nosave_region(b, e, 1);
}
==========================================================


Thanks
 Srinivasa DS
 LTC-ISL
 IBM India
