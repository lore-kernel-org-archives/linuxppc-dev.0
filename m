Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DXCy1NSjzF116
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 02:49:49 +1000 (AEST)
Date: Mon, 17 Sep 2018 11:49:11 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/32: stack protector: change the canary value
 per task
Message-ID: <20180917164911.GK23155@gate.crashing.org>
References: <9f7efcc085685717bb4c7b3a575138a1a1cd15ed.1537186089.git.christophe.leroy@c-s.fr>
 <7bd67c4ccdd202f2125b7fc0ed0332d0d020690b.1537186089.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7bd67c4ccdd202f2125b7fc0ed0332d0d020690b.1537186089.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2018 at 12:15:08PM +0000, Christophe Leroy wrote:
>  I would have liked to use -mstack-protector-guard=tls -mstack-protector-guard-reg=r2
>  -mstack-protector-guard-offset=offsetof(struct task_struct, stack_canary) but I have
>  not found how set the value of offsetof(struct task_struct, stack_canary) in Makefile.

By far the easiest is to have the canary at a fixed offset from r2.


Segher
