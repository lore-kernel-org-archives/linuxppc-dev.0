Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17675.30508.252375.59449@cargo.ozlabs.ibm.com>
Date: Sat, 16 Sep 2006 14:01:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
In-Reply-To: <20060915180129.GE1884@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<20060908033508.GA5203@mag.az.mvista.com>
	<17674.32333.958250.868794@cargo.ozlabs.ibm.com>
	<20060915180129.GE1884@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> Yes.  Whether you pass the NULL or not hinges on whether its flat tree
> or not so I made it a dt_op.  What are you thinking?

There's basically only two cases: if we have a builtin flat tree, we
pass that and NULL in r5; if we don't, and we have OF, we pass NULL in
r3 and the OF entry point in r5.  I think that could be handled in
main.c.

We also lost the "enforce minimum address only for 64-bit" thing in
the translation, too.

I believe that just patch 1/6 on its own won't give us a working
zImage, so we'll have to split up the changes differently when it
comes time to check this stuff in to git.

Paul.
