Date: Fri, 10 Oct 2003 01:13:28 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] incorrect extern declarations
Message-ID: <20031009231328.GA2330@suse.de>
References: <20030914194038.GA19676@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20030914194038.GA19676@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Sun, Sep 14, Olaf Hering wrote:

>
> both variables are declared static earlier in the file. gcc3.4 doesnt
> tolerated the extern anymore.
>
> --- linux-2.4.23-pre4/arch/ppc/platforms/prep_pci.c~	2003-08-25 13:44:40.000000000 +0200
> +++ linux-2.4.23-pre4/arch/ppc/platforms/prep_pci.c	2003-09-14 17:36:54.000000000 +0200
> @@ -1141,8 +1141,6 @@ void __init
>  prep_pcibios_fixup(void)
>  {
>          struct pci_dev *dev;
> -        extern unsigned char *Motherboard_map;
> -        extern unsigned char *Motherboard_routes;
>
>  	prep_route_pci_interrupts();

This fixes another bug. __bss_start is declared twice.


diff -p -purN linux-2.4.22/arch/ppc/kernel/setup.c linux-2.4.23-pre6-irda-gcc34/arch/ppc/kernel/setup.c
--- linux-2.4.22/arch/ppc/kernel/setup.c	2003-10-06 17:50:07.000000000 +0200
+++ linux-2.4.23-pre6-irda-gcc34/arch/ppc/kernel/setup.c	2003-10-09 21:51:58.000000000 +0200
@@ -258,7 +258,7 @@ __init
 unsigned long
 early_init(int r3, int r4, int r5)
 {
-	extern char __bss_start, _end;
+	extern char __bss_start[], _end[];
  	unsigned long phys;
 	unsigned long offset = reloc_offset();

@@ -267,7 +267,7 @@ early_init(int r3, int r4, int r5)

 	/* First zero the BSS -- use memset, some arches don't have
 	 * caches on yet */
-	memset_io(PTRRELOC(&__bss_start), 0, &_end - &__bss_start);
+	memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start);

 	/*
 	 * Identify the CPU type and fix up code sections
diff -p -purN linux-2.4.22/arch/ppc/platforms/prep_pci.c linux-2.4.23-pre6-irda-gcc34/arch/ppc/platforms/prep_pci.c
--- linux-2.4.22/arch/ppc/platforms/prep_pci.c	2003-08-25 13:44:40.000000000 +0200
+++ linux-2.4.23-pre6-irda-gcc34/arch/ppc/platforms/prep_pci.c	2003-10-09 21:54:33.000000000 +0200
@@ -1141,8 +1141,6 @@ void __init
 prep_pcibios_fixup(void)
 {
         struct pci_dev *dev;
-        extern unsigned char *Motherboard_map;
-        extern unsigned char *Motherboard_routes;

 	prep_route_pci_interrupts();

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
