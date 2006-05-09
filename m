Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch] powerpc: remove do-nothing cpu setup routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <445FDF62.2030008@am.sony.com>
References: <BE9739CD-B66A-43A4-B5E9-2DE49CEDE5B7@kernel.crashing.org>
	<445FDF62.2030008@am.sony.com>
Content-Type: text/plain
Date: Tue, 09 May 2006 10:28:34 +1000
Message-Id: <1147134514.4777.287.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-08 at 17:16 -0700, Geoff Levand wrote:
> Segher Boessenkool wrote:
> >>> Removes the processor specific do-nothing routines  
> >>> __setup_cpu_power3 and
> >>> __setup_cpu_power4 with the generic routine __setup_cpu_null.
> >>
> >> Why not just change the caller to test for NULL ?
> 
> OK, I see the 32 bit version already does this, but I'm
> wondering if there is some restriction on the instruction
> sequence between the compare and the branch.  Here's what's
> there:
> 
> 	lwz	r5,CPU_SPEC_SETUP(r4)
> 	cmpi	0,r5,0
> 	add	r5,r5,r3
> 	beqlr
> 	mtctr	r5
> 	bctr
> 
> But, could this also be:
> 
> 	lwz	r5,CPU_SPEC_SETUP(r4)
> 	cmpi	0,r5,0
> 	beqlr
> 	add	r5,r5,r3
> 	mtctr	r5
> 	bctr

Just an optimisation for a code path that doesn't really need any :)
Blame habits...

Ben.
