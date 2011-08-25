Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E63D6B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 23:26:05 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/alternative; boundary=Apple-Mail-62-964096392
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110825123146.GD1923@amd.com>
Date: Thu, 25 Aug 2011 08:25:45 -0500
Message-Id: <EC0C2298-1EC9-42A0-9A71-3671E21BCA56@suse.de>
References: <4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822172508.GJ2079@amd.com>
	<1314040622.6866.268.camel@x201.home>
	<20110823131441.GN2079@amd.com>
	<1314119311.2859.59.camel@bling.home>
	<20110824085213.GB2079@amd.com>
	<1314198467.2859.192.camel@bling.home>
	<20110825123146.GD1923@amd.com>
To: "Roedel, Joerg" <joerg.roedel@amd.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, chrisw <chrisw@sous-sol.org>,
	Alex Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-62-964096392
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 25.08.2011, at 07:31, Roedel, Joerg wrote:

> On Wed, Aug 24, 2011 at 11:07:46AM -0400, Alex Williamson wrote:
>> On Wed, 2011-08-24 at 10:52 +0200, Roedel, Joerg wrote:
>=20

[...]

>> We need to try the polite method of attempting to hot unplug the =
device
>> from qemu first, which the current vfio code already implements.  We =
can
>> then escalate if it doesn't respond.  The current code calls abort in
>> qemu if the guest doesn't respond, but I agree we should also be
>> enforcing this at the kernel interface.  I think the problem with the
>> hard-unplug is that we don't have a good revoke mechanism for the =
mmio
>> mmaps.
>=20
> For mmio we could stop the guest and replace the mmio region with a
> region that is filled with 0xff, no?

Sure, but that happens in user space. The question is how does kernel =
space enforce an MMIO region to not be mapped after the hotplug event =
occured? Keep in mind that user space is pretty much untrusted here - it =
doesn't have to be QEMU. It could just as well be a generic user space =
driver. And that can just ignore hotplug events.


Alex


--Apple-Mail-62-964096392
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><br><div><div>On 25.08.2011, at 07:31, Roedel, Joerg wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div>On =
Wed, Aug 24, 2011 at 11:07:46AM -0400, Alex Williamson =
wrote:<br><blockquote type=3D"cite">On Wed, 2011-08-24 at 10:52 +0200, =
Roedel, Joerg wrote:<br></blockquote><font class=3D"Apple-style-span" =
color=3D"#540000"><br></font></div></blockquote><div><br></div><div>[...]<=
/div><br><blockquote type=3D"cite"><div><blockquote type=3D"cite">We =
need to try the polite method of attempting to hot unplug the =
device<br></blockquote><blockquote type=3D"cite">from qemu first, which =
the current vfio code already implements. &nbsp;We =
can<br></blockquote><blockquote type=3D"cite">then escalate if it =
doesn't respond. &nbsp;The current code calls abort =
in<br></blockquote><blockquote type=3D"cite">qemu if the guest doesn't =
respond, but I agree we should also be<br></blockquote><blockquote =
type=3D"cite">enforcing this at the kernel interface. &nbsp;I think the =
problem with the<br></blockquote><blockquote type=3D"cite">hard-unplug =
is that we don't have a good revoke mechanism for the =
mmio<br></blockquote><blockquote =
type=3D"cite">mmaps.<br></blockquote><br>For mmio we could stop the =
guest and replace the mmio region with a<br>region that is filled with =
0xff, no?<br></div></blockquote><div><br></div><div>Sure, but that =
happens in user space. The question is how does kernel space enforce an =
MMIO region to not be mapped after the hotplug event occured? Keep in =
mind that user space is pretty much untrusted here - it doesn't have to =
be QEMU. It could just as well be a generic user space driver. And that =
can just ignore hotplug =
events.</div><div><br></div><div><br></div><div>Alex</div></div><br></body=
></html>=

--Apple-Mail-62-964096392--
