Return-Path: <paulus@ozlabs.org>
Date: Thu, 7 Jun 2012 13:04:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
Message-ID: <20120607030423.GA30053@drongo>
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
 <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
Cc: mikey@neuling.org, michael@ellerman.id.au,
 Anton Blanchard <anton@samba.org>, olof@lixom.net,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2012 at 06:40:54PM +0200, Segher Boessenkool wrote:
> >+err1;	dcbz	r0,r3
> 
> There is no such instruction, you probably meant "dcbz 0,r3"?

There certainly is such an instruction, though it doesn't do exactly
what a naive reader might expect.  Using 0 rather than r0 or %r0
improves readability but makes no difference to the assembler or the
cpu.

Paul.
