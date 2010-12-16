Return-Path: <baringforge@gmail.com>
Received: from mail-fx0-f44.google.com (mail-fx0-f44.google.com
	[209.85.161.44]) by ozlabs.org (Postfix) with ESMTP id 88591B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Dec 2010 16:22:27 +1100 (EST)
Received: by fxm9 with SMTP id 9so3088917fxm.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 21:22:25 -0800 (PST)
MIME-Version: 1.0
Sender: baringforge@gmail.com
In-Reply-To: <AANLkTi=OpBXJ04snjY2XGECCRv3zX-zomj4+r=UgeyT7@mail.gmail.com>
References: <AANLkTinwP6kQvWjSO3cxNUqd7tx7dhGEShTdKQXj-+iD@mail.gmail.com>
	<3F607A5180246847A760FD34122A1E0503B1D8@039-SN1MPN1-003.039d.mgd.msft.net>
	<AANLkTi=OpBXJ04snjY2XGECCRv3zX-zomj4+r=UgeyT7@mail.gmail.com>
From: Thomas Taranowski <tom@baringforge.com>
Date: Wed, 15 Dec 2010 21:22:02 -0800
Message-ID: <AANLkTimCvoxmyQWa7T+o-3DY25H2q26Pu9u4KUmxP3y=@mail.gmail.com>
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

I actually take most of this back, it looks like there is a path
available so as not to fork the driver for the pseries.

Thomas Taranowski
Certified netburner consultant
baringforge.com



On Wed, Dec 15, 2010 at 12:40 PM, Thomas Taranowski <tom@baringforge.com> w=
rote:
>>
>>> There is some divergance in respect to the memory map that is non-trivi=
al that
>>> I'm not sure how to handle, since it totally hoses the common fsl_rio.c=
 structures.
>>> I think I want to create a new set that's p2020 specific, but has poten=
tial to be
>>> shared with the other QorIQ series, so dumping the pseries-specific cod=
e into
>>> platforms/pseries seems like a reasonable way to go. =A0Thoughts?
>>
>> The dual-port RIO is very common on QorIQ chips. =A0I won't suggest you =
add P2020 specific memory map file. =A0The two port memory map should also =
be compatible with one port driver.
>>
>
> Should be, but isn't. =A0For the most part the new registers introduced
> match up with the pad present in the previous processors, but not for
> the atmu registers. =A0They are wildly inconsistent, and I don't see a
> way to make them compatible.
>
> # The current implementation
> struct rio_atmu_regs {
> =A0 =A0 =A0 =A0u32 rowtar;
> =A0 =A0 =A0 =A0u32 rowtear;
> =A0 =A0 =A0 =A0u32 rowbar;
> =A0 =A0 =A0 =A0u32 pad2;
> =A0 =A0 =A0 =A0u32 rowar;
> =A0 =A0 =A0 =A0u32 pad3[3];
> };
>
> # The QorIQ p2020 register set.
> struct rio_atmu_outb_window_regs {
> =A0 =A0u32 rowtar0; =A0 =A0/* Outbound window translation address registe=
r 0 *
> =A0 =A0u32 rowtear0; =A0 /* Outbound window ext. address register 0 */
> =A0 =A0u32 pad; =A0 =A0 =A0 =A0/* There is no rowbar0. Believe it. */
> =A0 =A0u32 rowar0; =A0 =A0 /* Outbound window attribute register 1 */
> =A0 =A0u32 rowtar1; =A0 =A0/* Outbound window translation address registe=
r 1 *
> =A0 =A0u32 rowtear1; =A0 /* Outbound window ext. translation address regi=
ste
> =A0 =A0u32 rowbar1; =A0 =A0/* Outbound window base address register 1 */
> =A0 =A0u32 rowar1; =A0 =A0 /* Outbound window attributes register 1 */
> =A0 =A0u32 rowsr1[3]; =A0/* Outbound window segment =A0register 1 */
> };
>
> struct rio_atmu_inb_window_regs {
> =A0 =A0u32 iwtar; =A0 =A0 =A0/* Inbound window translation address regist=
er. */
> =A0 =A0u32 iwbar; =A0 =A0 =A0/* Inbound window base address register. */
> =A0 =A0u32 iwar; =A0 =A0 =A0 /* Ibound window attribute register. */
> };
>
> struct rio_atmu_regs {
> =A0 =A0rio_atmu_outb_window_regs outb_window[8]; /* window 1-8, upcountin=
g
> =A0 =A0rio atmu_inb_window_regs =A0inb_window[4] /* window 4-1, downcount=
ing
> };
>
>
>
>
>> -Leo
>>
>>
>
