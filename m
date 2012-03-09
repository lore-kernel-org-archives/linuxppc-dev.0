Return-Path: <rob.herring@calxeda.com>
Received: from smtp121.dfw.emailsrvr.com (smtp121.dfw.emailsrvr.com
 [67.192.241.121])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA3E5B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2012 04:01:35 +1100 (EST)
Message-ID: <4F5A350F.3090905@calxeda.com>
Date: Fri, 09 Mar 2012 10:51:27 -0600
From: Rob Herring <rob.herring@calxeda.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the arm tree
References: <20120308120422.e071cba36425eacbee1f8d98@canb.auug.org.au>
 <25744.1331174036@neuling.org>
 <20120308145131.fad50bbc79c36f0b0b12d101@canb.auug.org.au>
 <1331185951.3105.29.camel@pasglop> <1331249746.3105.40.camel@pasglop>
 <20120309003937.GC8680@flint.arm.linux.org.uk>
 <1331262821.3105.47.camel@pasglop>
In-Reply-To: <1331262821.3105.47.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, Paul Mundt <lethal@linux-sh.org>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2012 09:13 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2012-03-09 at 00:39 +0000, Russell King wrote:
>> On Fri, Mar 09, 2012 at 10:35:46AM +1100, Benjamin Herrenschmidt wrote:
>>> Actually, I didn't keep MAY_HAVE_SPARSE_IRQ, I kept HAVE_SPARSE_IRQ. If
>>> I remove it, then I get Kconfig warnings:
>>>
>>> warning: (PPC) selects SPARSE_IRQ which has unmet direct dependencies
>>> (HAVE_GENERIC_HARDIRQS && HAVE_SPARSE_IRQ)
>>
>> Do you have commit 2ed86b16eabe4efbf80cc725a8cbb5310746a2fc ?
> 
> Nope, Grant patch didn't mention a dependency.

My opinion is that SPARSE_IRQ shouldn't be user visible option, and the
simple solution was to just make it hidden. It wasn't clear if this was
desired or not for other arches at the time. There is a mixture of
settings in powerpc defconfigs. SuperH selects it for 32-bit and leaves
it user selectable for 64-bit.

I'm happy to revert adding MAY_HAVE_SPARSE_IRQ and just make SPARSE_IRQ
a hidden option. It really just needs the okay from SuperH folks.

Rob
