Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3B929DE35F
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 00:13:35 +1000 (EST)
Message-ID: <48036649.6000409@freescale.com>
Date: Mon, 14 Apr 2008 09:12:25 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
References: <12053582234100-git-send-email-yorksun@freescale.com>	<12053582231281-git-send-email-yorksun@freescale.com>	<47D8572C.8090501@gmail.com>	<47FFDBFF.1030809@gmail.com>
	<20080411221817.0b1eb414.akpm@linux-foundation.org>
	<48035E93.6070300@freescale.com> <48035F98.1020404@gmail.com>
	<48036001.10905@freescale.com> <4803620C.6020905@gmail.com>
In-Reply-To: <4803620C.6020905@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	York Sun <yorksun@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jiri Slaby wrote:
> On 04/14/2008 03:45 PM, Timur Tabi wrote:
>> Jiri Slaby wrote:
>>
>>> See
>>> http://lkml.org/lkml/2008/3/12/375
>> That email is dated 3/12 and those comments are about v1 of the patch.  The most
>> recent posted version is v5 and it addresses all these issues.  See
>> http://lkml.org/lkml/2008/4/1/346
> 
> Ok, how is the sleep-inside-spinlock in fsl_diu_open resolved? rh_alloc might 
> sleep if I still see correctly, do I?

Hmmm... I thought I had an answer to this question, but I checked the patch
again, and it looks like this particular issue hasn't been fixed.  rh_alloc can
still sleep.  I know we worked on fixing this bug, so I'm not sure why it's
still there.

However, we don't need to call rh_alloc().  The arch/powerpc code has been
updated to remove the need for us to a use an rheap.

Unfortunately, the author of the patch, York, is out this week, so I'll have to
take care of this.  It'd be easier to modify rh_alloc() so that it doesn't
sleep, so that's what I'm going to do.

-- 
Timur Tabi
Linux kernel developer at Freescale
