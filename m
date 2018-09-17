Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GKyp0Zr5zF3M5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 01:14:41 +1000 (AEST)
Date: Mon, 17 Sep 2018 11:46:13 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc: initial stack protector (-fstack-protector)
 support
Message-ID: <20180917164613.GJ23155@gate.crashing.org>
References: <9f7efcc085685717bb4c7b3a575138a1a1cd15ed.1537186089.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9f7efcc085685717bb4c7b3a575138a1a1cd15ed.1537186089.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Mon, Sep 17, 2018 at 12:15:05PM +0000, Christophe Leroy wrote:
> Now, GCC offers the possibility to manually set the
> stack-protector mode (global or tls) regardless of libc support.

Yup :-)

> This time, the patch selects HAVE_STACKPROTECTOR only if
> -mstack-protector-guard=global is supported by GCC.

"global" is weaker than "tls" (it is easier to read the cookie in an
exploit).  It is better to use tls if you can.


Segher
