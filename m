Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgS5q087dzDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 07:02:39 +1000 (AEST)
Date: Sun, 27 Aug 2017 22:02:20 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Nixiaoming <nixiaoming@huawei.com>, David Hildenbrand <david@redhat.com>,
 "agraf@suse.com" <agraf@suse.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] fix memory leak on kvm_vm_ioctl_create_spapr_tce
Message-ID: <20170827210220.GG5426@ZenIV.linux.org.uk>
References: <20170822142823.69425-1-nixiaoming@huawei.com>
 <95fe182a-fd21-77a1-33df-0e609c2845fd@redhat.com>
 <8fd9a878-a8ce-5576-9a5c-1c221ff6ded7@redhat.com>
 <E490CD805F7529488761C40FD9D26EF1299B4667@DGGEMA505-MBX.china.huawei.com>
 <20170823060624.GA13958@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823060624.GA13958@fergus.ozlabs.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 23, 2017 at 04:06:24PM +1000, Paul Mackerras wrote:

> It seems to me that it would be better to do the anon_inode_getfd()
> call before the kvm_get_kvm() call, and go to the fail label if it
> fails.

And what happens if another thread does close() on the (guessed) fd?
