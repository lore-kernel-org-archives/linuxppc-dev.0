Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86AD4DDE35
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 01:02:20 +1000 (EST)
Date: Wed, 26 Sep 2007 09:02:16 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 2/2]: PCI Error Recovery: Symbios SCSI First Failure
Message-ID: <20070926150216.GH3899@parisc-linux.org>
References: <20070420204114.GL31947@austin.ibm.com>
	<20070420204720.GM31947@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070420204720.GM31947@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 20, 2007 at 03:47:20PM -0500, Linas Vepstas wrote:
> Implement the so-called "first failure data capture" (FFDC) for the
> symbios PCI error recovery.  After a PCI error event is reported,
> the driver requests that MMIO be enabled. Once enabled, it 
> then reads and dumps assorted status registers, and concludes
> by requesting the usual reset sequence.

> +	/* Request that MMIO be enabled, so register dump can be taken. */
> +	return PCI_ERS_RESULT_CAN_RECOVER;
> +}

I'm a little concerned by the mention of MMIO.  It's entirely possible
for the sym2 driver to be using ioports to access the card rather than
MMIO.  Is it simply that it can't on the platform you test on?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
