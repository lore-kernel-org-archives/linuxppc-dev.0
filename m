Return-Path: <haren@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C40F167A3D
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jun 2006 05:15:40 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5QJFZ4a019788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 15:15:35 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5QJF5fV298494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 13:15:05 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5QJFX6i030305
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 13:15:35 -0600
Message-ID: <44A031FA.7050502@us.ibm.com>
Date: Mon, 26 Jun 2006 12:14:02 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: vgoyal@in.ibm.com
Subject: [PATCH] powerpc: build fix for ppc32 with CONFIG_KEXEC
References: <20060626063128.GA3359@narn.hozed.org>
	<20060626135801.GC8985@in.ibm.com>
In-Reply-To: <20060626135801.GC8985@in.ibm.com>
Content-Type: multipart/mixed; boundary="------------050704020902080309020608"
Cc: linuxppc-dev@ozlabs.org, Fastboot mailing list <fastboot@lists.osdl.org>,
	linux-kernel@vger.kernel.org, Troy Benjegerdes <hozer@hozed.org>,
	ellerman@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050704020902080309020608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Vivek Goyal wrote:

>On Mon, Jun 26, 2006 at 01:31:28AM -0500, Troy Benjegerdes wrote:
>  
>
>>various things like 'reserve_crashkernel' are referenced, but only
>>exist in arch/powerpc/kernel/machine_kexec_64.c.
>>
>>    
>>
>
>I think for ppc32 the framework is present for kexec/kdump but nobody 
>is actively testing/maintaining it as of today.
>  
>
At present, even though kexec support is included for PPC32, I believe, 
it has been actively tested/maintained only on gamecube.

Michael, if you are OK with this patch, please send it to upstream.
Thanks
Haren

arch/powerpc/kernel/built-in.o(.init.text+0x1c98): In function 
`early_init_devtree':
: undefined reference to `reserve_crashkernel'
arch/powerpc/kernel/built-in.o(.init.text+0x1d90): In function 
`early_init_devtree':
: undefined reference to `overlaps_crashkernel'
 This patch will fix the above build errors on ppc32 with CONFIG_KEXEC.  
Both reserve_crashkernel() and overlaps_crashkernel() should be moved to 
machine_kexec.c() after the kdump support is included on ppc32.

Signed-off-by: Haren Myneni <haren@us.ibm.com>





>Thanks
>Vivek
>_______________________________________________
>fastboot mailing list
>fastboot@lists.osdl.org
>https://lists.osdl.org/mailman/listinfo/fastboot
>  
>


--------------050704020902080309020608
Content-Type: text/x-patch;
 name="ppc32-kexec-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc32-kexec-build-fix.patch"

--- linux-2.6.17-git10/arch/powerpc/kernel/machine_kexec_32.c.orig	2006-06-26 05:33:51.000000000 -0700
+++ linux-2.6.17-git10/arch/powerpc/kernel/machine_kexec_32.c	2006-06-26 05:47:04.000000000 -0700
@@ -63,3 +63,16 @@ int default_machine_kexec_prepare(struct
 {
 	return 0;
 }
+
+/*
+ * FIXME: Move the following functions to machine_kexec.c after
+ * kdump support is included on ppc32.
+ */
+void __init reserve_crashkernel(void)
+{
+}
+
+int overlaps_crashkernel(unsigned long start, unsigned long size)
+{
+	return 0;
+}

--------------050704020902080309020608--
