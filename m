Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkY5b1ktYzDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 16:57:54 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v596rj71051338
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 02:57:52 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ayn0mm7c3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Jun 2017 02:57:52 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 07:57:50 +0100
Subject: Re: [PATCH v2] cxl: Fix error path on bad ioctl
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, philippe.bergheaud@fr.ibm.com
References: <20170606094341.14629-1-fbarrat@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Fri, 9 Jun 2017 08:57:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170606094341.14629-1-fbarrat@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------0BDB1BA279AAF81BC964B3E8"
Message-Id: <0f220372-98c7-7138-a8c7-8b77f9bd077a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------0BDB1BA279AAF81BC964B3E8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: christophe lombard <clombard@linux.vnet.ibm.com>


Le 06/06/2017 à 11:43, Frederic Barrat a écrit :
> Fix error path if we can't copy user structure on CXL_IOCTL_START_WORK
> ioctl. We shouldn't unlock the context status mutex as it was not
> locked (yet).
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")
> ---
> Changelog:
> v2: change sizeof() parameter (Vaibhav)
>      tweak commit message and add 'Fixes:' (mpe)
>      
>   drivers/misc/cxl/file.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 17b433f1ce23..0761271d68c5 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -159,11 +159,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>
>   	/* Do this outside the status_mutex to avoid a circular dependency with
>   	 * the locking in cxl_mmap_fault() */
> -	if (copy_from_user(&work, uwork,
> -			   sizeof(struct cxl_ioctl_start_work))) {
> -		rc = -EFAULT;
> -		goto out;
> -	}
> +	if (copy_from_user(&work, uwork, sizeof(work)))
> +		return -EFAULT;
>
>   	mutex_lock(&ctx->status_mutex);
>   	if (ctx->status != OPENED) {



--------------0BDB1BA279AAF81BC964B3E8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Reviewed-by: christophe lombard <a
        class="moz-txt-link-rfc2396E"
        href="mailto:clombard@linux.vnet.ibm.com">&lt;clombard@linux.vnet.ibm.com&gt;</a><br>
      <br>
      <br>
      Le 06/06/2017 à 11:43, Frederic Barrat a écrit :<br>
    </div>
    <blockquote type="cite"
      cite="mid:20170606094341.14629-1-fbarrat@linux.vnet.ibm.com">
      <pre wrap="">Fix error path if we can't copy user structure on CXL_IOCTL_START_WORK
ioctl. We shouldn't unlock the context status mutex as it was not
locked (yet).

Signed-off-by: Frederic Barrat <a class="moz-txt-link-rfc2396E" href="mailto:fbarrat@linux.vnet.ibm.com">&lt;fbarrat@linux.vnet.ibm.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")
---
Changelog:
v2: change sizeof() parameter (Vaibhav)
    tweak commit message and add 'Fixes:' (mpe)
    
 drivers/misc/cxl/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 17b433f1ce23..0761271d68c5 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -159,11 +159,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,

 	/* Do this outside the status_mutex to avoid a circular dependency with
 	 * the locking in cxl_mmap_fault() */
-	if (copy_from_user(&amp;work, uwork,
-			   sizeof(struct cxl_ioctl_start_work))) {
-		rc = -EFAULT;
-		goto out;
-	}
+	if (copy_from_user(&amp;work, uwork, sizeof(work)))
+		return -EFAULT;

 	mutex_lock(&amp;ctx-&gt;status_mutex);
 	if (ctx-&gt;status != OPENED) {
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------0BDB1BA279AAF81BC964B3E8--
