Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 42FDEDDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 21:44:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
Date: Tue, 19 Aug 2008 13:42:29 +0200
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808191342.29918.arnd@arndb.de>
Cc: hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 August 2008, ehrhardt@linux.vnet.ibm.com wrote:
> Dependent on the already existing CONFIG_KVM_GUEST config option this patch
> changes wrteei to wrtee allowing the hypervisor to rewrite those to nontrapping
> instructions. Maybe we should split the kvm guest otpimizations in two parts
> one for the overhead free optimizations and on for the rest that might add
> some complexity for non virtualized execution (like this one).
> 
> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

How significant is the performance impact of this change for non-virtualized
systems? If it's very low, maybe you should not bother with the #ifdef, and
if it's noticable, you might be better off using dynamic patching for this.

	Arnd <><
