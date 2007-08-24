Return-Path: <dwh@ovro.caltech.edu>
Message-ID: <46CEFE1A.40905@ovro.caltech.edu>
Date: Fri, 24 Aug 2007 08:49:46 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Jose Almeida <jalmeida@sysgo.fr>
Subject: Re: little endian page mapping on PQ3
References: <B00307ADBC68954AA8D6FB3AC8FD66F30141DE36@rennsmail05.eu.thmulti.com>
	<46CED851.70002@sysgo.fr>
In-Reply-To: <46CED851.70002@sysgo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Joyeau Sylvain <Sylvain.Joyeau@thomson.net>, Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jose,

> I want to do using an mmap() entry point in a driver, in order to map 
> this to the user. Of course in that case ioremap() does not work.
> 
> Any Clue ?
> 

I used the little-endian flag on the Yosemite board (440EP)
to test what the flag did.

http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-762-Hawkins.pdf
http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz

Look at the mmap function in pci_io.c.

	/* PowerPC endian control
	 * - default is cleared, big-endian
	 */
#ifdef _PAGE_ENDIAN
	if (bar->little_endian) {
		pgprot_val(vma->vm_page_prot) |= _PAGE_ENDIAN;
	} else {
		pgprot_val(vma->vm_page_prot) &= ~_PAGE_ENDIAN;
	}
	if (pgprot_val(vma->vm_page_prot) & _PAGE_ENDIAN) {
		LOG_DEBUG("_PAGE_ENDIAN is set\n");
	} else {
		LOG_DEBUG("_PAGE_ENDIAN is not set\n");
	}
#endif

It might be the same for the PQ3 ... at least it'll be
pretty similar.

Dave
