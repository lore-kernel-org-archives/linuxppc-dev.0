Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 28BEEB7D84
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 15:54:25 +1000 (EST)
Received: by gxk21 with SMTP id 21so685092gxk.15
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 22:54:24 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4C13C4D9.2030108@gatzka.org>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<4C13C4D9.2030108@gatzka.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 13 Jun 2010 23:54:04 -0600
Message-ID: <AANLkTim4d2Red_abGwrSbOQ-9FrM89pArFvo2ISbkWP2@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: stephan@gatzka.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 12, 2010 at 11:33 AM, Stephan Gatzka <stephan@gatzka.org> wrote=
:
> Hi Grant,
>
>> I've been doing a bit of work on some introductory level documentation
>> of the flattened device tree. =A0I've got a rough copy up on the
>> devicetree.org wiki, and I could use some feedback. =A0If anyone has
>> some time to look at it, you can find it here:
>>
>> http://devicetree.org/Device_Tree_Usage
>>
>> Thanks,
>> g.
>>
>
> this looks good. Maybe an example of a complete host/PCI bridge might be
> helpful. Probably I can write something during the next week.

Hi Stephan,

I see that you started drafting some of this on the wiki.  Thanks for
the draft you've done so far.  Some comments:

- Instead, of using an MPC5200 example, add a pci bus to the sample
Coyote's Revenge system used in the rest of the page and describe
that.  The goal of this document is to lead a user step-by-step how
each part of the device tree works.  So, instead of plopping down the
complete PCI bus node, the document should gradually build it up, and
talk about each element as it is added.  Focus on how it all works
together.

- It would be userful to also show a PCI-to-PCI bridge, and maybe a
fixed PCI device as children of the host bridge node.

- The current PCI nodes on all powerpc boards depend on a device_type
=3D "PCI" property, but I'd like to look at moving away from that for
new PCI controllers (device_type describes facilities in real open
firmware.  It shouldn't have any meaning in the flattened device
tree).  I need to look into the details though to see if it is
feasible or not.

- Describing the interrupt-map property will be particularly fiddly.
It could have a section all to itself before you even get to talking
about PCI irq swizzling.

Thanks again for the help!
g.
