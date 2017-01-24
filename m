Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6qhh65sMzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 12:04:36 +1100 (AEDT)
Date: Mon, 23 Jan 2017 19:04:21 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Jan Stancek <jstancek@redhat.com>
Cc: mpe@ellerman.id.au, christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
 Artem Savkov <asavkov@redhat.com>, Herton Krzesinski <hkrzesin@redhat.com>
Subject: Re: [bug] stack protector panics on v4.10-rc1+
Message-ID: <20170124010421.GI30284@gate.crashing.org>
References: <627000186.495731.1485210132000.JavaMail.zimbra@redhat.com>
 <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 23, 2017 at 07:10:00PM -0500, Jan Stancek wrote:
> I'm running into panics with stack protector enabled on ppc64le

> I came across following gcc commit:
>   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=0d55f4d0aeaeb16629a2c07c96a190695b83a7e6
> which mentions offset above:
>   "If TARGET_THREAD_SSP_OFFSET is defined, use -0x7010(13) resp.
>    -0x7008(2) instead of reading __stack_chk_guard variable."
> 
> It looks like it's not reading canary value from __stack_chk_guard variable.
> atm. I'm not sure where -28688(r13) falls in ppc kernel (somewhere near paca struct?).
> 
> Is anyone else seeing these panics?

Everyone is.

This is fixed in GCC 8 (and will be backported to GCC 7 and GCC 6 and
maybe even GCC 5).  See <http://gcc.gnu.org/r244556> (and r244562 and
r244677).

The kernel will need to use -mstack-protector-guard=global for now, and
it later can use -mstack-protector-guard=tls -mstack-protector-register=<reg>
-mstack-protector-offset=<offset>.  If your GCC does not support this yet
(most people's situation right now) you cannot use the stack protector in
the kernel.


Segher
