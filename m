Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DCD2B68077
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Sep 2005 15:46:06 +1000 (EST)
Date: Sun, 4 Sep 2005 22:46:03 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050905054603.GA6341@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] discard *.exit.text and *.exit.data sections
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Discard *.exit.text sections on runtime. We cannot do this on link 
time because of the way BUG macros are implemented. If "__exit 
function" calls one of those macros, __bug_table section will 
reference this function. This is similar to ".altinstructions" 
situation on i386.

*.exit.data seems to be OK in this respect and is discarded on link 
time.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/kernel/vmlinux.lds.S b/arch/ppc/kernel/vmlinux.lds.S
--- a/arch/ppc/kernel/vmlinux.lds.S
+++ b/arch/ppc/kernel/vmlinux.lds.S
@@ -96,6 +96,9 @@ SECTIONS
 	*(.init.text)
 	_einittext = .;
   }
+  /* .exit.text is discarded at runtime, not link time, 
+     to deal with references from __bug_table */
+  .exit.text : { *(.exit.text) }  
   .init.data : {
     *(.init.data);
     __vtop_table_begin = .;
@@ -190,5 +193,6 @@ SECTIONS
   /* Sections to be discarded. */
   /DISCARD/ : {
     *(.exitcall.exit)
+    *(.exit.data)
   }
 }
