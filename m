Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id CEC5BDDFDB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 04:49:29 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so693918ugf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 11:49:27 -0700 (PDT)
Message-ID: <528646bc0704271149w211bd5cbscb467123ab962703@mail.gmail.com>
Date: Fri, 27 Apr 2007 12:49:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Peter Korsgaard" <peter.korsgaard@barco.com>
Subject: Re: [PATCH 2/5] [PPC] Merge common virtex header files
In-Reply-To: <87d51sac8l.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<87d51sac8l.fsf@sleipner.barco.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/25/07, Peter Korsgaard <peter.korsgaard@barco.com> wrote:
> >>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:
> GL> -#if defined(CONFIG_XILINX_ML300)
> GL> -#include <platforms/4xx/xilinx_ml300.h>
> GL> -#endif
> GL> -
> GL> -#if defined(CONFIG_XILINX_ML403)
> GL> -#include <platforms/4xx/xilinx_ml403.h>
> GL> +#if defined(CONFIG_XILINX_VIRTEX)
> GL> +#include <platforms/4xx/virtex.h>
> GL>  #endif
>
> Could we make that
>
> #if defined(CONFIG_XILINX_ML300) || defined(CONFIG_XILINX_ML403)
>
> instead? I'm using RedBoot on a virtex platform, and hence another
> struct bd_info than the ML300/ML403.

Alternate suggestion: Can we change virtex support to use the
structure defined in ppcboot.h instead?  (I've actually got that
change in my tree and was planning on posting it for review today or
tomorrow).  bd_t is a stinking ugly mess, but things would be better
if we standardize all virtex platforms on the stinking ugly mess
shared by almost all the other ppc embedded board ports.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
