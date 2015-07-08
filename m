Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D17101A05EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 14:04:59 +1000 (AEST)
Date: Wed, 8 Jul 2015 14:04:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/kexec: Reset secondary cpu endianess before
 kexec
Message-ID: <20150708040455.GA9086@pale.ozlabs.ibm.com>
References: <1436318605-13031-1-git-send-email-sam.mj@au1.ibm.com>
 <1436322938.2658.60.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436322938.2658.60.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 07, 2015 at 09:35:38PM -0500, Scott Wood wrote:
> 
> Also, it would be better to use label subtraction rather than hardcoding 
> "28", and the bcl instruction would be more readable as "bl <label>".

I agree about using labels, but "bcl 20,31,foo" is not the same thing
as "bl foo".  The former is a form of bl that doesn't perturb the link
stack and is therefore better for performance when you're not going to
do a matching blr later (not that performance is at all critical
here).

Paul.
