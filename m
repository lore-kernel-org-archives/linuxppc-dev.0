Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D7491A0793
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 14:42:31 +1000 (EST)
Message-ID: <1412311350.2783.4.camel@concordia>
Subject: Re: [PATCH 00/20] powerpc: Convert power off logic to pm_power_off
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander Graf <agraf@suse.de>
Date: Fri, 03 Oct 2014 14:42:30 +1000
In-Reply-To: <1412170086-57971-1-git-send-email-agraf@suse.de>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 15:27 +0200, Alexander Graf wrote:
> The generic Linux framework to power off the machine is a function pointer
> called pm_power_off. The trick about this pointer is that device drivers can
> potentially implement it rather than board files.
> 
> Today on PowerPC we set pm_power_off to invoke our generic full machine power
> off logic which then calls ppc_md.power_off to invoke machine specific power
> off.
> 
> To fix this up, let's get rid of the ppc_md.power_off logic and just always use
> pm_power_off as was intended. Then individual drivers such as the GPIO power off
> driver can implement power off logic via that function pointer.

This looks OK to me with one caveat.

In several of the patches you're replacing a static initialisation with a
runtime one, and you're doing the runtime initialisation in xxx_setup_arch().
That's reasonably late, so I'd prefer you did it in xxx_probe().

If you resend with that changed I'll put it in next.

cheers
