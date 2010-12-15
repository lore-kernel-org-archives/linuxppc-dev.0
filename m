Return-Path: <baringforge@gmail.com>
Received: from mail-fx0-f44.google.com (mail-fx0-f44.google.com
	[209.85.161.44]) by ozlabs.org (Postfix) with ESMTP id B032A1007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Dec 2010 07:40:27 +1100 (EST)
Received: by fxm9 with SMTP id 9so2676730fxm.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 12:40:24 -0800 (PST)
MIME-Version: 1.0
Sender: baringforge@gmail.com
In-Reply-To: <3F607A5180246847A760FD34122A1E0503B1D8@039-SN1MPN1-003.039d.mgd.msft.net>
References: <AANLkTinwP6kQvWjSO3cxNUqd7tx7dhGEShTdKQXj-+iD@mail.gmail.com>
	<3F607A5180246847A760FD34122A1E0503B1D8@039-SN1MPN1-003.039d.mgd.msft.net>
From: Thomas Taranowski <tom@baringforge.com>
Date: Wed, 15 Dec 2010 12:40:02 -0800
Message-ID: <AANLkTi=OpBXJ04snjY2XGECCRv3zX-zomj4+r=UgeyT7@mail.gmail.com>
Subject: Re: RapidIO: multiple mport support for QorIQ
To: Li Yang-R58472 <R58472@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
>> There is some divergance in respect to the memory map that is non-trivia=
l that
>> I'm not sure how to handle, since it totally hoses the common fsl_rio.c =
structures.
>> I think I want to create a new set that's p2020 specific, but has potent=
ial to be
>> shared with the other QorIQ series, so dumping the pseries-specific code=
 into
>> platforms/pseries seems like a reasonable way to go. =A0Thoughts?
>
> The dual-port RIO is very common on QorIQ chips. =A0I won't suggest you a=
dd P2020 specific memory map file. =A0The two port memory map should also b=
e compatible with one port driver.
>

Should be, but isn't.  For the most part the new registers introduced
match up with the pad present in the previous processors, but not for
the atmu registers.  They are wildly inconsistent, and I don't see a
way to make them compatible.

# The current implementation
struct rio_atmu_regs {
        u32 rowtar;
        u32 rowtear;
        u32 rowbar;
        u32 pad2;
        u32 rowar;
        u32 pad3[3];
};

# The QorIQ p2020 register set.
struct rio_atmu_outb_window_regs {
    u32 rowtar0;    /* Outbound window translation address register 0 *
    u32 rowtear0;   /* Outbound window ext. address register 0 */
    u32 pad;        /* There is no rowbar0. Believe it. */
    u32 rowar0;     /* Outbound window attribute register 1 */
    u32 rowtar1;    /* Outbound window translation address register 1 *
    u32 rowtear1;   /* Outbound window ext. translation address registe
    u32 rowbar1;    /* Outbound window base address register 1 */
    u32 rowar1;     /* Outbound window attributes register 1 */
    u32 rowsr1[3];  /* Outbound window segment  register 1 */
};

struct rio_atmu_inb_window_regs {
    u32 iwtar;      /* Inbound window translation address register. */
    u32 iwbar;      /* Inbound window base address register. */
    u32 iwar;       /* Ibound window attribute register. */
};

struct rio_atmu_regs {
    rio_atmu_outb_window_regs outb_window[8]; /* window 1-8, upcounting
    rio atmu_inb_window_regs  inb_window[4] /* window 4-1, downcounting
};




> -Leo
>
>
