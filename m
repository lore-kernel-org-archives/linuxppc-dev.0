Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1644D1A04BA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 22:59:52 +1000 (EST)
Message-ID: <537A0043.4050906@suse.de>
Date: Mon, 19 May 2014 14:59:47 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 7/8] powerpc/powernv: Implement ppc_call_opal()
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-8-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 14.05.14 06:12, Gavin Shan wrote:
> If we're running PowerNV platform, ppc_firmware() will be directed
> to ppc_call_opal() where we can call to OPAL API accordingly. In
> ppc_call_opal(), the input argument are parsed out and call to
> appropriate OPAL API to handle that. Each request passed to the
> function is identified with token. As we get to the function either
> from host owned application (e.g. errinjct) or VM, we always have
> the first parameter (so-called "virtual") to differentiate the
> cases.

This sounds like nonsense. A virtual parameter? What is that supposed to be?

I don't think you can use this interface for VM device management, as 
the syscall interface is (hopefully!) limited to CAP_ADMIN which you 
(hopefully!) don't have as VFIO user.


Alex
