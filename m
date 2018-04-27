Return-Path: <ruscur@russell.cc>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XFXf3fhvzF25Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 10:43:14 +1000 (AEST)
Message-ID: <1524789288.2096.0.camel@russell.cc>
Subject: Re: [PATCH] powerpc/eeh: Avoid misleading message "EEH: no capable
 adapters found"
From: Russell Currey <ruscur@russell.cc>
To: "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: kernel@gpiccoli.net
Date: Fri, 27 Apr 2018 10:34:48 +1000
In-Reply-To: <1521771052-5973-1-git-send-email-maurosr@linux.vnet.ibm.com>
References: <1521771052-5973-1-git-send-email-maurosr@linux.vnet.ibm.com>
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

On Thu, 2018-03-22 at 23:10 -0300, Mauro S. M. Rodrigues wrote:
> Due to recent refactoring in EEH in:
> commit b9fde58db7e5 ("powerpc/powernv: Rework EEH initialization on
> powernv")
> a misleading message was seen in the kernel message buffer:
> 
> [    0.108431] EEH: PowerNV platform initialized
> [    0.589979] EEH: No capable adapters found
> 
> This happened due to the removal of the initialization delay for
> powernv
> platform.
> 
> Even though the EEH infrastructure for the devices is eventually
> initialized and still works just fine the eeh device probe step is
> postponed in order to assure the PEs are created. Later
> pnv_eeh_post_init does the probe devices job but at that point the
> message was already shown right after eeh_init flow.
> 
> This patch introduces a new flag EEH_POSTPONED_PROBE to represent
> that
> temporary state and avoid the message mentioned above and showing the
> follow one instead:
> 
> [    0.107724] EEH: PowerNV platform initialized
> [    4.844825] EEH: PCI Enhanced I/O Error Handling Enabled
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>

Good idea, thanks for the patch.

Acked-by: Russell Currey <ruscur@russell.cc>
