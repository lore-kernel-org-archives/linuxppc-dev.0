Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FC96B71D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 11:54:12 +1000 (EST)
Subject: Re: [PATCH 6/7] [RFC] enable early TLBs for BG/P
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
In-Reply-To: <BANLkTinAqeu7C+U_HFrOAOctFTuSUwG-iA@mail.gmail.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-6-git-send-email-ericvh@gmail.com>
	<1305851941.7481.92.camel@pasglop>
	<BANLkTinAqeu7C+U_HFrOAOctFTuSUwG-iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 11:54:02 +1000
Message-ID: <1305856442.7481.120.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-05-19 at 20:21 -0500, Eric Van Hensbergen wrote:
> On Thu, May 19, 2011 at 7:39 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2011-05-18 at 16:24 -0500, Eric Van Hensbergen wrote:
> >> BG/P maps firmware with an early TLB
> >
> > That's a bit gross. How often do you call that firmware in practice ?
> > Aren't you better off instead inserting a TLB entry for it when you call
> > it instead ? A simple tlbsx. + tlbwe sequence would do. That would free
> > up a TLB entry for normal use.
> >
> 
> Well, it depends on who you talk to.  The production software BG/P
> guys use the firmware constantly, its the primary interface to the networks, the console,
> and the management software which runs the machine.

Yuck.

> As such the IO Node guys, the Compute Node Kernel guys and the
> ZeptoOS guys use it quite a bit.  The kittyhawk guys on the other hand
> barely use it at all, in fact I believe they do all the interaction with
> it during uboot and then shut it off.

I would prefer that approach.

> IIRC, the sticky question is RAS support, there are certain things it
> wants to jump to firmware to deal with and expects things to be mapped
> an pinned into memory.
>
> Furthermore, I think it may make assumptions about where in the TLB the
> mappings are.  

This is gross, especially on a system with only 64 SW loaded TLB
entries :-(

> Since the kittyhawk guys
> obviously ignore this by shutting it down, its not clear just how
> important this is.  I'm game to
> try the dynamic mapping as you suggest if you would prefer it.

I would yes, we can sort things out later for RAS.

> Its worth mentioning that I believe with BG/Q, the plan is to rely on
> the firmware even more extensively, but I haven't looked at any of the code yet to verify
> whether or not this is true.

This is tantamount to linking a binary blob with the kernel ... it's a
fine line. At some point we might refuse the patches if they go too far
in that direction.

Cheers,
Ben.

>      -eric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
