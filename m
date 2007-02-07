Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E25A9DDF42
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:42:06 +1100 (EST)
Date: Thu, 8 Feb 2007 10:42:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: will_schmidt@vnet.ibm.com
Subject: Re: patches in powerpc.git
Message-Id: <20070208104234.e85e07cc.sfr@canb.auug.org.au>
In-Reply-To: <1170866310.6619.55.camel@localhost>
References: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
	<20070207155515.be5d0d5e.sfr@canb.auug.org.au>
	<1170866310.6619.55.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 07 Feb 2007 10:38:30 -0600 Will Schmidt <will_schmidt@vnet.ibm.com> wrote:
>
> On Wed, 2007-07-02 at 15:55 +1100, Stephen Rothwell wrote:
> > On Wed, 7 Feb 2007 15:03:13 +1100 Paul Mackerras <paulus@samba.org> wrote:
> > >
> > > If anyone has patches not listed here that they want in 2.6.21, please
> > > let me or the relevant sub-arch maintainer know.
> > 
> > How about "Fix ppc64's writing to struct file_operations" sent to you
> > yesterday by Andrew Morton.
> > 
> 
> Is this the lparcfg fops .write changes that came across LKML
> mid-January?    I didnt notice any references to it here.. 

Yep.  Copy below.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

Subject: [patch 03/10] Fix ppc64's writing to struct file_operations
To: paulus@samba.org
Cc: benh@kernel.crashing.org, akpm@linux-foundation.org, sfr@canb.auug.org.au,
   arjan@infradead.org
From: akpm@linux-foundation.org
Date: Mon, 05 Feb 2007 16:14:05 -0800

From: Stephen Rothwell <sfr@canb.auug.org.au>

In preparation for marking file_operations as const.

Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/kernel/lparcfg.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff -puN arch/powerpc/kernel/lparcfg.c~fix-ppc64s-writing-to-struct-file_operations arch/powerpc/kernel/lparcfg.c
--- a/arch/powerpc/kernel/lparcfg.c~fix-ppc64s-writing-to-struct-file_operations
+++ a/arch/powerpc/kernel/lparcfg.c
@@ -439,6 +439,10 @@ static ssize_t lparcfg_write(struct file
 
 	ssize_t retval = -ENOMEM;
 
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR) ||
+			firmware_has_feature(FW_FEATURE_ISERIES))
+		return -EINVAL;
+
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		goto out;
@@ -517,7 +521,7 @@ static int pseries_lparcfg_data(struct s
 static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 			     size_t count, loff_t * off)
 {
-	return count;
+	return -EINVAL;
 }
 
 #endif				/* CONFIG_PPC_PSERIES */
@@ -570,6 +574,7 @@ static int lparcfg_open(struct inode *in
 struct file_operations lparcfg_fops = {
 	.owner		= THIS_MODULE,
 	.read		= seq_read,
+	.write		= lparcfg_write,
 	.open		= lparcfg_open,
 	.release	= single_release,
 };
@@ -581,10 +586,8 @@ int __init lparcfg_init(void)
 
 	/* Allow writing if we have FW_FEATURE_SPLPAR */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR) &&
-			!firmware_has_feature(FW_FEATURE_ISERIES)) {
-		lparcfg_fops.write = lparcfg_write;
+			!firmware_has_feature(FW_FEATURE_ISERIES))
 		mode |= S_IWUSR;
-	}
 
 	ent = create_proc_entry("ppc64/lparcfg", mode, NULL);
 	if (ent) {
_
