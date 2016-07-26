Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzCvn3kS8zDqdc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 19:47:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] powernv/pci: Add PHB register dump debugfs handle
In-Reply-To: <1469511443.5228.2.camel@russell.cc>
References: <20160722052336.3340-1-ruscur@russell.cc>
 <146949753931.3859.11305398485148230358@concordia>
 <1469511443.5228.2.camel@russell.cc>
Date: Tue, 26 Jul 2016 19:47:10 +1000
Message-ID: <87vazsybmp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell Currey <ruscur@russell.cc> writes:

> On Tue, 2016-07-26 at 11:45 +1000, Michael Ellerman wrote:
>> Quoting Russell Currey (2016-07-22 15:23:36)
>>=20
>> DEFINE_SIMPLE_ATTRIBUTE(fops_foo, NULL, foo_set, "%llu\n");
>>=20
>> That requires that you write "1" to the file to trigger the reg dump.
>
> I don't think I can use this here. =C2=A0Triggering the diag dump on the =
given PHB
> (these are in /sys/kernel/debug/powerpc/PCI####), and that PHB is retriev=
ed from
> the file handler. =C2=A0It looks like I have no access to the file struct=
 if using a
> simple getter/setter.

You don't have access to the file struct, but you don't need it, can
register the fops with a data pointer.

So the DEFINE_SIMPLE_ATTRIBUTE() gives you a fops_foo, which you can
then do:

  debugfs_create_file("dump-regs", 0200, phb->dbgfs, hose, &fops_foo))

And then in foo_set() data =3D=3D hose.

cheers
