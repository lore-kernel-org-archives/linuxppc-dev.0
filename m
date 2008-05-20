Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D5783DDF0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 May 2008 07:26:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Instruction OCM
Date: Tue, 20 May 2008 14:26:15 -0700
In-reply-to: <200805201511.25957.temerkhanov@yandex.ru>
References: <012401c8b9c3$74b947c0$5e2bd740$@com>
	<4831CCA2.6000107@yandex.ru><016b01c8ba5a$9a621000$cf263000$@com>
	<200805201511.25957.temerkhanov@yandex.ru>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <temerkhanov@cifronik.ru>, "mojtaba" <kernelppc@gmail.com>,
	<linuxppc-embedded@ozlabs.org>, "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080520212616.B378E3A006D@mail99-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Ah yes, I forgot about that little detail with the OCM.

It would be slick if these mappings were generated based on memory nodes
in the device tree for ARCH=3Dpowerpc.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Temerkhanov
> Sent: Tuesday, May 20, 2008 4:11 AM
> To: mojtaba; linuxppc-embedded@ozlabs.org
> Subject: Re: Instruction OCM
> =

> On Tuesday 20 May 2008 13:19:26 mojtaba wrote:
> > Thank you for your email. But what is the solution to that? I have
seen
> > this in a thesis:
> >
> > "when using the OCM buses to connect memory, we can only use virtual
memory
> > as long as the virtual address is the same as the physical address,
which
> > is conceptually
> > the same as using a system without MMU. Therefore porting Linux to a
> > system based on an OCM memory system is not possible"
> >
> > http://ce.et.tudelft.nl/publicationfiles/1367_700_thesis.pdf
> >
> > Is that right? What do you suggest?
> >
> =

> =

> Getting OCM-based devices (and even memory) to work in Linux is
possible. All
> you need is to setup a mapping with virtual addresses equal to
physical (some
> info can be found here:
>
http://courses.ece.uiuc.edu/ece412/MP_Files/mp2/20060623-XUP-Linux-Tutor
ial-REVISION-FINAL.pdf)
> =

> Furthermore, if you really need to get the code running from OCM, I'd
suggest
> to setup such MMU mapping for OCM region very early - it can be done
in
> initial_mmu function at head_4xx.S. Look at line 936 (#if
> defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(SERIAL_DEBUG_IO_BASE))
>  - that's very good point to start.
> =

> Regards, Sergey Temerkhanov
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
