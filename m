Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLmB91MddzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:08:49 +1100 (AEDT)
In-Reply-To: <1507809534-10721-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, mikey@neuling.org, paulus@samba.org,
 cyrilbur@gmail.com
Subject: Re: [5/4] KVM: PPC: Tie KVM_CAP_PPC_HTM to the user-visible TM feature
Message-Id: <3yLmB80ZYDz9s76@ozlabs.org>
Date: Tue, 24 Oct 2017 19:08:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-12 at 11:58:54 UTC, Michael Ellerman wrote:
> Currently we use CPU_FTR_TM to decide if the CPU/kernel can support
> TM (Transactional Memory), and if it's true we advertise that to
> Qemu (or similar) via KVM_CAP_PPC_HTM.
> 
> PPC_FEATURE2_HTM is the user-visible feature bit, which indicates that
> the CPU and kernel can support TM. Currently CPU_FTR_TM and
> PPC_FEATURE2_HTM always have the same value, either true or false, so
> using the former for KVM_CAP_PPC_HTM is correct.
> 
> However some Power9 CPUs can operate in a mode where TM is enabled but
> TM suspended state is disabled. In this mode CPU_FTR_TM is true, but
> PPC_FEATURE2_HTM is false. Instead a different PPC_FEATURE2 bit is
> set, to indicate that this different mode of TM is available.
> 
> It is not safe to let guests use TM as-is, when the CPU is in this
> mode. So to prevent that from happening, use PPC_FEATURE2_HTM to
> determine the value of KVM_CAP_PPC_HTM.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/2a3d6553cbd791da4fb624c2500b45

cheers
