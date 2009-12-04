Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5BCCB7BDB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 13:38:59 +1100 (EST)
Subject: Re: [PATCH] powerpc/mm: setting mmaped page cache property through
	device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <E389CC83-307F-4A7D-B90B-CD928A1D1D1D@kernel.crashing.org>
References: <1259663450-28790-1-git-send-email-leoli@freescale.com>
	<1259665127.2076.363.camel@pasglop>
	<2a27d3730912010334q24bf0e06g84839aae131475ec@mail.gmail.com>
	<E389CC83-307F-4A7D-B90B-CD928A1D1D1D@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Dec 2009 13:38:51 +1100
Message-ID: <1259894331.2076.1245.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-01 at 15:35 +0100, Segher Boessenkool wrote:
> So make the memory known to the kernel, just tell the kernel not to
> use it.  If it's normal system RAM, just put it in the "memory" node
> and do a memreserve on it (or do something in your platform code); if
> it's some other memory, do a device driver for it, map it there.

Right, if he's going to map it cachable he shouldn't bother with using
mem= or crap like that. And /dev/mem should just work.

Cheers,
Ben
