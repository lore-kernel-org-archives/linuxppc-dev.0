Return-Path: <jbeulich@novell.com>
Received: from vpn.id2.novell.com (vpn.id2.novell.com [195.33.99.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "emea1-mh.id2.novell.com", Issuer "APPS" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 12620B7C1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Sep 2009 19:48:50 +1000 (EST)
Message-Id: <4AC1E15502000078000516B5@vpn.id2.novell.com>
Date: Tue, 29 Sep 2009 10:28:36 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: <sfr@canb.auug.org.au>,<hollisb@us.ibm.com>
Subject: Re: linux-next: tree build failure
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@linux-foundation.org, linux-next@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Hollis Blanchard  09/29/09 2:00 AM >>>
>First, I think there is a real bug here, and the code should read like
>this (to match the comment):
>    /* type has to be known at build time for optimization */
>-    BUILD_BUG_ON(__builtin_constant_p(type));
>+    BUILD_BUG_ON(!__builtin_constant_p(type));
>
>However, I get the same build error *both* ways, i.e.
>__builtin_constant_p(type) evaluates to both 0 and 1? Either that, or
>the new BUILD_BUG_ON() macro isn't working...

No, at this point of the compilation process it's neither zero nor one,
it's simply considered non-constant by the compiler at that stage
(this builtin is used for optimization, not during parsing, and the
error gets generated when the body of the function gets parsed,
not when code gets generated from it).

Jan
