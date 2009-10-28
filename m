Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2C361B7B76
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2009 13:14:00 +1100 (EST)
Date: Wed, 28 Oct 2009 13:13:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mundt <lethal@linux-sh.org>
Subject: linux-next: manual merge of the sh tree with the powerpc-merge tree
Message-Id: <20091028131356.7a6ba355.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

Today's linux-next merge of the sh tree got a conflict in fs/Kconfig
between commit 0cd9ad73b8d181737005ff4e506b9b6bd043f4dd ("powerpc: Limit
hugetlbfs support to PPC64 Book-3S machines") from the powerpc-merge tree
and commit ffb4a73d8906f71910e6c83ec2b499e70025ee8e ("sh: Fix hugetlbfs
dependencies for SH-3 && MMU configurations") from the sh tree.

I fixed it up (see below) and can carry the fix for a while (the
powerpc-merge commit should be in Linus' tree soon).
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc fs/Kconfig
index f93d0ed,48b81f9..0000000
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@@ -135,8 -135,8 +135,8 @@@ config TMPFS_POSIX_AC
  
  config HUGETLBFS
  	bool "HugeTLB file system support"
- 	depends on X86 || IA64 || PPC_BOOK3S_64 || SPARC64 || (SUPERH && MMU) || \
 -	depends on X86 || IA64 || PPC64 || SPARC64 || (S390 && 64BIT) || \
 -		   SYS_SUPPORTS_HUGETLBFS || BROKEN
++	depends on X86 || IA64 || PPC_BOOK3S_64 || SPARC64 || \
 +		   (S390 && 64BIT) || SYS_SUPPORTS_HUGETLBFS || BROKEN
  	help
  	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
  	  ramfs. For architectures that support it, say Y here and read
