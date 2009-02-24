Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 21B61DDDA9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 10:52:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: kyle@infradead.org
Subject: Re: [PATCH/RFC] powerpc: avoid generating .eh_frame sections with
	gcc-4.4
In-Reply-To: Kyle McMartin's message of  Tuesday,
	24 February 2009 01:51:12 -0500
	<20090224065112.GA6690@bombadil.infradead.org>
References: <20090224065112.GA6690@bombadil.infradead.org>
Message-Id: <20090224233613.B97B9FC380@magilla.sf.frob.com>
Date: Tue, 24 Feb 2009 15:36:13 -0800 (PST)
Cc: linuxppc-dev@ozlabs.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
	kyle@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch is right though the log entry and comment are perhaps misleading.
The effect of the patch is to restore the compiler behavior to what it was
before.  What it was before includes cases of producing .eh_frame and cases
of not producing it.  The default behavior of a gcc-4.4 that was built
against new enough binutils has diverged, so that some situations that
before produced no .eh_frame now do produce one.  -fno-dwarf2-cfi-asm
tells gcc to behave like it did before (which is also how 4.4 behaves when
built against an old enough binutils).


Thanks,
Roland
