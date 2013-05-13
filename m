Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C27942C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 19:06:51 +1000 (EST)
Message-ID: <1368435991.19924.35.camel@pasglop>
Subject: Re: [RFC PATCH v3 2/5] powerpc: Exception hooks for context
 tracking subsystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Mon, 13 May 2013 19:06:31 +1000
In-Reply-To: <1368434680.2618.33.camel@ThinkPad-T5421>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1368422493-9831-3-git-send-email-zhong@linux.vnet.ibm.com>
 <1368424667.19924.26.camel@pasglop>
 <1368434680.2618.33.camel@ThinkPad-T5421>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fweisbec@gmail.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-13 at 16:44 +0800, Li Zhong wrote:
> Yes, the above and hash_page() are two C functions for a same exception.
> And the exception hooks enable RCU usage in those C codes. But for asm
> codes, I think we could assume that there would be no RCU usage there,
> so we don't need wrap them in the hooks.

hash_page() won't start a new RCU, at least not in its current incarnation,
the only thing I can see it ever doing would be to take some RCU read locks one
day (it doesn't today).

low_hash_fault() is a different beast. It will typically kill things, thus
involving sending signals etc... RCU might well be involved.

Cheers,
Ben.
