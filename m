Return-Path: <vova-ks@yandex.ru>
Received: from dgap-gw.mipt.ru (dgap-gw.mipt.ru [194.85.81.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dgap.mipt.ru",
	Issuer "DGAP Root Certificate" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D28272BE83
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Nov 2004 22:09:35 +1100 (EST)
Received: from unknown (HELO localhost) ([127.0.0.1])
	(envelope-sender <vova-ks@yandex.ru>)
	by localhost (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 3 Nov 2004 11:09:31 -0000
Received: from dgap-gw.mipt.ru ([127.0.0.1])
	by localhost (dgap-gw.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10492-02 for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Nov 2004 14:09:30 +0300 (MSK)
From: Vladimir <vova-ks@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 3 Nov 2004 14:10:05 +0300
References: <200411020354.39610.vova-ks@yandex.ru>
	<200411022224.11540.vova-ks@yandex.ru>
	<20041102221737.GA28292@xyzzy>
In-Reply-To: <20041102221737.GA28292@xyzzy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411031410.05780.vova-ks@yandex.ru>
Subject: Re: Problem with user-space programs on 405GP: linux 2.6 oops
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks a lot. It helps.

-- 
         Vladimir

On Wednesday 03 November 2004 01:17, Dale Farnsworth wrote:
> I suspect you're missing this patch, which is in the current tree.
>
> -Dale
>
> ===== setup.c 1.59 vs 1.60 =====
> --- 1.59/arch/ppc/kernel/setup.c 2004-07-26 15:27:53 -07:00
> +++ 1.60/arch/ppc/kernel/setup.c 2004-08-16 09:04:08 -07:00
> @@ -744,6 +744,10 @@
>   if ( ppc_md.progress ) ppc_md.progress("ocp: exit", 0x3eab);
>  #endif
>
> +#ifdef CONFIG_DUMMY_CONSOLE
> + conswitchp = &dummy_con;
> +#endif
> +
>   ppc_md.setup_arch();
>   if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
>

-- 
         Vladimir
