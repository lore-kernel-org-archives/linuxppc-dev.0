Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0143.outbound.protection.outlook.com [207.46.100.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB3F41A0B75
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:26:10 +1000 (AEST)
Message-ID: <1442888756.19102.215.camel@freescale.com>
Subject: Re: [PATCH v10 4/5] QE/CPM: move muram management functions to
 qe_common
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Mon, 21 Sep 2015 21:25:56 -0500
In-Reply-To: <SN1PR0301MB1550904DB13E3FDD7C9930099B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
 <1442560521-19354-4-git-send-email-qiang.zhao@freescale.com>
 <20150921225405.GB12709@home.buserror.net>
 <SN1PR0301MB1550904DB13E3FDD7C9930099B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 21:23 -0500, Zhao Qiang-B45475 wrote:
> On Tue, Sep 22, 2015 at 06:54AM +0800, Wood Scott-B07421 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, September 22, 2015 6:54 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH v10 4/5] QE/CPM: move muram management functions to
> > qe_common
> > 
> > On Fri, Sep 18, 2015 at 03:15:20PM +0800, Zhao Qiang wrote:
> > > QE and CPM have the same muram, they use the same management
> > > functions. Now QE support both ARM and PowerPC, it is necessary to
> > > move QE to "driver/soc", so move the muram management functions from
> > > cpm_common to qe_common for preparing to move QE code to "driver/soc"
> > > 
> > > Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> > > ---
> > > Changes for v2:
> > >   - no changes
> > > Changes for v3:
> > >   - no changes
> > > Changes for v4:
> > >   - no changes
> > > Changes for v5:
> > >   - no changes
> > > Changes for v6:
> > >   - using genalloc instead rheap to manage QE MURAM
> > >   - remove qe_reset from platform file, using
> > >   - subsys_initcall to call qe_init function.
> > 
> > Why is the init change in the same patch as moving the muram code?
> > 
> > > Changes for v7:
> > >   - move this patch from 3/3 to 2/3
> > >   - convert cpm with genalloc
> > >   - check for gen_pool allocation failure Changes for v8:
> > >   - rebase
> > >   - move BD_SC_* macro instead of copy
> > > Changes for v9:
> > >   - doesn't modify CPM, add a new patch to modify.
> > >   - rebase
> > > Changes for v10:
> > >   - rebase
> > > 
> > >  arch/powerpc/include/asm/cpm.h            |  59 --------
> > >  arch/powerpc/include/asm/qe.h             |  51 ++++++-
> > >  arch/powerpc/platforms/83xx/km83xx.c      |   2 -
> > >  arch/powerpc/platforms/83xx/mpc832x_mds.c |   2 -
> > >  arch/powerpc/platforms/83xx/mpc832x_rdb.c |   2 -
> > >  arch/powerpc/platforms/83xx/mpc836x_mds.c |   2 -
> > >  arch/powerpc/platforms/83xx/mpc836x_rdk.c |   3 -
> > >  arch/powerpc/platforms/85xx/common.c      |   1 -
> > >  arch/powerpc/sysdev/cpm_common.c          | 206 +---------------------
> > ---
> > >  arch/powerpc/sysdev/qe_lib/Makefile       |   2 +-
> > >  arch/powerpc/sysdev/qe_lib/qe.c           |  15 ++
> > >  arch/powerpc/sysdev/qe_lib/qe_common.c    | 242
> > ++++++++++++++++++++++++++++++
> > >  12 files changed, 302 insertions(+), 285 deletions(-)  create mode
> > > 100644 arch/powerpc/sysdev/qe_lib/qe_common.c
> > > 
> > > diff --git a/arch/powerpc/include/asm/cpm.h
> > > b/arch/powerpc/include/asm/cpm.h index 4398a6c..003a736 100644
> > > --- a/arch/powerpc/include/asm/cpm.h
> > > +++ b/arch/powerpc/include/asm/cpm.h
> > > @@ -93,22 +93,6 @@ typedef struct cpm_buf_desc {
> > >   */
> > > 
> > >  #define BD_SC_EMPTY      (0x8000)        /* Receive is empty */
> > > -#define BD_SC_READY      (0x8000)        /* Transmit is ready */
> > > -#define BD_SC_WRAP       (0x2000)        /* Last buffer descriptor */
> > > -#define BD_SC_INTRPT     (0x1000)        /* Interrupt on change */
> > > -#define BD_SC_LAST       (0x0800)        /* Last buffer in frame */
> > > -#define BD_SC_TC (0x0400)        /* Transmit CRC */
> > > -#define BD_SC_CM (0x0200)        /* Continuous mode */
> > > -#define BD_SC_ID (0x0100)        /* Rec'd too many idles */
> > > -#define BD_SC_P          (0x0100)        /* xmt preamble */
> > > -#define BD_SC_BR (0x0020)        /* Break received */
> > > -#define BD_SC_FR (0x0010)        /* Framing error */
> > > -#define BD_SC_PR (0x0008)        /* Parity error */
> > > -#define BD_SC_NAK        (0x0004)        /* NAK - did not respond */
> > > -#define BD_SC_OV (0x0002)        /* Overrun */
> > > -#define BD_SC_UN (0x0002)        /* Underrun */
> > > -#define BD_SC_CD (0x0001)        /* */
> > > -#define BD_SC_CL (0x0001)        /* Collision */
> > 
> > What does this have to do with muram?
> 
> BD is Buffer Descriptors, it is in muram.

What does it have to do with the muram *allocator*?

> > 
> > I've said many times now that any changes to the code, including renaming
> > functions, needs to be a separate patch from moving the code.
> 
> I have split a patch to two patches, However, Maybe I misunderstand your 
> means.

I didn't say "split it into two patches, however you like".  I said to have 
all changes in one patch, and the other patch be nothing but a move.  
Renaming the functions counts as a change.

> So if the patch just do the renaming and moving cpm_muram function to 
> qe_muram function,
> Does it ok?

No.

-Scott
