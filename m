Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E87352C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 09:32:52 +1000 (EST)
Date: Wed, 29 May 2013 18:32:45 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
To: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <1369763138.18630.3@snotra> <51A53E20.3020205@ozlabs.ru>
 <1369784115.18630.27@snotra> <51A547F0.8090406@ozlabs.ru>
 <1369857949.18630.42@snotra> <51A68AE9.6070709@ozlabs.ru>
 <1369869272.18630.47@snotra> <51A68F49.6020908@ozlabs.ru>
In-Reply-To: <51A68F49.6020908@ozlabs.ru> (from aik@ozlabs.ru on Wed May 29
 18:29:13 2013)
Message-ID: <1369870365.18630.48@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2013 06:29:13 PM, Alexey Kardashevskiy wrote:
> On 05/30/2013 09:14 AM, Scott Wood wrote:
> > On 05/29/2013 06:10:33 PM, Alexey Kardashevskiy wrote:
> >> On 05/30/2013 06:05 AM, Scott Wood wrote:
> >> > But you didn't put it in the same section as =20
> KVM_CREATE_SPAPR_TCE.  0xe0
> >> > begins a different section.
> >>
> >> It is not really obvious that there are sections as no comment =20
> defines
> >> those :)
> >
> > There is a comment /* ioctls for fds returned by KVM_CREATE_DEVICE =20
> */
> >
> > Putting KVM_CREATE_DEVICE in there was mainly to avoid dealing with =20
> the
> > ioctl number conflict mess in the vm-ioctl section, but at least =20
> that one
> > is related to the device control API. :-)
> >
> >> But yes, makes sense to move it up a bit and change the code to =20
> 0xad.
> >
> > 0xad is KVM_KVMCLOCK_CTRL
>=20
> That's it. I am _completely_ confused now. No system whatsoever :(
> What rule should I use in order to choose the number for my new =20
> ioctl? :)

Yeah, it's a mess.  0xaf seems to be free. :-)

-Scott=
