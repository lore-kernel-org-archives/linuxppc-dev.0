Date: Tue, 11 May 2004 15:25:49 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] export clear_pages on ppc32
Message-ID: <20040511132549.GB4920@suse.de>
References: <20040510153624.GA9214@suse.de> <16544.1344.359606.598912@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <16544.1344.359606.598912@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Tue, May 11, Paul Mackerras wrote:

>
> Olaf Hering writes:
>
> > ext3 as module is not possible in 2.6.6, clear_pages, called from
> > clear_page, is not exported.
>
> clear_page is an inline function now, we should remove its export.

Good point:


diff -p -purN linux-2.6.6/arch/ppc/kernel/ppc_ksyms.c linux-2.6.6.ppc32/arch/ppc/kernel/ppc_ksyms.c
--- linux-2.6.6/arch/ppc/kernel/ppc_ksyms.c     2004-05-10 04:33:19.000000000 +0200
+++ linux-2.6.6.ppc32/arch/ppc/kernel/ppc_ksyms.c       2004-05-11 15:24:57.000000000 +0200
@@ -72,7 +72,7 @@ int abs(int);

 extern unsigned long mm_ptov (unsigned long paddr);

-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(clear_user_page);
 EXPORT_SYMBOL(do_signal);
 EXPORT_SYMBOL(do_syscall_trace);


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
