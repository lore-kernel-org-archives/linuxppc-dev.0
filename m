Date: Thu, 17 Jul 2003 16:36:02 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: sunrpc in 2.4 requires local_flush_tlb_page
Message-ID: <20030717143602.GA1522@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

the current 2.4 bk tree has an unresolved symbol:
/lib/modules/2.4.22-pre7/kernel/net/sunrpc/sunrpc.o
depmod:         local_flush_tlb_page

I think that happens only with CONFIG_HIGHMEM. net/sunrpm/xdr.c includes
linux/pagemap.h.
bh_kmap_irq() calls kmap_atomic(), which calls local_flush_tlb_page().

Is there a reason why local_flush_tlb_page is not exported?


Gruss Olaf

--
USB is for mice, FireWire is for men!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
