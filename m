Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 803601A0814
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:23:45 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/4] drivers/vfio: New IOCTL command VFIO_EEH_INFO
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1400631832.3986.154.camel@pasglop>
Date: Wed, 21 May 2014 08:23:41 +0200
Message-Id: <17FB3514-B4F0-437F-826F-C473AD4F139E@suse.de>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3AA7.7040106@suse.de> <537B3C68.8080102@suse.de>
 <20140520114031.GA20397@shangw> <537B4015.7030404@suse.de>
 <20140520122147.GA26483@shangw> <537B49C9.4000302@suse.de>
 <20140520123914.GA28441@shangw> <1400631832.3986.154.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 21.05.2014 um 02:23 schrieb Benjamin Herrenschmidt <benh@kernel.crashin=
g.org>:
>=20
> On Tue, 2014-05-20 at 22:39 +1000, Gavin Shan wrote:
>>>> Yeah. How about this? :-)
>>>>=20
>>>> - Move eeh-vfio.c to drivers/vfio/pci/
>>>> - =46rom eeh-vfio.c, dereference arch/powerpc/kernel/eeh.c::eeh_ops, wh=
ich
>>>>  is arch/powerpc/plaforms/powernv/eeh-powernv.c::powernv_eeh_ops. Call
>>>=20
>>> Hrm, I think it'd be nicer to just export individual functions that
>>> do thing you want to do from eeh.c.
>>=20
>> Ok. Got it. Thanks for your comments :)
>=20
> The interesting thing with this approach is that VFIO per-se can work
> with EEH RTAS backend too in the host.
>=20
> IE, with PR KVM for example or with non-KVM uses of VFIO, it would be
> possible to use a device in a user process and exploit EEH even when
> running under a PAPR hypervisor.
>=20
> That is, vfio-eeh uses "generic" exported EEH APIs from the EEH core
> that will work on both powernv and RTAS backends.
>=20
> Note to Alex: This definitely kills the notifier idea for now though,
> at least as a first class citizen of the design. We can add it as an
> optional optimization on top later.

I don't think it does. The notifier would just get triggered on config space=
 read failures for example :). It's really just an aid for the vfio user to h=
ave a common code path for error handling.


Alex
