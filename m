Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xchcv6jx7zDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 19:16:31 +1000 (AEST)
Subject: Re: [PATCH] fix memory leak on kvm_vm_ioctl_create_spapr_tce
From: David Hildenbrand <david@redhat.com>
To: Paul Mackerras <paulus@ozlabs.org>, Nixiaoming <nixiaoming@huawei.com>
Cc: "agraf@suse.com" <agraf@suse.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20170822142823.69425-1-nixiaoming@huawei.com>
 <95fe182a-fd21-77a1-33df-0e609c2845fd@redhat.com>
 <8fd9a878-a8ce-5576-9a5c-1c221ff6ded7@redhat.com>
 <E490CD805F7529488761C40FD9D26EF1299B4667@DGGEMA505-MBX.china.huawei.com>
 <20170823060624.GA13958@fergus.ozlabs.ibm.com>
 <aa600c47-d6d5-161d-419d-51ac30d67ee4@redhat.com>
Message-ID: <99351d36-2fc6-d5b5-1ce2-bdd9bcbd68f4@redhat.com>
Date: Wed, 23 Aug 2017 11:16:24 +0200
MIME-Version: 1.0
In-Reply-To: <aa600c47-d6d5-161d-419d-51ac30d67ee4@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>> +               mutex_unlock(&kvm->lock);
>>> +               kvm_put_kvm(kvm);
>>> +               goto fail;
>>> +       }
>>> +       return ret;
> 
> of simply
> 
> if (!ret)

if (ret >= 0)
	return ret;

is of course what I meant :)

> 	return 0;
> 
> mutex_lock(&kvm->lock);
> list_del_rcu(&stt->list);
> mutex_unlock(&kvm->lock);
> kvm_put_kvm(kvm);


-- 

Thanks,

David
