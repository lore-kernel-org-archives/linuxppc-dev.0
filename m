Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38F9A67B46
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 19:31:09 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k579V5hp022629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 05:31:06 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k579V5M9165080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 05:31:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k579V4bM006413
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 05:31:05 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Add udbg-immortal kernel option
Date: Wed, 7 Jun 2006 11:31:02 +0200
References: <1149645981.27572.96.camel@localhost.localdomain>
	<20060607022412.GA5661@pb15.lixom.net>
	<1149653947.27572.113.camel@localhost.localdomain>
In-Reply-To: <1149653947.27572.113.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606071131.03281.arnd.bergmann@de.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 June 2006 06:19, Benjamin Herrenschmidt wrote:
> No way :) Besides, that's how it should be done in french :)
>=20
So you mean, like this?

Index: linux-work/arch/powerpc/kernel/udbg.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-work.orig/arch/powerpc/kernel/udbg.c	2006-05-31 14:13:59.000000=
000 +1000
+++ linux-work/arch/powerpc/kernel/udbg.c	2006-05-31 14:48:07.000000000 +10=
00
@@ -141,12 +142,14 @@ static int early_console_initialized;
=20
 void __init disable_early_printk(void)
 {
=2D#if 1
 	if (!early_console_initialized)
 		return;
+	if (strstr(saved_command_line, "udbg-immortel")) {
+		printk(KERN_INFO "console t=F4t immortel !\n");
+		return;
+	}
 	unregister_console(&udbg_console);
 	early_console_initialized =3D 0;
=2D#endif
 }
=20
 /* called by setup_system */
