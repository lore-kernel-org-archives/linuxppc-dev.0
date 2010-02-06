Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: anton@samba.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Serge Hallyn <serue@us.ibm.com>,
	WANG Cong <xiyou.wangcong@gmail.com>,
	Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org
MIME-Version: 1.0
Subject: Stack size protection broken on ppc64
Date: Sat, 06 Feb 2010 11:43:13 +1100
Message-ID: <3984.1265416993@neuling.org>
Cc: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On recent ppc64 kernels, limiting the stack (using 'ulimit -s blah') is
now more restrictive than it was before.  On 2.6.31 with 4k pages I
could run 'ulimit -s 16; /usr/bin/test' without a problem.  Now with
mainline, even 'ulimit -s 64; /usr/bin/test' gets killed.

Using 64k pages is even worse.  I can't even run '/bin/ls' with a 1MB
stack (ulimit -s 1024; /bin/ls).  Hence, it seems new kernels are too
restrictive, rather than the old kernels being too liberal.

I've not tested with any other architectures.  

Bisecting, I found that this is the culprit (which is in 2.6.32)

  commit fc63cf237078c86214abcb2ee9926d8ad289da9b
  Author: Anton Blanchard <anton@samba.org>
  exec:   setup_arg_pages() fails to return errors

Looking at the patch, it's probably just unmasking a preexisting issue.
The error path for expand_stack() (and others) was modified to:
---
	ret = expand_stack(vma, stack_base);
	if (ret)
		ret = -EFAULT;

out_unlock:
	up_write(&mm->mmap_sem);
-       return 0;
+       return ret;
 }
 EXPORT_SYMBOL(setup_arg_pages);
---

So previously expand_stack errors were not returned correctly by
setup_arg_pages, but now they are.

Any clues how to fix this?

Mikey
