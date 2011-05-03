Return-Path: <anton@samba.org>
Date: Tue, 3 May 2011 16:55:20 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add Initiate Coprocessor Store Word (icswx)
	support
Message-ID: <20110503165520.67eab924@kryten>
In-Reply-To: <1304405237.2513.304.camel@pasglop>
References: <20110503164304.7690a1b7@kryten>
	<1304405237.2513.304.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: tsenglin@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ben,

> My only comment (sorry Anton :-) would have been that we could lazily
> allocate the spinlock on the first use_cop() ... or do we have that
> potentially called in the wrong context ?

I worry what might happen in a threaded app. It would be a strange
thing to do, but the program may call use_cop from two threads at the
same time. In that case you could corrupt the PID/ACOP values
and leak a spinlock of memory I think.

Anton
