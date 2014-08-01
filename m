Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 92EDF1A01A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 19:33:02 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 1 Aug 2014 15:02:59 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4B04A125801C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 15:02:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s719XEFI52035604
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Aug 2014 15:03:15 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s719Wres023933
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Aug 2014 15:02:53 +0530
Message-ID: <53DB5EC5.5000703@linux.vnet.ibm.com>
Date: Fri, 01 Aug 2014 15:02:53 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fixing endianness of flash_block_list in
 rtas_flash
References: <1406310462-23005-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1406310462-23005-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2014 11:17 PM, Thomas Falcon wrote:
> The function rtas_flash_firmware passes the address of a data structure,
> flash_block_list, when making the update-flash-64-and-reboot rtas call.
> While the endianness of the address is handled correctly, the endianness
> of the data is not.  This patch ensures that the data in flash_block_list
> is big endian when passed to rtas on little endian hosts.
>
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/rtas_flash.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>

Tom,

In validate_flash rtas call returns  update_results in BE.. I think we need 
below changes as well.

Rest looks good.

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index db2b482..1eae0d8 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -449,7 +449,7 @@ error:
  static void validate_flash(struct rtas_validate_flash_t *args_buf)
  {
         int token = rtas_token("ibm,validate-flash-image");
-       int update_results;
+       __be32 update_results;
         s32 rc;

         rc = 0;
@@ -463,7 +463,7 @@ static void validate_flash(struct rtas_validate_flash_t 
*args_buf)
         } while (rtas_busy_delay(rc));

         args_buf->status = rc;
-       args_buf->update_results = update_results;
+       args_buf->update_results =  be32_to_cpu(update_results);
  }


-Vasant
