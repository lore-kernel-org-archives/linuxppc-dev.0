From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: load_elf_bin problem
Date: Thu, 7 Aug 2003 09:22:23 -0400
Message-ID: <000101c35ce6$f060b910$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <OOEJKGLHOBHLNAIEBLEFAEMGKJAA.zjhzou@newrocktech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,

 The linux kernel boot up well till the last stage to call /bin/sh.
It crashes inside of load_elf_bin.
More specifically

   load_elf_bin()  --> setup_arg_pages() --> put_dirty_page();

Inisde of put_dirty_page() routing, it crashes at
   if (!pte_none(pte)) {

The program accesses pte->pte, but the address of pte->pte is not translated
to physical address properly.
So machine exception occurs, and the kernel crashes.

 Is it paging problem?
I turned L1 and L2 cache off because those have defects.
Does it cause any problem to paging mechanism?

 I'll appreciate your help.

 Dong-In


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
