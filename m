Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 552F2DDF7C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 06:29:35 +1000 (EST)
Date: Thu, 12 Apr 2007 14:04:38 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: qla_wxyz pci_set_mwi question
Message-ID: <20070412200438.GM26692@parisc-linux.org>
References: <20070411221507.69c97257.randy.dunlap@oracle.com>
	<20070412172038.GG10124@andrew-vasquezs-computer.local>
	<20070412185347.GL26692@parisc-linux.org>
	<20070412193713.GB14510@andrew-vasquezs-computer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070412193713.GB14510@andrew-vasquezs-computer.local>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, scsi <linux-scsi@vger.kernel.org>,
	gregkh <greg@kroah.com>, David Somayajulu <david.somayajulu@qlogic.com>,
	linuxppc-dev@ozlabs.org, linux-driver@qlogic.com,
	PCI <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2007 at 12:37:13PM -0700, Andrew Vasquez wrote:
> On Thu, 12 Apr 2007, Matthew Wilcox wrote:
> > Why should it fail?  If there's a platform which can't support a
> > cacheline size that the qla2xyz card can handle, it should be able to
> > happily fall back to doing plain writes instead of MWIs.  IMO, it should
> > just call pci_set_mwi() and ignore the result.
> 
> I believe there were some erratas on some ISP2xxx chips where MWI
> needed to be set for proper operation.  I'll go back, verify and
> update the patch accordingly.

Hmm.  The thing is that pci_set_mwi() returns success on machines where
MWI is disabled (currently only PPC64).  Perhaps it needs to fail
instead.
