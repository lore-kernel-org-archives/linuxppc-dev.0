Date: Mon, 22 Jul 2002 13:45:25 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: More ioremap trouble (sock_recvmsg)
Message-ID: <20020722134525.A588@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Hmm, I'm *still* having trouble with ioremap on powerpc,
but at least it's different trouble.  (It still works fine on x86).

Here's the situation:  IBM ebony (440) board w/ 128Mb RAM.
Boot kernel with "mem=64M", then use ioremap to access the
unused 64M RAM.

	ioremapped_buffer = ioremap(1024*1024*64, 1024*1024*64);

I'm able to DMA between this memory and a PCI device, although
I have to do virtual-physical address translation myself (pci_map_single
won't do it, virt_to_phys just subtracts C-zillion, turns out wrong, since
I ioremapped the memory myself, the translation is trivial.)

I can also memset()/memcpy() to/from this ioremapped_buffer just fine.

I'm trying to use sock_recvmsg to receive into this ioremapped buffer.
It works, sometimes, but crashes inside __copy_tofrom_user eventually.
It does not appear to always do the exact same thing.  This could be due to
the network making things behave differently, I suppose.)  The iovec
that I used with sock_recvmsg has just one entry, the address, which is
ioremapped_buffer (or some offset from it) and a length.

I tried a sledgehammer approach, replacing copy_to_user with memcpy
when I know the address in question can work that way.

Index: iovec.c
===================================================================
RCS file: /linuxcvs/slipstream/sslinux/net/core/iovec.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 iovec.c
--- iovec.c	28 May 2002 16:03:31 -0000	1.1.1.1
+++ iovec.c	22 Jul 2002 16:04:48 -0000
@@ -78,7 +78,7 @@
  *
  *	Note: this modifies the original iovec.
  */
-
+extern unsigned char *ioremapped_buffer;
 int memcpy_toiovec(struct iovec *iov, unsigned char *kdata, int len)
 {
 	int err = -EFAULT;
@@ -88,8 +88,14 @@
 		if(iov->iov_len)
 		{
 			int copy = min_t(unsigned int, iov->iov_len, len);
-			if (copy_to_user(iov->iov_base, kdata, copy))
+			if (ioremapped_buffer != NULL &&
+				iov->iov_base >= ioremapped_buffer &&
+				iov->iov_base <=
+					(ioremapped_buffer + 64*1024*1024))
+				memcpy(iov->iov_base, kdata, copy);
+			else if (copy_to_user(iov->iov_base, kdata, copy)) {
 				goto out;
+			}
 			kdata+=copy;
 			len-=copy;
 			iov->iov_len-=copy;

(not sure why it's using copy_to_user anyway... I guess probably
normally this is entered from user context via a recv() system call,
in my case, not so, I come here from a kernel thread in a module...):

So this patch makes it work considerably longer.  However, again it crashes
inside __copy_tofrom_user, eventually (in a different call).  I'm
thinking maybe I can continue in a similar vein, replacing more
copy_to_user() calls with memcpy, but this strikes me as being
inelegant, and I wonder if I'm doing something wrong with my ioremap...

or, is sock_recvmsg designed to be called only from process context
(e.g. not a kernel thread)?  If so, then why does it work on x86
but not powerpc?

Thanks,

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
