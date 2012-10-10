Return-Path: <srinivas.kandagatla@st.com>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
 [207.126.144.121])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 649412C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 05:34:01 +1100 (EST)
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: grant.likely@secretlab.ca
Subject: [PATCH 3.6.0- 0/2] POWERPC: use module_platform_driver macro
Date: Wed, 10 Oct 2012 19:32:17 +0100
Message-Id: <1349893937-7642-1-git-send-email-srinivas.kandagatla@st.com>
Cc: krafft@de.ibm.com, agust@denx.de, linuxppc-dev@lists.ozlabs.org,
 srinivas.kandagatla@st.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Running below Coccinelle lookup pattern like below on the 
latest kernel showed about 52 hits. This patch series is a subset 
of those 52 patches, so that it will be easy for maintainers to review.
Hopefully these patches will get rid of some code duplication in kernel.

@  @
- initfunc(void)
- { return platform_driver_register(&dr); }

...

- module_init(initfunc);
...

- exitfunc(void)
- { platform_driver_unregister(&dr); }

...

- module_exit(exitfunc);
+ module_platform_driver(dr); 

Srinivas Kandagatla (2):
  powerpc/mpc52xx: use module_platform_driver macro
  powerpc/sysdev: use module_platform_driver macro

 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   16 +---------------
 arch/powerpc/sysdev/pmi.c                     |   13 +------------
 2 files changed, 2 insertions(+), 27 deletions(-)
