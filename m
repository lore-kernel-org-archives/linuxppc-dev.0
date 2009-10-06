Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D419B7BB0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 10:26:11 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFC64CFB37.E5E17F42-ONC1257647.0068299A-C1257647.00795ECE@transmode.se>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254773824.7122.33.camel@pasglop>
	<OF3182684B.BB80DBCF-ONC1257646.0073D59B-C1257646.0075AB6F@transmode.se>
	<1254778643.7122.43.camel@pasglop>
	<OF16069D5F.03682AAC-ONC1257646.00774BB8-C1257646.0078E24B@transmode.se>
	<1254780556.7122.47.camel@pasglop>
	<OF346FF2E6.3CCDA0FA-ONC1257646.007C13A0-C1257646.007DF396@transmode.se>
	<1254784539.7122.52.camel@pasglop>
	<OFB8E4035A.83748CF0-ONC1257646.0080A097-C1257646.00819DD6@transmode.se>
	<1254789255.7122.95.camel@pasglop>
	<OFC64CFB37.E5E17F42-ONC1257647.0068299A-C1257647.00795ECE@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Oct 2009 10:25:48 +1100
Message-Id: <1254871548.6035.28.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> After some more thinking I don't think I do TLB Miss/Error correctly yet.
> The problem is ACCESSED. Since I don't know if load or store in TLB Miss
> I must choose:
>  - Assume load and do what you do above. That will incorrectly
>    set ACCESSED on store ops when mapped as RO(plus whatever more I haven't thought about yet)
> 
>  - Trap to TLB Error and do the above. That will set ACCESSED correctly
>    but won't trap kernel space so these remain what they are.
>    Is anything depending on ACCESSED for kernel pages?
>    if so, what if we set ACCESSED on all kernel pages when mapping them at boot?
>    Will SWAP or some other service(accounting?) not like that?

Kernel pages always have ACCESSED set and never clear it.

I think the only solution here is that if -anything- doesn't look right,
the TLB miss should create one of those "unpopulated" entries and we
need to make sure they are properly invalidated in the subsequent fault
path. I'll read the 8xx doco asap to make sure I get it right.

> Finally, why do you need to include DIRTY when a store OP?
> Do you need to do COW before dirtying the page?
> Seems to work for me to just set DIRTY in TLB Error if RW is set too
> and not trap to C.

You can, but what about a load ? That shouldn't set dirty. So if you set
dirty only on stores, then a load will bring in a page without dirty,
you need to make sure you get another TLB error when writing to it so
you get a chance to set dirty.

Ben.
