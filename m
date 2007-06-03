Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18018.7868.811862.733793@cargo.ozlabs.ibm.com>
Date: Sun, 3 Jun 2007 11:51:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Maik Nijhuis <maik@cs.vu.nl>
Subject: Re: ps3 64-bit kernel: patched prpmc2800.c (fwd)
In-Reply-To: <Pine.GSO.4.63.0705250829380.19095@hydra.cs.vu.nl>
References: <Pine.GSO.4.63.0705250829380.19095@hydra.cs.vu.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maik Nijhuis writes:

> I managed to fix this issue as follows: At the end of
> arch/powerpc/boot/prpmc2800.c, there is an assembly instruction
> 
> rlwinm  10,10,0,~(1<<15)
> 
> I replaced this by
> 
> rlwinm  10,10,0,~(1<<15) & ((1<<32)-1)

It is a binutils bug, and Alan Modra has a patch for it.  In the
meantime the best thing would be to change that to

	rlwinm	10,10,0,17,15

which is equivalent.

Paul.
