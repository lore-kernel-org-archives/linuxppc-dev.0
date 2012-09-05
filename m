Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D17C92C0299
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 15:27:29 +1000 (EST)
Message-ID: <1346822819.2257.49.camel@pasglop>
Subject: Re: [PATCH v5 3/3] powerpc: Uprobes port to powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ananth@in.ibm.com
Date: Wed, 05 Sep 2012 15:26:59 +1000
In-Reply-To: <20120824073132.GC32031@in.ibm.com>
References: <20120824072602.GA32031@in.ibm.com>
 <20120824073132.GC32031@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, ppcdev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-08-24 at 13:01 +0530, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> This is the port of uprobes to powerpc. Usage is similar to x86.

Guys, can you do a minimum of build testing ?

This one breaks due to uprobe_get_swbp_addr() being defined in both
asm and include/linux when CONFIG_UPROBE isn't set. You don't need
to define it at all in fact, the generic code takes care of both the
declaration for CONFIG_UPROBE and the empty inline for !CONFIG_UPROBE.

I'm fixing that one up myself but please, please, get yourself a test
build script or something to make sure you don't at least break the
build when the stuff you're adding isn't enabled (among others).

Cheers,
Ben.
