Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 9E387DE08A
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 07:11:20 +1100 (EST)
Date: Tue, 16 Jan 2007 14:11:10 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Warnings when booting rc5 on a mpc83xx based board
Message-ID: <20070116201110.GA4332@localdomain>
References: <1168968034.31963.11.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168968034.31963.11.camel@gentoo-jocke.transmode.se>
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> after upgrading to rc5 I get this:
> 
> IPIC (128 IRQ sources) at fdefd700
> QEIC (64 IRQ sources) at fdefc080
> PID hash table entries: 512 (order: 9, 2048 bytes)
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249DF0] [C00F2158] report_bug+0x84/0xac
> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR = of_node_get+0x20/0x38
> [C0249F00] [FFFFFFFF] 0xffffffff (unreliable)
> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
> [C0249F30] [C02198A0] get_freq+0x2c/0x80
> [C0249F50] [C021992C] generic_calibrate_decr+0x38/0xdc
> [C0249F70] [C0219E5C] time_init+0x48c/0x530
> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
> [C0249FF0] [00003438] 0x3438

Looks like it could be an unbalanced of_node_put causing a node's
refcount to underflow, probably the root node.  The warning in
kref_get has unearthed a couple of these recently, see

http://patchwork.ozlabs.org/linuxppc/patch?id=8840

for example.
