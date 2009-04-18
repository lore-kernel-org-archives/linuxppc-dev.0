Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 4AE97DE0B0
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 15:43:11 +1000 (EST)
Received: by gxk1 with SMTP id 1so2442949gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 22:43:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49E8F2D7.3050603@embeddedarm.com>
References: <49E8F2D7.3050603@embeddedarm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Apr 2009 23:42:55 -0600
Message-ID: <fa686aa40904172242w378fd4c8n1a4f68d897af2859@mail.gmail.com>
Subject: Re: PowerPC iotable_init equivalent?
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 3:21 PM, Eddie Dawydiuk <eddie@embeddedarm.com> wrote:
> Hello,
>
> In the past I've worked with ARM architectures where I could setup virtual /
> physical address mappings so I don't have to ioremap then pass around
> pointers. Does PowerPC have an equivalent abstraction? If not whats the
> recommended approach?

No.  Predefining virt->phys mappings is fragile since it makes
assumptions about how the kernel is going to carve up the virtual
address space.  Better to let the kernel allocate virtual ranges as it
needs them.

As Kumar says, do your ioremap() (or, even better: of_iomap()) in your
driver's probe function and store it in the driver's private data
structure.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
