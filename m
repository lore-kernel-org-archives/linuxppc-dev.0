Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linas <linas@austin.ibm.com>
In-Reply-To: <20050908193053.GO30028@austin.ibm.com>
References: <0C620F0B-92B0-4EBF-BC0C-49FD4D3D4323@freescale.com>
	<ac556638e1f4b4f9786c30ed0debc4a8@kernel.crashing.org>
	<20050908193053.GO30028@austin.ibm.com>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 07:53:52 +1000
Message-Id: <1126216432.29803.31.camel@gaston>
Mime-Version: 1.0
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: r13 is non-volatile?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> There's a different value in R13 depending on which cpu you're on,
> so one mustn't save R13 on one CPU and attempt to restore it on
> another.
> 
> Maybe, for ppc32, you can pretend that r13 "is like a paca"? So
> that instead of saving/restoring r13 like this, you could set it up
> at the same time/instead of setting up the paca r13?

ppc32 uses r2 for that, it contains "current".

I don't think we need to bother merging those low level CPU specific
things. We need to have a cpu32 and a cpu64 subdirs in there for things
like these, memory management, etc... imho.

Ben.
