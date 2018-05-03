Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c6XW239SzF2Tk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 17:41:30 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id a13-v6so12521465pgu.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 00:41:30 -0700 (PDT)
Date: Thu, 3 May 2018 15:41:25 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/11] KVM: PPC: reconstruct mmio emulation with
 analyse_instr()
Message-ID: <20180503074125.GA6755@simonLocalRHEL7.x64>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <20180503053117.GA6795@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503053117.GA6795@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 03:31:17PM +1000, Paul Mackerras wrote:
> On Wed, Apr 25, 2018 at 07:54:33PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > We already have analyse_instr() which analyzes instructions for the instruction
> > type, size, addtional flags, etc. What kvmppc_emulate_loadstore() did is somehow
> > duplicated and it will be good to utilize analyse_instr() to reconstruct the
> > code. The advantage is that the code logic will be shared and more clean to be 
> > maintained.
> > 
> > This patch series reconstructs kvmppc_emulate_loadstore() for various load/store
> > instructions. 
> > 
> > The testcase locates at:
> > https://github.com/justdoitqd/publicFiles/blob/master/test_mmio.c
> > 
> > - Tested at both PR/HV KVM. 
> > - Also tested with little endian host & big endian guest.
> > 
> > Tested instruction list: 
> > 	lbz lbzu lbzx ld ldbrx
> > 	ldu ldx lfd lfdu lfdx
> > 	lfiwax lfiwzx lfs lfsu lfsx
> > 	lha lhau lhax lhbrx lhz
> > 	lhzu lhzx lvx lwax lwbrx
> > 	lwz lwzu lwzx lxsdx lxsiwax
> > 	lxsiwzx lxsspx lxvd2x lxvdsx lxvw4x
> > 	stb stbu stbx std stdbrx
> > 	stdu stdx stfd stfdu stfdx
> > 	stfiwx stfs stfsx sth sthbrx
> > 	sthu sthx stvx stw stwbrx
> > 	stwu stwx stxsdx stxsiwx stxsspx
> > 	stxvd2x stxvw4x
> 
> Thanks for doing this.  It's nice to see that this makes the code 260
> lines smaller.
> 
> I have some comments on the individual patches, which I will give in
> replies to those patches.
> 
> Paul.
Thanks for those good comment. I will check them.

BR,
- Simon
