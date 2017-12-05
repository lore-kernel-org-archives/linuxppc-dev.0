Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrqSx6G6DzDrqK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 05:06:55 +1100 (AEDT)
Date: Tue, 5 Dec 2017 18:06:50 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, mpe <mpe@ellerman.id.au>,
 sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [linux-next][41e83b9][gcc 4.8.5] make modules fail at
 net/netfilter/xt_bpf.ko
Message-ID: <20171205180650.GV21978@ZenIV.linux.org.uk>
References: <1512484991.13113.11.camel@abdul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512484991.13113.11.camel@abdul>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 05, 2017 at 08:13:11PM +0530, Abdul Haleem wrote:
> Hi Al Viro,
> 
> Today's next kernel build failed with commit 41e83b9: fix "netfilter:
> xt_bpf: Fix XT_BPF_MODE_FD_PINNED
> 
> Machine Type: Power 7
> kernel version: 4.15.0-rc2-next-20171204
> kernel config: attached
> test: 'make modules'
> 
> ERROR: ".bpf_prog_get_type_path" [net/netfilter/xt_bpf.ko] undefined!
> 
> Kernel built fine when bad commit is reverted.

In the same commit there's

+EXPORT_SYMBOL(bpf_prog_get_type_path);

so I really wonder WTF is going on...

Oh, I see.  !BPF_SYSCALL and NETFILTER_XT_MATCH_BPF in .config triggers
that.  Incremental (to be folded into the commit in question) follows:

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a7000e4775e7..571450f98006 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -419,6 +419,8 @@ static inline int bpf_map_attr_numa_node(const union bpf_attr *attr)
 		attr->numa_node : NUMA_NO_NODE;
 }
 
+struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type type);
+
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -506,6 +508,12 @@ static inline int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu,
 {
 	return 0;
 }
+
+static inline struct bpf_prog *bpf_prog_get_type_path(const char *name,
+				enum bpf_prog_type type)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 
 static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
@@ -514,7 +522,6 @@ static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
 	return bpf_prog_get_type_dev(ufd, type, false);
 }
 
-struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type type);
 bool bpf_prog_get_ok(struct bpf_prog *, enum bpf_prog_type *, bool);
 
 int bpf_prog_offload_compile(struct bpf_prog *prog);
