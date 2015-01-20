Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 709171A1114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:28:12 +1100 (AEDT)
Date: Tue, 20 Jan 2015 11:00:38 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] tick/broadcast: Make movement of broadcast hrtimer
 robust against hotplug
In-Reply-To: <20150120081121.26984.46720.stgit@preeti.in.ibm.com>
Message-ID: <alpine.DEB.2.11.1501201049371.5526@nanos>
References: <20150120081121.26984.46720.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: aik@ozlabs.ru, linux-kernel@vger.kernel.org, anton@samba.org,
 shreyas@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Jan 2015, Preeti U Murthy wrote:
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -675,8 +675,8 @@ static void broadcast_move_bc(int deadcpu)
>  
>  	if (!bc || !broadcast_needs_cpu(bc, deadcpu))
>  		return;
> -	/* This moves the broadcast assignment to this cpu */
> -	clockevents_program_event(bc, bc->next_event, 1);
> +	/* This allows fresh nomination of broadcast cpu */

This comment should explain WHY this enforces the move of the
broadcast to a different cpu. 'Allows' is rather ambiguous.

> +	bc->next_event.tv64 = KTIME_MAX;

Thanks,

	tglx
