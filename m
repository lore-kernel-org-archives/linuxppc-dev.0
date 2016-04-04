Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdjZ52pKWzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 17:01:01 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id e190so4045553pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Apr 2016 00:01:00 -0700 (PDT)
Subject: Re: PR KVM and TM issues
To: Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20160404164457.539a55f0@kryten>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <57021123.6050506@ozlabs.ru>
Date: Mon, 4 Apr 2016 17:00:51 +1000
MIME-Version: 1.0
In-Reply-To: <20160404164457.539a55f0@kryten>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/04/2016 04:44 PM, Anton Blanchard wrote:
> Hi,
>
> I can't get an Ubuntu Wily guest to boot on an Ubuntu Wily host in PR KVM
> mode. The kernel in both cases is 4.2. To reproduce:
>
> wget -N https://cloud-images.ubuntu.com/wily/current/wily-server-cloudimg-ppc64el-disk1.img
>
> qemu-system-ppc64 -cpu POWER8 -enable-kvm -machine pseries,kvm-type=PR -m 4G -nographic -vga none -drive file=wily-server-cloudimg-ppc64el-disk1.img,if=virtio
>
> Should TM work inside a PR KVM guest?

If I read the kernel code correctly (kvmppc_set_one_reg_hv vs. 
kvmppc_set_one_reg_pr), no, it should not be expected to work.




-- 
Alexey
