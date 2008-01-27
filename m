Return-Path: <sripathik@in.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79EFADDDF7
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 01:02:43 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0RE2Yms031200
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 01:02:34 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0RE2gM52449408
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 01:02:42 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0RE2gci005313
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 01:02:42 +1100
From: Sripathi Kodi <sripathik@in.ibm.com>
To: paulus@samba.org
Subject: [ppc] Disparity between sys_clock_getres and vdso implementation
Date: Sun, 27 Jan 2008 19:32:59 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801271932.59823.sripathik@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	john stultz <johnstul@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

On PPC, I see a disparity between clock_getres implementations in the
vdso and syscall. I am using a IBM Openpower hardware and 2.6.24 kernel
with CONFIG_HIGH_RES_TIMERS=y. 

clock_getres call for CLOCK_REALTIME returns 1 millisecond. However,
when I edit arch/powerpc/kernel/vdso*/gettimeofday.S to force it to use 
sys_clock_getres, I get 1 nanosecond resolution. The code in vdso seems
to be returning some pre-defined (incorrect) variables.

Could you please let me know the reason for this? Is it something that
should be fixed in vdso?

Thanks,
Sripathi.
