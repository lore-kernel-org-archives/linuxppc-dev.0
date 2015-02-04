Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB2B91A09D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 01:30:45 +1100 (AEDT)
Message-ID: <54D22D10.2040502@suse.de>
Date: Wed, 04 Feb 2015 15:30:40 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org
Subject: Re: [PATCH 4/5] powerpc: Cleanup KVM emulated load/store endian
 handling
References: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
 <1422941785-22557-5-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1422941785-22557-5-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=windows-1252
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mdroth@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03.02.15 06:36, David Gibson wrote:
> Sometimes the KVM code on powerpc needs to emulate load or store
> instructions from the guest, which can include both normal and byte
> reversed forms.
> 
> We currently (AFAICT) handle this correctly, but some variable names are
> very misleading.  In particular we use "is_bigendian" in several places to
> actually mean "is the IO the same endian as the host", but we now support
> little-endian powerpc hosts.  This also ties into the misleadingly named
> ld_le*() and st_le*() functions, which in fact always byteswap, even on
> an LE host.
> 
> This patch cleans this up by renaming to more accurate "host_swabbed", and
> uses the generic swab*() functions instead of the powerpc specific and
> misleadingly named ld_le*() and st_le*() functions.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
