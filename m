Return-Path: <anton@samba.org>
Date: Fri, 26 Jul 2013 12:23:25 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>, Alan Modra <amodra@gmail.com>, Ryan
 Arnold <ryanarn@us.ibm.com>
Subject: SIGSTKSZ/MINSIGSTKSZ too small on 64bit
Message-ID: <20130726122325.10b900e4@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

Alan has been looking at a glibc test fail. His analysis shows SEGVs
in signal handlers using sigaltstack, and that MINSIGSTKSZ and SIGSTKSZ
are too small.

We increased the size of rt_sigframe in commit 2b0a576d15e0
(powerpc: Add new transactional memory state to the signal context) but
didn't bump either SIGSTKSZ and MINSIGSTKSZ. We need to do that in both
the kernel and glibc, but I'm a bit worried we could have broken
existing applications that use sigaltstack.

Anton
