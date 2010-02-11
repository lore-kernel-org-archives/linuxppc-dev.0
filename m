Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 746E3B7067
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 03:54:30 +1100 (EST)
In-Reply-To: <m2sk977ms5.fsf@igel.home>
References: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
	<m2sk977ms5.fsf@igel.home>
Subject: Re: Endian/__BYTE_ORDER question
To: Andreas Schwab <schwab@linux-m68k.org>
Message-ID: <OF178FB587.8D3749A5-ONC12576C7.005C1D91-C12576C7.005CB4EC@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 11 Feb 2010 17:52:36 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@linux-m68k.org> wrote on 2010/02/11 17:35:54:
>
> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
>
> > I am getting confused about on how to test for Endian in the kernel code. In user
> > space one uses #if __BYTE_ORDER == __LITTLE_ENDIAN or #if __BYTE_ORDER == __BIG_ENDIAN
> >
> > I can see lots of kernel headers using this test too
>
> Only outside of __KERNEL__.

Ah, yes now I see. This is unfortunate as if one moves kernel
code to user space and still use the kernel way:
 #ifdef __LITTLE_ENDIAN
one will be in big trouble as including stdlib.h will define
both __LITTLE_ENDIAN and __BIG_ENDIAN. Spent quite a while
chasing that one down :(

      Jocke
