Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77C7D1A1A79
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 14:22:29 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0136.outbound.protection.outlook.com [207.46.100.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9DE58140788
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 14:22:27 +1000 (AEST)
Message-ID: <1436329328.2658.75.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/kexec: Reset secondary cpu endianess before
 kexec
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
CC: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, <linuxppc-dev@ozlabs.org>
Date: Tue, 7 Jul 2015 23:22:08 -0500
In-Reply-To: <20150708040455.GA9086@pale.ozlabs.ibm.com>
References: <1436318605-13031-1-git-send-email-sam.mj@au1.ibm.com>
 <1436322938.2658.60.camel@freescale.com>
 <20150708040455.GA9086@pale.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-08 at 14:04 +1000, Paul Mackerras wrote:
> On Tue, Jul 07, 2015 at 09:35:38PM -0500, Scott Wood wrote:
> > 
> > Also, it would be better to use label subtraction rather than hardcoding 
> > "28", and the bcl instruction would be more readable as "bl <label>".
> 
> I agree about using labels, but "bcl 20,31,foo" is not the same thing
> as "bl foo".  The former is a form of bl that doesn't perturb the link
> stack and is therefore better for performance when you're not going to
> do a matching blr later (not that performance is at all critical
> here).

If performance mattered I would have complained about the extra mfmsr. :-)

I see that some other parts of the kernel are using that bcl instruction, but 
if it is actually worthwhile in those places, it'd be nice to at least stick 
it in a macro for readability...

-Scott
