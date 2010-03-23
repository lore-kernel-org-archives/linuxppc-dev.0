Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217]) by ozlabs.org (Postfix) with ESMTP id 07EEBB7CEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 18:07:06 +1100 (EST)
Received: by gxk9 with SMTP id 9so740996gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 00:07:04 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1269327424.5953.12.camel@concordia>
References: <20100318144836.21082.93040.stgit@angua>
	<1269327424.5953.12.camel@concordia>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 23 Mar 2010 01:06:42 -0600
Message-ID: <fa686aa41003230006v6098afe7s1bcb64f409f11a5a@mail.gmail.com>
Subject: Re: [V2 PATCH 00/10] of: Consolidate scattered device node pointers
	in struct device
To: michael@ellerman.id.au
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 23, 2010 at 12:57 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Thu, 2010-03-18 at 09:22 -0600, Grant Likely wrote:
>> Currently, each of_device has a copy of the device tree node pointer in =
both
>> .node, and in .dev.archdata.of_node (microblaze and powerpc) or
>> .dev.archdata.prom_node (sparc). =A0Also, other architectures will be ad=
ding
>> CONFIG_OF support, and they will also need a reference to the device tre=
e
>> node pointer from struct device.
>
> Assuming this is similar to your experimental-devicetree branch, as of
> 96b4b9d7 it causes a few build errors for me:
>
> http://kisskb.ellerman.id.au/kisskb/head/2688/
>
> Broken are 86xx/sbc8641d_defconfig, mpc83xx_defconfig,
> mpc885_ads_defconfig, mpc85xx_defconfig, and pmac32_defconfig.

Hey Michael,

Thanks for the testing.  I haven't built through all the defconfigs
yet so this doesn't surprise me too much that I've missed some
drivers.  The failure is caused in the last three commits which remove
the old variables.  I'll pick through the failing defconfigs, fix and
test them, and refresh my branch.

I'll let you know when the branch is updated.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
