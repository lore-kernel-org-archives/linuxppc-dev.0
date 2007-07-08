Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 77ACCDE20E
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 10:48:55 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so786747wag
	for <linuxppc-dev@ozlabs.org>; Sat, 07 Jul 2007 17:48:54 -0700 (PDT)
Message-ID: <fa686aa40707071748g7f00f4c7jb761cceb7d72456d@mail.gmail.com>
Date: Sat, 7 Jul 2007 18:48:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jcrigby@gmail.com>
Subject: Re: [PATCH] Add USB support to mpc8349-mitx board port
In-Reply-To: <4b73d43f0707071734yeedd7e6g53101d45fbec899e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070706222909.19943.39455.stgit@trillian.secretlab.ca>
	<200707070148.20526.arnd@arndb.de>
	<fa686aa40707062246j71a347acje8559b7b6be9d38b@mail.gmail.com>
	<4b73d43f0707071734yeedd7e6g53101d45fbec899e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, paulus@samba.org,
	Timur Tabi <timur@freescale.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/7/07, John Rigby <jcrigby@gmail.com> wrote:
> > This same comment probably goes for the other arch_initcall functions
> > in fsl_soc.c which do exactly the same thing for other devices.
>
> This depends,  some devices in fsl_soc.c may exist on non-powerpc SoCs
> that do not have OF.  The USB core in 8349 for example also is in the
> arm based mx27 and mx31.  These devices should remain platform devices
> and the glue in fls_soc.c will continure to be needed.

I disagree; the current method is "glue for the glue".  There is no
reason why the driver cannot have two bindings; one for
platform_device and one for of_platform_device.  It's about the same
amount of code, but uses less indirection for the device tree case.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
