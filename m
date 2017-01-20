Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4M0D3mvkzDqZ6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 11:24:28 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0K0NjjW101208
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 19:24:26 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2832afc26m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 19:24:25 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 19 Jan 2017 17:24:25 -0700
Subject: Re: [PATCH 3/8] powerpc/nvram: Move an assignment for the variable
 "ret" in dev_nvram_write()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Geliang Tang <geliangtang@163.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>
References: <53545d97-6ed5-ff17-384f-82e72b3592f9@users.sourceforge.net>
 <dcaccc31-99ac-ef90-cbef-79dbf72f0a4d@users.sourceforge.net>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 19 Jan 2017 16:24:17 -0800
MIME-Version: 1.0
In-Reply-To: <dcaccc31-99ac-ef90-cbef-79dbf72f0a4d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <52f46c9b-e049-7288-2c53-9c2525cd84c6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/19/2017 08:56 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 19 Jan 2017 15:55:36 +0100
> 
> A local variable was set to an error code before a concrete error situation
> was detected. Thus move the corresponding assignment into an if branch
> to indicate a software failure there.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/kernel/nvram_64.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index cf839adf3aa7..dc90a0e9ad65 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -806,9 +806,10 @@ static ssize_t dev_nvram_write(struct file *file, const char __user *buf,
>  	if (!tmp)
>  		return -ENOMEM;
> 
> -	ret = -EFAULT;
> -	if (copy_from_user(tmp, buf, count))
> +	if (copy_from_user(tmp, buf, count)) {
> +		ret = -EFAULT;
>  		goto out;
> +	}
>
>  	ret = ppc_md.nvram_write(tmp, count, ppos);
> 

I think you really could have squashed patches 1-3 into a single patch
that returns directly after any failure. After this 3rd patch this is
now the only spot that branches to the "out" label. At this point you
might as well remove that label and move the kfree(tmp) call up and
return directly after the failure and at the nvram_write() call site
doing away completely with the "ret" variable.

Something like the following patch:

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index d5e2b83..eadb55c 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -789,37 +789,29 @@ static ssize_t dev_nvram_read(struct file *file,
char __user *buf,
 static ssize_t dev_nvram_write(struct file *file, const char __user *buf,
                          size_t count, loff_t *ppos)
 {
-       ssize_t ret;
-       char *tmp = NULL;
+       char *tmp;
        ssize_t size;

-       ret = -ENODEV;
        if (!ppc_md.nvram_size)
-               goto out;
+               return -ENODEV;

-       ret = 0;
        size = ppc_md.nvram_size();
        if (*ppos >= size || size < 0)
-               goto out;
+               return 0;

        count = min_t(size_t, count, size - *ppos);
        count = min(count, PAGE_SIZE);

-       ret = -ENOMEM;
        tmp = kmalloc(count, GFP_KERNEL);
        if (!tmp)
-               goto out;
-
-       ret = -EFAULT;
-       if (copy_from_user(tmp, buf, count))
-               goto out;
-
-       ret = ppc_md.nvram_write(tmp, count, ppos);
+               return -ENOMEM;

-out:
-       kfree(tmp);
-       return ret;
+       if (copy_from_user(tmp, buf, count)) {
+               kfree(tmp);
+               return -EFAULT;
+       }

+       return ppc_md.nvram_write(tmp, count, ppos);
 }

 static long dev_nvram_ioctl(struct file *file, unsigned int cmd,
