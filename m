Return-Path: <roland@redhat.com>
Received: from QMTA08.emeryville.ca.mail.comcast.net
	(qmta08.emeryville.ca.mail.comcast.net [76.96.30.80])
	by ozlabs.org (Postfix) with ESMTP id DFC7CDDDFA
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 11:21:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: linuxppc-dev@ozlabs.org
Subject: how to check for "optional" ppc chip features (MSR_BE)
Message-Id: <20080502012118.96ED926FA07@magilla.localdomain>
Date: Thu,  1 May 2008 18:21:18 -0700 (PDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've been looking at PowerISA_Public.pdf that I downloaded from some ppc
site.  It describes various things as "need not be supported on all
implementations", for example the MSR_BE bit.  Is there a generic way to
detect if such a feature is supported, or a known table of models that
support features, or what?

Right now I'm considering MSR_BE (branch tracing).  I have a patch to use
this (arch_has_block_step, enabling a PTRACE_SINGLEBLOCK).  The only
machine handy to test is a Mac G5 (PPC970FX, 3.0 (pvr 003c 0300)).  I know
this chip supports MSR_BE.  But that's only because I wrote an affirmative
test case and tried it and saw it work right.  

Before submitting the kernel changes, I want to get the CPU model
conditionalization correct (a runtime check on some feature bit mask is
fine here, if CONFIG_* alone does not indicate for sure).


Thanks,
Roland
