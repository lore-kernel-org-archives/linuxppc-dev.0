Return-Path: <srs0=pzjm=em=linux.vnet.ibm.com=fbarrat@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLyJy6600zF0fF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 17:45:38 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zLyJy3w8Mz8wTK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 17:45:38 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zLyJx6rlDz9sDB
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 17:45:37 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0H6iOjR062726
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 01:45:35 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fhxxcwq56-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 01:45:35 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 17 Jan 2018 06:45:33 -0000
Subject: Re: [PATCH 1/2] powerpc: export thread-tidr interfaces
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
References: <1516153832-9282-1-git-send-email-sukadev@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 17 Jan 2018 07:45:29 +0100
MIME-Version: 1.0
In-Reply-To: <1516153832-9282-1-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <eff03efa-0637-c63a-a7ee-320c490cff9d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 2010e4c..f20c1ad 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1560,6 +1560,7 @@ void clear_thread_tidr(struct task_struct *t)
>   	free_thread_tidr(t->thread.tidr);
>   	t->thread.tidr = 0;
>   }
> +EXPORT_SYMBOL_GPL(clear_thread_tidr);

Isn't it dangerous to export clear_thread_tidr()? Other modules may also 
have assigned the TIDR by calling set_thread_tidr(), so clearing it 
could potentially break those other modules. My understanding is that 
once the TIDR is assigned, there's no safe way to reclaim it other than 
the thread exiting. Or we would need some kind of reference counter.


>   void arch_release_task_struct(struct task_struct *t)
>   {
> @@ -1592,6 +1593,7 @@ int set_thread_tidr(struct task_struct *t)
> 
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(set_thread_tidr);


FYI, there's a capi patch we hope to merge soon which is also doing this:
http://patchwork.ozlabs.org/patch/858935/

   Fred
