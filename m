Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 648C6679E7
	for <linuxppc-dev@ozlabs.org>; Tue, 24 May 2005 09:54:20 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <42926A07.20706@am.sony.com>
References: <42926A07.20706@am.sony.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 09:53:35 +1000
Message-Id: <1116892416.30513.10.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] add machine state register support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-05-23 at 16:40 -0700, Geoff Levand wrote:
> This patch adds routines to get and set the machine state register.  These 
> are needed by power management code on some platforms.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF

Hi Geoff !

Can you tell me more about this power management code ? I tend to think
that code that wants to do more than just using the existing accessors
should be written in assembly... 

Also, there is already

void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);

That you can use for manipulating MSR bits.

Finally, I tend to prefer such small register accessors to be written as
inline assembly in some headers. But then, I don't think you actually
need to add anything here.

Regards,
Ben.
