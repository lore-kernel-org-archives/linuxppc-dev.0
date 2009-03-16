Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3B6CDDF8F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 04:47:15 +1100 (EST)
Message-Id: <E7863DEF-69B0-4067-BF12-120F1EA6B762@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200903161709.14682.david.jander@protonic.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC][PATCH v5] MPC5121 TLB errata workaround
Date: Mon, 16 Mar 2009 12:47:03 -0500
References: <200903161652.09747.david.jander@protonic.nl>
	<200903161709.14682.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Wolfgang Denk <wd@denx.de>, gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 16, 2009, at 11:09 AM, David Jander wrote:

>
> In this patch, I placed the LRW table in SPRG6 like before, but  
> Kumar's code
> seems a little more compact, so I decided to use that one and fix  
> it ;-)
>
> It's a pity we seem to have one register short in the handler, so we  
> need to
> load SPRN_SRR1 twice :-(
>
> Allthough the code-path now has 1 instruction less than my previous  
> version
> most of the time (and 2 instructions more when way is not adjusted),
> benchmark results are barely affected by this:
>
> 1.- mplayer: Total time: 50.392s (50.316s previous patch)
>
> 2.- prboom timedemo: 20.1 fps (19.9 fps previous patch)
>
> 3.- memcpy speed: 179 MByte/s (180 Mbyte/s previous patch)
>
> Conclusion: difference not measurable between v4 and v5.

Can we try this memory instead of the SPRG to see if any noticeable  
difference?

- k
