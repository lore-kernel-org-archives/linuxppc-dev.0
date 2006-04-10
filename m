Return-Path: <dwilder@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 129DB679F8
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2006 07:47:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ALlVga005132
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 17:47:31 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3ALom6e150664
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 15:50:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3ALlUXj006363
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 15:47:31 -0600
Message-ID: <443ADCA2.20903@us.ibm.com>
Date: Mon, 10 Apr 2006 15:30:58 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: fastboot@lists.osdl.org, linuxppc-dev@ozlabs.org, akpm@osdl.org,
	mchintage@in.ibm.com, paulus@samba.org, hbabu@us.ibm.com
Subject: [PATCH] kdump-image-rm-static
Content-Type: multipart/mixed; boundary="------------060109020300090300050604"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060109020300090300050604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am posting three patches (in separate emails) to both these lists.    
The 2nd and 3d patches have dependencies on the first patch that I have 
attached to this email (changing a static to non-static).  This patch 
applies to generic code where the other two are powerpc specific. Please 
pick up these patchs.

On powerpc, the panic CPU sends an IPI to shoot down other CPUs. Since 
the IPI is not an NMI, it may not be able to stop all CPUs before kdump 
boot. However, one solution could be, if some CPUs are not stopped, 
asking the user to activate soft-reset (either from management console 
or pressing soft-reset button) which sends FW NMI to all CPUs. These 
CPUS will execute arch specific kdump func which has to be invoked 
machine_kexec() directly. At present, kexec_crash_image is not passed to 
machine_crash_shutdown() or defined as static in kexec.c.

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789


--------------060109020300090300050604
Content-Type: text/x-patch;
 name="kdump-image-rm-static.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-image-rm-static.patch"


On powerpc, the panic CPU sends an IPI to shoot down other CPUs. Since not an NMI, may not able to stop all CPUs before kdump boot. However, one solution could be, if some CPUs are not stopped, asking the user to activate soft-reset (either from management console or pressing soft-reset button) which sends FW NMI to all CPUs. These CPUS will execute arch specific kdump func which has to be invoked machine_kexec() directly. At present, kexec_crash_image is not passed to machine_crash_shutdown() or defined as static in kexec.c.

Signed-off-by: David Wilder <dwilder@us.ibm.com>
Signed-off-by: Haren Myneni <haren@us.ibm.com>

--- 2617-rc1/kernel/kexec.c.orig	2006-04-05 13:27:53.000000000 -0700
+++ 2617-rc1/kernel/kexec.c	2006-04-05 13:27:43.000000000 -0700
@@ -903,7 +903,7 @@ static int kimage_load_segment(struct ki
  * that to happen you need to do that yourself.
  */
 struct kimage *kexec_image = NULL;
-static struct kimage *kexec_crash_image = NULL;
+struct kimage *kexec_crash_image = NULL;
 /*
  * A home grown binary mutex.
  * Nothing can wait so this mutex is safe to use
@@ -1042,7 +1042,6 @@ asmlinkage long compat_sys_kexec_load(un
 
 void crash_kexec(struct pt_regs *regs)
 {
-	struct kimage *image;
 	int locked;
 
 
@@ -1056,12 +1055,11 @@ void crash_kexec(struct pt_regs *regs)
 	 */
 	locked = xchg(&kexec_lock, 1);
 	if (!locked) {
-		image = xchg(&kexec_crash_image, NULL);
-		if (image) {
+		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 			crash_setup_regs(&fixed_regs, regs);
 			machine_crash_shutdown(&fixed_regs);
-			machine_kexec(image);
+			machine_kexec(kexec_crash_image);
 		}
 		xchg(&kexec_lock, 0);
 	}

--------------060109020300090300050604--
