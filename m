Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk7mW4D4vzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 12:55:39 +1000 (AEST)
Message-ID: <1467687331.13965.27.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix oops in pcibios_release_device() after
 pcibios_free_controller()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 05 Jul 2016 12:55:31 +1000
In-Reply-To: <1467683085-3537-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1467683085-3537-1-git-send-email-mauricfo@linux.vnet.ibm.com>
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

On Mon, 2016-07-04 at 22:44 -0300, Mauricio Faria de Oliveira wrote:
> It's possible to hit an oops/crash if pcibios_release_device() accesses the
> phb struct and it had been freed earlier -- by pcibios_free_controller() --
> as the memory it pointed to can be reused.
> 
> If after reuse 'phb->controller_ops.release_device' is non-NULL it will be
> called, but it points to an invalid location (that function pointer is not
> set anywhere in the code, so if it's non-NULL, that's not correct), and so
> it hits an oops and the system crashes.
> 
> The solution is to verify whether 'phb' is still in 'hose_list' before any
> access to it in pcibios_release_device() -- as it is removed from the list
> by pcibios_free_controller() -- and ensure it cannot be used after kfree().
> 
> That problem can happen with the pSeries platform's DLPAR remove operation
> if references to devices are held until after the pcibios_free_controller()
> function runs, and then released - exercising pcibios_release_device() path.

Have you considered instead adding a kref to the PHB and only freeing
it when all devices have been freed ? Or it's too hard to tract device
creation ?

Ben.
