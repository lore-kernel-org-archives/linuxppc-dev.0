Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] zImage: Cleanup and improve zImage entry point
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45D7AA50.3090408@am.sony.com>
References: <20070216062739.6DFDBDDD05@ozlabs.org>
	<45D7AA50.3090408@am.sony.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 06:57:02 +1100
Message-Id: <1171915022.18571.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This messed me up a bit since I had two stacks in the bss, one for each
> processor thread.  By the time this was called on the primary thread the
> secondary thread could already be using its stack.  I changed the secondary
> thread to use a small stack in the data section, so this seems OK.

The secondary thread(s) don't need a stack to loop in secondary hold,
right ? So maybe we could go all the way without using a stack. Do we
need C code at all for them ? We just need to hold them until we make
them branch to the kernel.

Ben.
