Return-Path: <amgta@yacht.ocn.ne.jp>
Received: from smtp.yacht.ocn.ne.jp (yacht.ocn.ne.jp [222.146.40.168])
	by ozlabs.org (Postfix) with ESMTP id A18EB67A85
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 02:16:02 +1100 (EST)
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Olaf Hering <olh@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 27 Jan 2005 23:56:10 +0900
References: <200501260512.j0Q5CAhd016730@hera.kernel.org>
	<20050126190537.GA26349@suse.de>
In-Reply-To: <20050126190537.GA26349@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200501272356.10846.amgta@yacht.ocn.ne.jp>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Philippe Elie <phil.el@wanadoo.fr>, Greg Banks <gnb@sgi.com>,
	John Levon <levon@movementarian.org>
Subject: Re: [PATCH] oprofile: falling back on timer interrupt mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 27 January 2005 04:05, Olaf Hering wrote:
>  On Wed, Jan 26, Linux Kernel Mailing List wrote:
> > ChangeSet 1.2038, 2005/01/25 20:31:01-08:00, amgta@yacht.ocn.ne.jp
> >
> > 	[PATCH] oprofile: falling back on timer interrupt mode

> This misses arch/ppc


Thanks for pointing that out.

This is opofile timer-mode fallback fix for ppc.

Signed-off-by: Akinobu Mita <amgta@yacht.ocn.ne.jp>

--- 2.6-bk/arch/ppc/oprofile/common.c.orig	2005-01-27 23:28:44.000000000 +0900
+++ 2.6-bk/arch/ppc/oprofile/common.c	2005-01-27 23:32:27.000000000 +0900
@@ -124,7 +124,7 @@ static struct oprofile_operations oprof_
 	.cpu_type	= NULL		/* To be filled in below. */
 };
 
-void __init oprofile_arch_init(struct oprofile_operations *ops)
+int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
 	char *name;
 	int cpu_id = smp_processor_id();
@@ -132,14 +132,13 @@ void __init oprofile_arch_init(struct op
 #ifdef CONFIG_FSL_BOOKE
 	model = &op_model_fsl_booke;
 #else
-	printk(KERN_ERR "oprofile enabled on unsupported processor!\n");
-	return;
+	return -ENODEV;
 #endif
 
 	name = kmalloc(32, GFP_KERNEL);
 
 	if (NULL == name)
-		return;
+		return -ENOMEM;
 
 	sprintf(name, "ppc/%s", cur_cpu_spec[cpu_id]->cpu_name);
 
@@ -151,6 +150,8 @@ void __init oprofile_arch_init(struct op
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
 	       oprof_ppc32_ops.cpu_type);
+
+	return 0;
 }
 
 void oprofile_arch_exit(void)
