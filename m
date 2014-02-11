Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 923EC2C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 13:57:30 +1100 (EST)
Date: Tue, 11 Feb 2014 02:56:45 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc ticket locks
Message-ID: <20140211025645.GJ18016@ZenIV.linux.org.uk>
References: <20140207165801.GC2107@lst.de> <1392001823.3996.21.camel@pasglop>
 <20140210155217.GF2107@lst.de> <1392086660.3996.50.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392086660.3996.50.camel@pasglop>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>, Torsten Duwe <duwe@lst.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 11, 2014 at 01:44:20PM +1100, Benjamin Herrenschmidt wrote:
> That leaves us with 32 bits to put the ref and the owner. The question
> is how big the ref really has to be and can we have a reasonable failure
> mode if it overflows ?
> 
> If we limit ourselves to, for example, 16-bit for the ref in lockref,
> then we can have the second 32-bit split between the owner and the ref.
> 
> If we limit ourselves to 4k CPUs, then we get 4 more bits of ref ...
> 
> So the question is, is it reasonable to have the ref smaller than
> 32-bit...

Every time you open a file, you bump dentry refcount.  Something like
libc or ld.so will be opened on just about every execve(), so I'd say
that 16 bits is far too low.  If nothing else, 32 bits might be too
low on 64bit boxen...
