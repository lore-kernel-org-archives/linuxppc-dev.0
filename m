Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdpWh1kw6zDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 20:44:16 +1000 (AEST)
Date: Mon, 4 Apr 2016 20:43:46 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander
 Graf <agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: PR KVM and TM issues
Message-ID: <20160404204346.1cf44df8@kryten>
In-Reply-To: <57021123.6050506@ozlabs.ru>
References: <20160404164457.539a55f0@kryten>
	<57021123.6050506@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alexey,

> > I can't get an Ubuntu Wily guest to boot on an Ubuntu Wily host in
> > PR KVM mode. The kernel in both cases is 4.2. To reproduce:
> >
> > wget -N https://cloud-images.ubuntu.com/wily/current/wily-server-cloudimg-ppc64el-disk1.img
> >
> > qemu-system-ppc64 -cpu POWER8 -enable-kvm -machine pseries,kvm-type=PR -m 4G -nographic -vga none -drive file=wily-server-cloudimg-ppc64el-disk1.img,if=virtio
> >
> > Should TM work inside a PR KVM guest?
> 
> If I read the kernel code correctly (kvmppc_set_one_reg_hv vs. 
> kvmppc_set_one_reg_pr), no, it should not be expected to work.

I see a couple of issues, patches to follow:

1. QEMU needs to clear the TM feature bit in the ibm,pa-features array
when running in PR KVM mode.

2. Linux needs to clear the user TM feature bits if TM gets disabled
at runtime via the ibm,pa-features bit.

Anton
