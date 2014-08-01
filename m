Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D939D1A07E6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Aug 2014 03:07:34 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Fri, 1 Aug 2014 13:07:31 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3DEE86E8047
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 13:07:17 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s71H7R1f2949446
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Aug 2014 17:07:27 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s71H7QT7003253
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Aug 2014 13:07:26 -0400
Message-ID: <53DBC94D.20705@linux.vnet.ibm.com>
Date: Fri, 01 Aug 2014 12:07:25 -0500
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fixing endianness of flash_block_list in
 rtas_flash
References: <1406310462-23005-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <53DB5EC5.5000703@linux.vnet.ibm.com>
In-Reply-To: <53DB5EC5.5000703@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 08/01/2014 04:32 AM, Vasant Hegde wrote:
> On 07/25/2014 11:17 PM, Thomas Falcon wrote:
>> The function rtas_flash_firmware passes the address of a data structure,
>> flash_block_list, when making the update-flash-64-and-reboot rtas call.
>> While the endianness of the address is handled correctly, the endianness
>> of the data is not.  This patch ensures that the data in 
>> flash_block_list
>> is big endian when passed to rtas on little endian hosts.
>>
>> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/kernel/rtas_flash.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>
> Tom,
>
> In validate_flash rtas call returns  update_results in BE.. I think we 
> need below changes as well.
>
> Rest looks good.
>
> diff --git a/arch/powerpc/kernel/rtas_flash.c 
> b/arch/powerpc/kernel/rtas_flash.c
> index db2b482..1eae0d8 100644
> --- a/arch/powerpc/kernel/rtas_flash.c
> +++ b/arch/powerpc/kernel/rtas_flash.c
> @@ -449,7 +449,7 @@ error:
>  static void validate_flash(struct rtas_validate_flash_t *args_buf)
>  {
>         int token = rtas_token("ibm,validate-flash-image");
> -       int update_results;
> +       __be32 update_results;
>         s32 rc;
>
>         rc = 0;
> @@ -463,7 +463,7 @@ static void validate_flash(struct 
> rtas_validate_flash_t *args_buf)
>         } while (rtas_busy_delay(rc));
>
>         args_buf->status = rc;
> -       args_buf->update_results = update_results;
> +       args_buf->update_results = be32_to_cpu(update_results);
>  }
>
I do not think this conversion is needed.  Any integers returned are 
converted to cpu endian in the rtas_call function.

tom
>
> -Vasant
>

-- 
