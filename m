Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 1076367B7C
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 20:31:15 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 26 Sep 2006 12:31:04 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Lazy interrupt disabling for 64-bit machines
Message-ID: <20060926103104.GA19065@iram.es>
References: <17688.45762.294594.33723@cargo.ozlabs.ibm.com>
	<20060926011055.32d533e7@pb15>
	<1159261926.5462.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1159261926.5462.54.camel@localhost.localdomain>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 26, 2006 at 07:12:06PM +1000, Benjamin Herrenschmidt wrote:
> 
> > I like it. Got any benchmarks that show a difference?
> > 
> > At first glance I found it a bit hard to follow, since the old+new
> > terminology is a bit complicated. There's softe, proc_enabled and
> > hard_enabled. A s/proc_enabled/soft_enabled/g (and similar for
> > asm-offsets) might make it a little more intuitive, since you're
> > touching most uses of it already?
> 
> Now think about using -ffixed=crN ... reserve a CR field and use that
> for per-cpu flags like that :)
> 

Actually cr5 is never used by GCC on any PPC. Look at the source
code in config/rs6000.h, it is marked fixed and never allocated
as far as I understand.

	Regards,
	Gabriel "an unused register is a wasted register"
