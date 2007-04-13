Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet02.oracle.com (rgminet02.oracle.com [148.87.113.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F067DDF38
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 13:39:44 +1000 (EST)
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	by rgminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	l3D2dvCS009065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 20:40:03 -0600
Message-ID: <461EEDAA.7090503@oracle.com>
Date: Thu, 12 Apr 2007 19:40:42 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: qla_wxyz pci_set_mwi question
References: <20070411221507.69c97257.randy.dunlap@oracle.com>	
	<20070412172038.GG10124@andrew-vasquezs-computer.local>	
	<20070412185347.GL26692@parisc-linux.org>	
	<20070412193713.GB14510@andrew-vasquezs-computer.local>	
	<20070412200438.GM26692@parisc-linux.org>
	<1176431662.5764.56.camel@localhost.localdomain>
In-Reply-To: <1176431662.5764.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: scsi <linux-scsi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
	gregkh <greg@kroah.com>, David Somayajulu <david.somayajulu@qlogic.com>,
	linuxppc-dev@ozlabs.org, Andrew Vasquez <andrew.vasquez@qlogic.com>,
	linux-driver@qlogic.com, PCI <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2007-04-12 at 14:04 -0600, Matthew Wilcox wrote:
>> On Thu, Apr 12, 2007 at 12:37:13PM -0700, Andrew Vasquez wrote:
>>> On Thu, 12 Apr 2007, Matthew Wilcox wrote:
>>>> Why should it fail?  If there's a platform which can't support a
>>>> cacheline size that the qla2xyz card can handle, it should be able to
>>>> happily fall back to doing plain writes instead of MWIs.  IMO, it should
>>>> just call pci_set_mwi() and ignore the result.
>>> I believe there were some erratas on some ISP2xxx chips where MWI
>>> needed to be set for proper operation.  I'll go back, verify and
>>> update the patch accordingly.
>> Hmm.  The thing is that pci_set_mwi() returns success on machines where
>> MWI is disabled (currently only PPC64).  Perhaps it needs to fail
>> instead.
> 
> MWI isn't diabled on ppc64... or did I miss something ?
> 
> Ben.
> 

Willy was referring to this from include/asm-powerpc/pci.h:

#ifdef CONFIG_PPC64

/*
 * We want to avoid touching the cacheline size or MWI bit.
 * pSeries firmware sets the cacheline size (which is not the cpu cacheline
 * size in all cases) and hardware treats MWI the same as memory write.
 */
#define PCI_DISABLE_MWI


which makes pci_set_mwi() do nothing other than return 0;


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
