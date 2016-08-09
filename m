Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7wLm3dMRzDrH9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 23:37:20 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Thiago Jung Bauermann' <bauerman@linux.vnet.ibm.com>, Mimi Zohar
 <zohar@linux.vnet.ibm.com>
CC: Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org"
 <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-ima-devel@lists.sourceforge.net"
 <linux-ima-devel@lists.sourceforge.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/7] ima: on soft reboot, restore the measurement list
Date: Tue, 9 Aug 2016 13:35:13 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F50D431@AcuExch.aculab.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
 <1470747673.2881.118.camel@linux.vnet.ibm.com> <3544655.o5QPxko4Ba@hactar>
In-Reply-To: <3544655.o5QPxko4Ba@hactar>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thiago Jung Bauermann
> Sent: 09 August 2016 14:19
...
> > > > +/* Some details preceding the binary serialized measurement list *=
/
> > > > +struct ima_kexec_hdr {
> > > > +	unsigned short version;
> > > > +	unsigned long buffer_size;
> > > > +	unsigned long count;
> > > > +} __packed;
> > > > +
> > >
> > > Am I understanding it correctly that this structure is passed between
> > > kernels?
> > Yes, the header prefixes the measurement list, which is being passed on
> > the same computer to the next kernel.  Could the architecture (eg.
> > LE/BE) change between soft re-boots?
>=20
> Yes. I am able to boot a BE kernel from an LE kernel with my patches.

64bit kernel to/from 32bit one? (if that makes sense on the hardware).

> Whether we want to support that or not is another question...

In which case shouldn't they be annotated with the endianness??

Also why '__packed' - guarantees sub-optimal code generation.
Much better to include explicit padding to align everything.

	David
