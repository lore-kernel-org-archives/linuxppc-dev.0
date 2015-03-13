Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB6711A074A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 18:07:28 +1100 (AEDT)
Message-ID: <1426230438.17565.162.camel@kernel.crashing.org>
Subject: Re: [RFC] powerpc: use ticket spin lock for !CONFIG_PPC_SPLPAR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Fri, 13 Mar 2015 18:07:18 +1100
In-Reply-To: <20150313060913.GC24485@pek-khao-d1.corp.ad.wrs.com>
References: <1426157723-28548-1-git-send-email-haokexin@gmail.com>
 <1426158807.17565.131.camel@kernel.crashing.org>
 <20150312152410.GA12372@lst.de>
 <20150313060913.GC24485@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Torsten Duwe <duwe@lst.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-13 at 14:09 +0800, Kevin Hao wrote:
> On Thu, Mar 12, 2015 at 04:24:10PM +0100, Torsten Duwe wrote:
> > But generally, which platforms would benefit most from this change?
> 
> In theory, the more cpus the platform has, the more serious the thundering
> herd problem is. So the latest platforms which has more cpus would benefit
> most.

In fact, pseries would be one to benefit ... it would be nice to find a
way to sort out the lock owner problem.

One idea I had was to keep the owners elsewhere, some kind of hash chain
of "taken locks" hashed on the lock address. There shouldn't be *that*
many locks held at a given point in time.

Trying to keep the owner in a separate & non-atomic part of the lock
proved being too hard due to how the lockref and generic code are
interwined, though maybe somebody smarter can find a trick :-)

Cheers,
Ben.
