Return-Path: <htejun@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbc535gytzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 00:48:39 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id 57so5089787qtu.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 07:48:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 21 Aug 2017 07:48:33 -0700
From: Tejun Heo <tj@kernel.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
Message-ID: <20170821144832.GE491396@devbig577.frc2.facebook.com>
References: <20170821134951.18848-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170821134951.18848-1-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 21, 2017 at 03:49:50PM +0200, Laurent Vivier wrote:
> In wq_numa_init() a list of NUMA nodes with their list of possible CPUs
> is built.
> 
> Unfortunately, on powerpc, the Firmware is only able to provide the
> node of a CPU if the CPU is present. So, in our case (possible CPU)
> CPU ids are known, but as the CPU is not present, the node id is
> unknown and all the unplugged CPUs are attached to node 0.

This is something powerpc needs to fix.  Workqueue isn't the only one
making this assumption.  mm as a whole assumes that CPU <-> node
mapping is stable regardless of hotplug events.  Powerpc people know
about the issue and AFAIK are working on it.

Thanks.

-- 
tejun
