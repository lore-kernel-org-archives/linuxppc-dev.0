Return-Path: <mhocko@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWQdV2cmDzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 21:29:00 +1100 (AEDT)
Date: Tue, 7 Nov 2017 11:28:54 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [linux-next][0692229e] next-20171106 fails to boot on Power 7
Message-ID: <20171107102854.vylrtaodla63kc57@dhcp22.suse.cz>
References: <1510048229.12079.7.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510048229.12079.7.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 07-11-17 15:20:29, Abdul Haleem wrote:
> Hi,
> 
> Today's next kernel fails to boot on Power 7 Machine with below errors
> in boot log messages.
> 
> 'Uhuuh, elf segement at 0000000010040000 requested but the memory is
> mapped already'
> 
> It was introduced with commit:
> 
> 0692229e : fs/binfmt_elf.c: drop MAP_FIXED usage from elf_map

Weird. Clashes shouldn't really happen. Maybe power is doing something
different from other platforms. Could you apply the following debugging
patch to see what is going on there?
---
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 0abc30d681ae..f098aaf60039 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -361,8 +361,28 @@ static unsigned long elf_vm_mmap(struct file *filep, unsigned long addr,
 		return map_addr;
 
 	if ((type & MAP_FIXED) && map_addr != addr) {
-		pr_info("Uhuuh, elf segement at %p requested but the memory is mapped already\n",
-				(void*)addr);
+		struct mm_struct *mm = current->mm;
+		struct vm_area_struct *vma;
+		pr_info("Uhuuh, elf segement at %p requested but the memory is mapped already, got %p\n",
+				(void*)addr, (void*)map_addr);
+		down_read(&mm->mmap_sem);
+		vma = find_vma(mm, addr);
+		if (vma) {
+			const char *name;
+			pr_info("Clashing vma [%lx, %lx] flags:%lx", vma->vm_start, vma->vm_end, vma->vm_flags);
+			name = arch_vma_name(vma);
+			if (!name) {
+				if (vma->vm_start <= mm->brk &&
+				    vma->vm_end >= mm->start_brk)
+					name = "[heap]";
+				else if (vma->vm_start <= vma->vm_mm->start_stack &&
+						vma->vm_end >= vma->vm_mm->start_stack)
+					name = "[stack]";
+			}
+			pr_cont(" name:%s\n", name);
+		} else
+			pr_info("Uhm, no clashing VMA\n");
+		up_read(&mm->mmap_sem);
 		return -EAGAIN;
 	}
 

-- 
Michal Hocko
SUSE Labs
