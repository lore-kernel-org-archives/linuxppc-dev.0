Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18565.26804.757649.584391@cargo.ozlabs.ibm.com>
Date: Tue, 22 Jul 2008 14:57:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/16 v3] powerpc: iommu enablement for CMO
In-Reply-To: <20080704125459.GM1310@linux.vnet.ibm.com>
References: <20080704124449.GA1310@linux.vnet.ibm.com>
	<20080704125459.GM1310@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Jennings writes:

> To support Cooperative Memory Overcommitment (CMO), we need to check
> for failure from some of the tce hcalls.

This patch runs into context mismatches because of changes made by
Michael Ellerman's patch "Fix sparse warnings in
arch/powerpc/platforms/pseries" (now in Linus' tree), which changed
code like

	if (condition)
		return function_returning_void(args);

into

	if (condition) {
		function_returning_void(args);
		return;
	}

which will cause problems for your patch.  Please check if any of
these changes need to be undone again.

Paul.
