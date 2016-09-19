Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sd91B3lklzDsdP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 01:34:38 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8JFXWk6116682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 11:34:35 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25h1q5k77s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 11:34:35 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 09:34:33 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id ADE0E19D8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:33:59 -0600 (MDT)
Subject: Re: [PATCH] powerpc/pseries: fix memory leak in queue_hotplug_event()
 error path
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20160919064132.28760-1-andrew.donnellan@au1.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 10:34:27 -0500
MIME-Version: 1.0
In-Reply-To: <20160919064132.28760-1-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <bbba5a34-37b5-1429-72bf-9d8cf7e2c803@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/19/2016 01:41 AM, Andrew Donnellan wrote:
> If we fail to allocate work, we don't end up using hp_errlog_copy. Free it
> in the error path.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> 
> ---
> 
> Found by Coverity Scan. Compile tested only.
> ---
>  arch/powerpc/platforms/pseries/dlpar.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 4748124..6a99e72 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -413,6 +413,7 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
>  		queue_work(pseries_hp_wq, (struct work_struct *)work);
>  	} else {
>  		*rc = -ENOMEM;
> +		kfree(hp_errlog_copy);
>  		complete(hotplug_done);
>  	}
>  }
> 
