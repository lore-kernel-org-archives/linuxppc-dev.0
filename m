Return-Path: <ruscur@russell.cc>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0SPH0PTbzDsNr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 15:15:12 +1100 (AEDT)
Message-ID: <1513570501.2133.2.camel@russell.cc>
Subject: Re: [PATCH v1 2/7] powerpc/kernel: Add uevents in EEH error/resume
From: Russell Currey <ruscur@russell.cc>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com,  eli@mellanox.com, saeedm@mellanox.com
Date: Mon, 18 Dec 2017 15:15:01 +1100
In-Reply-To: <20171213153242.98015-3-bryantly@linux.vnet.ibm.com>
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-3-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-12-13 at 09:32 -0600, Bryant G. Ly wrote:
> Devices can go offline when EEH is reported. This patch adds
> a change to the kernel object and lets udev know of error.
> When device resumes a change is also set reporting device as
> online. Therefore, EEH events are better propagated to user
> space for devices in powerpc arch.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> 

It would probably also be useful to communicate when recovery fails and
a device is no longer usable, so userspace knows not to keep waiting
for recovery to complete.
