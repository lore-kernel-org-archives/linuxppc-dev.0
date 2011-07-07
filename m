Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 0BC49B6F6F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jul 2011 17:48:39 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 02544-09 for <linuxppc-dev@ozlabs.org>;
	Thu,  7 Jul 2011 08:48:33 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/4] powerpc: Enable lockup and hung task detectors in
	pseriesand ppc64 defeconfigs
Date: Thu, 7 Jul 2011 08:46:30 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ADE3@saturn3.aculab.com>
In-Reply-To: <20110706231337.327165192@samba.org>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Anton Blanchard" <anton@samba.org>,
	<benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> As a result of changes to Kconfig files, we no longer enable
> the lockup and hung task detectors. Both are very light weight
> and provide useful information in the event of a hang, so
> reenable them.
...
> +CONFIG_LOCKUP_DETECTOR=3Dy
> +CONFIG_DETECT_HUNG_TASK=3Dy

Is one of thise responsible for generating a kernel stack traceback
when a process has been sleeping uninterruptably for a 'long' time?

We have a kernel subsystem that has several 'worker' threads,
these always sleep uninterruptable (they are shut down by explicit
request) and, at times, can be idle for long periods.

Perhaps it should be possible to disable the check either on
a per-process of per sleep basis?

	David
