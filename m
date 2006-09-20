Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 7411067B79
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 11:19:57 +1000 (EST)
Date: Tue, 19 Sep 2006 18:20:42 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Message-ID: <20060920012042.GA28489@mag.az.mvista.com>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Regarding our earlier conversation about ft_translate_addr and
ft_parentize.  I just realized that on IRC today Matt Porter pointed
out that using the "reg" property in ns16550.c is wrong.  We--several
of us on #mklinux--decided that the "address" property is the correct
thing to use because we should really be using a virtual address from
the fw (bootwrapper has no ioremap).  So, unless someone objects,
we'll all add the "address" property to our uart device nodes in our
fdt's (if they can be used as the console).

A couple consequences, if that happens:
- It removes the requirement for ft_translate_addr (and
  dt_ops.translate_addr) in the bootwrapper.  That cleans up
  flatdevtree_misc.c a lot.
- Since ft_find_node/device will be the only caller of ft_parentize
  now, that may change your plans for ft_parentize.

Do you have any objections to using "address" property instead of "reg"?

Mark
