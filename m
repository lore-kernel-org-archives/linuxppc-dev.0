Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9FAC1A08D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 16:47:57 +1000 (EST)
In-Reply-To: <1412073306-13812-3-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 mpe@ellerman.id.au, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 02/17] powerpc/cell: Move data segment faulting code
 out of cell platform
Message-Id: <20141001064757.BFF88140174@ozlabs.org>
Date: Wed,  1 Oct 2014 16:47:57 +1000 (EST)
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-30-09 at 10:34:51 UTC, Michael Neuling wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> __spu_trap_data_seg() currently contains code to determine the VSID and ESID
> required for a particular EA and mm struct.
> 
> This code is generically useful for other co-processors.  This moves the code
> of the cell platform so it can be used by other powerpc code.  It also adds 1TB
> segment handling which Cell didn't have.

I'm not loving this.

For starters the name "copro_data_segment()" doesn't contain any verbs, and it
doesn't tell me what it does.

If we give it a name that says what it does, we get copro_get_ea_esid_and_vsid().
Or something equally ugly.

And then in patch 10 you move the bulk of the logic into calculate_vsid().

So instead can we:
 - add a small helper that does the esid calculation, eg. calculate_esid() ?
 - factor out the vsid logic into a helper, calculate_vsid() ?
 - rework the spu code to use those, dropping __spu_trap_data_seg()
 - use the helpers in the cxl code


cheers
