Return-Path: <jstancek@redhat.com>
Received: from mx6-phx2.redhat.com (mx6-phx2.redhat.com [209.132.183.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stTZN4XylzDsmG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 18:46:04 +1100 (AEDT)
Date: Tue, 11 Oct 2016 03:45:56 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <835114866.189537.1476171956945.JavaMail.zimbra@redhat.com>
In-Reply-To: <87insz5tfs.fsf@concordia.ellerman.id.au>
References: <CAOJe8K0p60fmubbhSHCm0096CTjYjnnfoo_JLuwDcg6fo-=pBg@mail.gmail.com>
 <20161010115102.GA501@dustball.brq.redhat.com>
 <87insz5tfs.fsf@concordia.ellerman.id.au>
Subject: Re: ehea crash on boot
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>





----- Original Message -----
> From: "Michael Ellerman" <mpe@ellerman.id.au>
> To: "Jan Stancek" <jstancek@redhat.com>, "Denis Kirjanov" <kda@linux-powerpc.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Sent: Tuesday, 11 October, 2016 7:46:31 AM
> Subject: Re: ehea crash on boot
> 
> Jan Stancek <jstancek@redhat.com> writes:
> 
> > Hi Denis / all,
> >
> > Do you know if there is a patch or lead for this problem? I seem
> > to be hitting same Oops with P730 lpar when running 4.8 (see below),
> > but 4.7.7 looks OK.
> 
> Does this fix it?

Yes, it does. dmesg looks clean and network is up.

Regards,
Jan

> 
> cheers
> 
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c
> b/arch/powerpc/mm/hash_utils_64.c
> index 4cebc31e53de..4e83d872872d 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -526,7 +526,7 @@ static bool might_have_hea(void)
>  	 */
>  #ifdef CONFIG_IBMEBUS
>  	return !cpu_has_feature(CPU_FTR_ARCH_207S) &&
> -		!firmware_has_feature(FW_FEATURE_SPLPAR);
> +		firmware_has_feature(FW_FEATURE_SPLPAR);
>  #else
>  	return false;
>  #endif
> 
