Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 50483B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 14:11:40 +1000 (EST)
Message-ID: <1335759088.20866.32.camel@pasglop>
Subject: Re: [REGRESSION][PATCH V4 3/3] bpf jit: Let the powerpc jit handle
 negative offsets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Mon, 30 Apr 2012 14:11:28 +1000
In-Reply-To: <1335753820.20866.27.camel@pasglop>
References: <4F75CA89.4010709@googlemail.com> <4F75D2A5.7060407@googlemail.com>
 <20120403.180302.342779808900865443.davem@davemloft.net>
 <1333491102.3040.12.camel@pasglop> <1335753820.20866.27.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kaffeemonster@googlemail.com, eric.dumazet@gmail.com, matt@ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-30 at 12:43 +1000, Benjamin Herrenschmidt wrote:

> > Matt's having a look at powerpc
> 
> Ok, he hasn't so I'll dig a bit.
> 
> No obvious wrongness (but I'm not very familiar with bpf), though I do
> have a comment: sk_negative_common() and bpf_slow_path_common() should
> be made one and single macro which takes the fallback function as an
> argument.

Ok, with the compile fix below it seems to work for me:

(Feel free to fold that into the original patch)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index af1ab5e..5c3cf2d 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -48,7 +48,13 @@
 /*
  * Assembly helpers from arch/powerpc/net/bpf_jit.S:
  */
-extern u8 sk_load_word[], sk_load_half[], sk_load_byte[], sk_load_byte_msh[];
+#define DECLARE_LOAD_FUNC(func)	\
+	extern u8 func[], func##_negative_offset[], func##_positive_offset[]
+
+DECLARE_LOAD_FUNC(sk_load_word);
+DECLARE_LOAD_FUNC(sk_load_half);
+DECLARE_LOAD_FUNC(sk_load_byte);
+DECLARE_LOAD_FUNC(sk_load_byte_msh);
 
 #define FUNCTION_DESCR_SIZE	24
 
Cheers,
Ben.
