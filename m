Return-Path: <haveblue@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A6F4DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 21:12:26 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1BACNd5030936
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 05:12:23 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1BACN15201592
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 05:12:23 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1BACMx1012653
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 05:12:22 -0500
Subject: Re: [PATCH][RESEND] drivers/base: export (un)register_memory_notifier
From: Dave Hansen <haveblue@us.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200802111049.05478.ossthema@de.ibm.com>
References: <200802111049.05478.ossthema@de.ibm.com>
Content-Type: text/plain
Date: Mon, 11 Feb 2008 02:12:23 -0800
Message-Id: <1202724743.8276.2.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Cc: Jan-Bernd Themann <themann@de.ibm.com>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-02-11 at 10:49 +0100, Jan-Bernd Themann wrote:
> are you the right person to address this patch to?

You might want to check the top of the file. ;)

> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -52,11 +52,13 @@ int register_memory_notifier(struct notifier_block *nb)
>  {
>          return blocking_notifier_chain_register(&memory_chain, nb);
>  }
> +EXPORT_SYMBOL(register_memory_notifier);
>  
>  void unregister_memory_notifier(struct notifier_block *nb)
>  {
>          blocking_notifier_chain_unregister(&memory_chain, nb);
>  }
> +EXPORT_SYMBOL(unregister_memory_notifier);

Is there a particular reason these can't be GPL?

-- Dave
