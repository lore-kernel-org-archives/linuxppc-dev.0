Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8C8B5679E2
	for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2005 02:54:17 +1000 (EST)
Date: Thu, 26 May 2005 09:54:14 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050526165414.GD25579@gate.ebshome.net>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
	<1117057460.5076.19.camel@gaston>
	<80f48eb53b0f876138cde07a997791b6@embeddededge.com>
	<20050526093119.A3872@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050526093119.A3872@cox.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 26, 2005 at 09:31:19AM -0700, Matt Porter wrote:
> Why don't we try a different approach to the problem? The problem is
> that io_block_mapping() is causing a ton of problems with people
> abusing it. Just check the archives for all the ways people break
> their ports by passing it arbitrary values.  The other issue is
> that although it's dangerous, the call still serves a purposes on
> those processors with BATs and CAMs. So, let's kill io_block_mapping().
> i.e. the version that allows virt->phys translations to be set up
> without use of BATs and CAMs. Let's add a new mmu_block_mapping()
> call that will ONLY map using a BAT or CAM and is only available
> on platforms with those facilities. If a free BAT or CAM is not available
> or alignment/size is invalid, the call fails. I would hope that would
> make everybody happy.
> 
> We still end up with a call that will help people shoot themselves
> in the foot, but at least we limit it to a specific task.

I second that.

-- 
Eugene
