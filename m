Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412LjW32zFzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 22:06:21 +1000 (AEST)
Date: Fri, 8 Jun 2018 07:05:32 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, wei.guo.simon@gmail.com,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/4] powerpc/lib: implement strlen() in assembly
Message-ID: <20180608120532.GD17342@gate.crashing.org>
References: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
 <8d65b5876f55efbd2243f6b43c758e452bee3b54.1528452373.git.christophe.leroy@c-s.fr>
 <20180608114513.gtgg7o4ejcqrjiz4@lt-gp.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180608114513.gtgg7o4ejcqrjiz4@lt-gp.iram.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 08, 2018 at 01:45:13PM +0200, Gabriel Paubert wrote:
> On Fri, Jun 08, 2018 at 10:20:41AM +0000, Christophe Leroy wrote:
> > +	rlwinm.	r8, r9, 0, 0xff000000
> > +	beq	20f
> > +	rlwinm.	r8, r9, 0, 0x00ff0000
> > +	beq	21f
> > +	rlwinm.	r8, r9, 0, 0x0000ff00
> > +	beq	22f
> > +23:	subf	r3, r3, r10
> 
> Actually these rlwinm. can likely be replaced by a single
> cntlzw /cntlzd; for 32 bit something like:
> 
> 	cntlzw  r8,r9
> 	subf    r3,r3,r10	
> 	srwi	r8,r8,3
> 	add	r3,r3,r8
> 	blr

The code is finding the first zero byte in the word, not how many leading
zero bytes there are.


Segher
