Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDF4B1A02AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 08:26:39 +1000 (AEST)
Date: Thu, 21 May 2015 08:26:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] KVM: PPC: Book3S: correct width in XER handling
Message-ID: <20150520222633.GA23106@iris.ozlabs.ibm.com>
References: <d0600fe7952351dfd176c97d416a6a351812a78b.1432099563.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d0600fe7952351dfd176c97d416a6a351812a78b.1432099563.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 20, 2015 at 03:26:12PM +1000, Sam Bobroff wrote:
> In 64 bit kernels, the Fixed Point Exception Register (XER) is a 64
> bit field (e.g. in kvm_regs and kvm_vcpu_arch) and in most places it is
> accessed as such.
> 
> This patch corrects places where it is accessed as a 32 bit field by a
> 64 bit kernel.  In some cases this is via a 32 bit load or store
> instruction which, depending on endianness, will cause either the
> lower or upper 32 bits to be missed.  In another case it is cast as a
> u32, causing the upper 32 bits to be cleared.
> 
> This patch corrects those places by extending the access methods to
> 64 bits.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
