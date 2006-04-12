Return-Path: <shawnxjin@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 61D8E679FC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 11:04:33 +1000 (EST)
Received: by nproxy.gmail.com with SMTP id l24so958432nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 18:04:32 -0700 (PDT)
Message-ID: <c3d0340b0604111804y5dd65d3em3d15625a9b0ac7da@mail.gmail.com>
Date: Tue, 11 Apr 2006 18:04:32 -0700
From: "Shawn Jin" <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: The behavior of L2 cache controller for PPC440
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm testing the error interrupts of a PPC440 L2 cache controller and
having some confusion about the bahvior of the tag parity error. I
hope here in the list there are some people had worked on this before
can shed some light on it.

I use the error injection bit in L2_CONFIG to generate tag parity
error. The L2 cache error handler comes from ibm440gx_common.c, which
uses CTP command to clear a tag error. However once a tag parity error
occurs, the handler keeps getting invoked and the error interrupt
keeps asserted. It looks like that the CTP command won't clear the tag
error or the tag error status bit in L2_STATUS.

The L2 cache controller spec only says that CTP command will reset the
tag trap address and way registers within the L2 design such that they
can trap a new error. From this statement I assume it doesn't clear
the status bit in L2_STATUS. If my assumption is correct, then the
L2_INTERRUPT will keep asserted until a CLEAR command invalidates the
trapped cache line. This is NOT implemented in the ibm440gx_common.c's
l2_error_handler().

However is it really necessary to use CLEAR command to invalidate the
cache line? The spec describes tag array parity in section 2.6, which
says tag parity errors are self correcting since the way with a tag
parity error will be LRUed out of the L2 cache. So it seems that no
explicit invalidation is required.

So my question is "Does or should the CTP command clear the status bit
in L2_STATUS?"

Thanks for your comments,
-Shawn.
