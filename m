Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id AC645B7E93
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 02:35:53 +1100 (EST)
Received: by gyd10 with SMTP id 10so1084193gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 08:35:51 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100318144836.21082.93040.stgit@angua>
References: <20100318144836.21082.93040.stgit@angua>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 09:35:30 -0600
Message-ID: <fa686aa41003180835k5af2d0e4o11f8ab9ca2e905ed@mail.gmail.com>
Subject: Re: [V2 PATCH 00/10] of: Consolidate scattered device node pointers
	in struct device
To: davem@davemloft.net, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, michal.simek@petalogix.com,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 18, 2010 at 9:22 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> Currently, each of_device has a copy of the device tree node pointer in b=
oth
> .node, and in .dev.archdata.of_node (microblaze and powerpc) or
> .dev.archdata.prom_node (sparc). =A0Also, other architectures will be add=
ing
> CONFIG_OF support, and they will also need a reference to the device tree
> node pointer from struct device.
>
> This series consolidates the device node pointer by adding .of_node to
> struct device (conditional on CONFIG_OF) and removing the archdata.of_nod=
e,
> archdata.prom_node and of_device.node users. =A0The pointer is moved out =
of
> dev_archdata and into struct device proper so that of_node doesn't need t=
o
> get manually added to archdata for each architecture that enables CONFIG_=
OF.

This series is also available in my git tree:

git://git.secretlab.ca/git/linux-2.6 experimental-devicetree
