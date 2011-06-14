Return-Path: <ppc6dev@digitaldans.com>
Received: from digitaldans.com (digitaldans.com [69.36.177.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5DFFB6F9E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 02:16:04 +1000 (EST)
Message-Id: <53DBBA1E-BD8C-4856-9E35-028C8BB0911F@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <1308059700-10839-7-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 06/15] 8xx: Always pin kernel instruction TLB
Date: Tue, 14 Jun 2011 09:06:45 -0700
References: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1308059700-10839-7-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Joakim.

On Jun 14, 2011, at 6:54 AM, Joakim Tjernlund wrote:

> Various kernel asm modifies SRR0/SRR1 just before executing
> a rfi. .....

I'm going to argue we can easily visually inspect for this
since the code is static with just a couple of RFIs in these
exception handlers.

Some 8xx processors have few TLB entries, and always taking
one for the kernel, especially if it isn't needed, could have a
detrimental effect on the application performance.  Even the
"big" 8xx processors don't have that many entries.  Some
benchmarks run on an MPC850 would likely show this.

Anyone making modifications to this level of software should
know of this problem, or make it known in a comment.  If you
are making changes, just compile the code and manually
check it with the couple of configuration options that affect
the placement of the instructions.

The better solution would be supporting large page sizes,
at least for the kernel.

Thanks.

	-- Dan
