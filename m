Date: Sat, 20 Feb 1999 16:16:50 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: 601 vs head.S
Message-ID: <Pine.LNX.3.95.990220154008.23593A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


my quest is for a kernel that boots both on the 7200 and the imac. help me
out and i'll give you a free ppc601 card :)

i dug out my old 601 processor and verified that recent samba rsync
kernels won't boot on it. but the patch i have doesn't really help (it
only allows a few more lines of text to be printed before the inevitable
hang). does anyone have a patch that will make paul's kernel work on the
ppc601? 

without patch: 

Welcome to Linux, kernel 2.2.1
<hang>

with patch:

Welcome to Linux, kernel 2.2.1
started at ...
linked at ...
fb at...
MSR ...
<hang>

(here's the patch i have)

--- linux/arch/ppc/kernel/head.S        Fri Jan  8 18:27:01 1999
+++ linux.new/arch/ppc/kernel/head.S    Fri Jan  8 23:16:13 1999
@@ -1204,9 +1204,11 @@
 Hash_bits = 12                         /* e.g. 256kB hash table */
 Hash_msk = (((1 << Hash_bits) - 1) * 64)
        
+#ifdef __SMP__
        .globl  hash_table_lock
 hash_table_lock:
 .long  0
+#endif
        
        .globl  hash_page
 hash_page:


Brad
brad@pht.com | http:/www.pht.com/~brad/
Where do you want to go today..? the 9th floor





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
