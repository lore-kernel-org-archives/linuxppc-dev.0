Return-Path: <psomas@cslab.ece.ntua.gr>
Received: from diomedes.noc.ntua.gr (diomedes.noc.ntua.gr [147.102.222.220])
	by ozlabs.org (Postfix) with ESMTP id EC864B6F5D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Apr 2011 02:48:35 +1000 (EST)
From: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] ppc64: fix build error when compiling with gcc-4.6.0
Date: Mon, 18 Apr 2011 19:38:58 +0300
Message-Id: <1303144739-4407-1-git-send-email-psomas@cslab.ece.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The build error was reported at the Gentoo Bugzilla [1].

When compiling with gcc-4.6.0, a build error occurs: 
"variable ‘old’ set but not used [-Werror=unused-but-set-variable]
cc1: all warnings being treated as errors"

This patch removes the unnecessary assignments to the variable, which cause
the compiler warning (used but not set), and build failure, and removes it
completely.

I think it's ok to do that, since the variable wasn't actually used anywhere
inside those two functions that caused the warning. Right?

[1] https://bugs.gentoo.org/show_bug.cgi?id=363935
