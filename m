Return-Path: <jfaslist@yahoo.fr>
Message-ID: <44732357.4000506@yahoo.fr>
Date: Tue, 23 May 2006 16:59:35 +0200
From: jfaslist <jfaslist@yahoo.fr>
MIME-Version: 1.0
To: linuxppc64-dev@ozlabs.org
Subject: Maple: killing a  process that causes a machine check exception
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
By  applying the following mods (plse see below), i was able to have a 
user process that caused a machine check exception to be terminated (on 
a Maple platform), as expected. I was wondering why the PPC64 had a 
different ME handling than PPC which does send the SIGBUS to the process?
Thanks
Regards,
-jean-francois simon


diff -urN -X linux-2.6.16.14/Documentation/dontdiff 
linux-2.6.16.14/arch/powerpc/kernel/traps.c 
linux-2.6.16.14.vmeberr_fix/arch/powerpc/kernel/traps.c
--- linux-2.6.16.14/arch/powerpc/kernel/traps.c 2006-05-04 
17:03:45.000000000 -0700
+++ linux-2.6.16.14.vmeberr_fix/arch/powerpc/kernel/traps.c 2006-05-09 
02:46:59.000000000 -0700
@@ -340,12 +340,19 @@
 #ifdef CONFIG_PPC64
        int recover = 0;

+
        /* See if any machine dependent calls */
        if (ppc_md.machine_check_exception)
              recover = ppc_md.machine_check_exception(regs);

        if (recover)
              return;
+
+       if (user_mode(regs)) {
+             regs->msr |= MSR_RI;
+             _exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
+             return;
+       }
 #else
        unsigned long reason = get_mc_reason(regs);


	

	
		
___________________________________________________________________________ 
Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
http://fr.mail.yahoo.com
