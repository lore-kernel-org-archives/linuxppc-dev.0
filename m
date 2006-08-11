Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 70B9267B68
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 15:09:41 +1000 (EST)
Date: Fri, 11 Aug 2006 00:01:59 -0500
To: paulus@samba.org
Subject: [PATCH 0/2]: powerpc: Cpu init cleanups
Message-ID: <20060811050159.GA5879@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Attached are two patches to cleanup the cpu inits a bit. First one just
renames cpu_setup_power4.S to cpu_setup_ppc970.S, since that's really
what it contains. No functional changes at all in there to simplify
review.

Second patch renames some of the setup functions, and make the restore
functions come of the cputable instead of being hardcoded. Current setup
makes it awkward to add new cpus without editing the ppc970 setup/restore
functions or add more PVR checks in the assembly, which would be nice
to avoid. Only the really early one is still needed in assembly, since
cputables have not yet been setup at that point.

Earlier patch submission was all baked together, which makes it harder
to review and tell what is new and not.

Boot tested on PowerMac and POWER5. Please consider for 2.6.19 merge
window.


Thanks,

Olof
