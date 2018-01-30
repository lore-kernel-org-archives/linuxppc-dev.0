Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWNGr63PBzDqb6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 10:43:00 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0UNfbdE086458
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 18:42:56 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ftwesv2vw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 18:42:56 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 30 Jan 2018 23:42:53 -0000
Subject: Re: [PATCH] ocxl: fix signed comparison with less than zero
To: Colin King <colin.king@canonical.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180130151144.32544-1-colin.king@canonical.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 31 Jan 2018 10:42:47 +1100
MIME-Version: 1.0
In-Reply-To: <20180130151144.32544-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7960dfb3-3e56-5e22-548b-322e1c741495@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/01/18 02:11, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the comparison of used < 0 is always false because
> uses is a size_t. Fix this by making used a ssize_t type.
> 
> Detected by Coccinelle:
> drivers/misc/ocxl/file.c:320:6-10: WARNING: Unsigned expression
> compared with zero: used < 0
> 
> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for picking this up!

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/ocxl/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index c90c1a578d2f..1287e4430e6b 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -277,7 +277,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
>   	struct ocxl_context *ctx = file->private_data;
>   	struct ocxl_kernel_event_header header;
>   	ssize_t rc;
> -	size_t used = 0;
> +	ssize_t used = 0;
>   	DEFINE_WAIT(event_wait);
>   
>   	memset(&header, 0, sizeof(header));
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
