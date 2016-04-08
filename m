Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhBWF44MlzDq6v
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 17:52:09 +1000 (AEST)
Date: Fri, 8 Apr 2016 09:47:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc: introduce {cmp}xchg for u8 and u16
Message-ID: <20160408074744.GU3430@twins.programming.kicks-ass.net>
References: <570752AA.9050603@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570752AA.9050603@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2016 at 02:41:46PM +0800, Pan Xinhui wrote:
> From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> Implement xchg{u8,u16}{local,relaxed}, and
> cmpxchg{u8,u16}{,local,acquire,relaxed}.
> 
> Atomic operation on 8-bit and 16-bit data type is supported from power7

And yes I see nothing P7 specific here, this implementation is for
everything PPC64 afaict, no?

Also, note that you don't need explicit 8/16 bit atomics to implement
these. Its fine to use 32bit atomics and only modify half the word.

Also, you might want to invest in some CPP to reduce the endless
repetition.

Other than that, no objections :-)
