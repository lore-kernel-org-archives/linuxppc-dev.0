Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 94013B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Oct 2010 08:16:07 +1100 (EST)
Message-ID: <4CC0AD74.8070800@neli.hopto.org>
Date: Thu, 21 Oct 2010 23:15:32 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH -mm 0/2] RapidIO: Changes to handling of RIO switches
References: <1287688250-14226-1-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1287688250-14226-1-git-send-email-alexandre.bounine@idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> 1. Using one storage location common for switches and endpoints eliminates
> unnecessary device type checks during maintenance access operations.
> While destination IDs and hop counts have different meaning for endpoints and
> switches, this does not prevent us from storing them in the primary RIO device
> structure (rio_dev) for both types.

How can you say this? The two variables have different meanings, this 
logically implies you can't merge them. So how do you say 'this does not 
prevent us from ...' without providing a reason?

> 2. Convert RIO switch device structures (rio_dev + rio_switch) into single
> allocation unit. This change is based on the fact that RIO switches are using
> common RIO device objects anyway. Allocating RIO switch objects as RIO devices
> with added space for switch information simplifies handling of RIO switch device
> objects.

I still don't think that's a good idea because the rdev->rswitch pointer 
can be defined to point to the switch that a given rio_dev is connected 
to. This is useful for quick lookups. How else can to know to which 
switch a given device is connected?

Micha
