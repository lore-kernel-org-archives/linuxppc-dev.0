Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS54N6HL3zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 14:06:28 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS54N0CHkz9s85
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 14:06:27 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L33Vjm080013
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 22:06:26 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r1204ur6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 22:06:25 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 13:06:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7C8AC2BB0045
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 14:06:20 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L36Cw76881504
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 14:06:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L35mA7018287
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 14:05:48 +1100
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_DDF4BF2D-38BD-403C-8D87-F090E0DA9BCE"
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: next-20170217 boot on POWER8 LPAR : WARNING
 @kernel/jump_label.c:287
Date: Tue, 21 Feb 2017 08:35:04 +0530
In-Reply-To: <1dffdaac-be8b-0052-52d4-a65fed39f894@akamai.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>
To: Jason Baron <jbaron@akamai.com>
References: <E6A8A7A8-6A55-4989-BAE9-39274876CA3C@linux.vnet.ibm.com>
 <1dffdaac-be8b-0052-52d4-a65fed39f894@akamai.com>
Message-Id: <02B52EFB-4608-47F3-A81C-B8B52DB11233@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_DDF4BF2D-38BD-403C-8D87-F090E0DA9BCE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 20-Feb-2017, at 8:27 PM, Jason Baron <jbaron@akamai.com> wrote:
>=20
> Hi,
>=20
> On 02/19/2017 09:07 AM, Sachin Sant wrote:
>> While booting next-20170217 on a POWER8 LPAR following
>> warning is displayed.
>>=20
>> Reverting the following commit helps boot cleanly.
>> commit 3821fd35b5 :  jump_label: Reduce the size of struct static_key
>>=20
>> [   11.393008] ------------[ cut here ]------------
>> [   11.393031] WARNING: CPU: 5 PID: 2890 at kernel/jump_label.c:287 =
static_key_set_entries.isra.10+0x3c/0x50
>=20
> Thanks for the report. So this is saying that the jump_entry table is
> not at least 4-byte aligned. I wonder if this fixes it up?
>=20

Yes. With this patch the warning is gone.

Thanks
-Sachin
>=20
> diff --git a/arch/powerpc/include/asm/jump_label.h
> b/arch/powerpc/include/asm/jump_label.h
> index 9a287e0ac8b1..f870a85bac46 100644
> --- a/arch/powerpc/include/asm/jump_label.h
> +++ b/arch/powerpc/include/asm/jump_label.h
> @@ -24,6 +24,7 @@ static __always_inline bool =
arch_static_branch(struct
> static_key *key, bool bran
> 	asm_volatile_goto("1:\n\t"
> 		 "nop # arch_static_branch\n\t"
> 		 ".pushsection __jump_table,  \"aw\"\n\t"
> +		 ".balign 4 \n\t"
> 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
> 		 ".popsection \n\t"
> 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
> @@ -38,6 +39,7 @@ static __always_inline bool
> arch_static_branch_jump(struct static_key *key, bool
> 	asm_volatile_goto("1:\n\t"
> 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
> 		 ".pushsection __jump_table,  \"aw\"\n\t"
> +		 ".balign 4 \n\t"
> 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
> 		 ".popsection \n\t"
> 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
> @@ -63,6 +65,7 @@ struct jump_entry {
> #define ARCH_STATIC_BRANCH(LABEL, KEY)		\
> 1098:	nop;					\
> 	.pushsection __jump_table, "aw";	\
> +	.balign 4;				\
> 	FTR_ENTRY_LONG 1098b, LABEL, KEY;	\
> 	.popsection
> #endif
>=20
>=20
> Thanks,
>=20
> -Jason
>=20
>> [   11.393035] Modules linked in: nfsd(+) ip_tables x_tables autofs4
>> [   11.393043] CPU: 5 PID: 2890 Comm: modprobe Not tainted =
4.10.0-rc8-next-20170217-autotest #1
>> [   11.393047] task: c0000003a5692500 task.stack: c0000003a7774000
>> [   11.393051] NIP: c0000000017bcffc LR: c0000000017bd46c CTR: =
0000000000000000
>> [   11.393054] REGS: c0000003a7777800 TRAP: 0700   Not tainted  =
(4.10.0-rc8-next-20170217-autotest)
>> [   11.393058] MSR: 800000000282b033 =
<SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
>> [   11.393065]   CR: 48248282  XER: 00000001
>> [   11.393070] CFAR: c0000000017bcfcc SOFTE: 1
>> GPR00: c0000000017bd42c c0000003a7777a80 c00000000262ce00 =
d000000003fdd580
>> GPR04: d000000003fe07df 0000000100000017 c0000000017bcd50 =
0000000000000000
>> GPR08: 0000000000053a09 0000000000000001 c00000000254ce00 =
0000000000000001
>> GPR12: c000000001b56c40 c00000000ea81400 0000000000000020 =
d000000005081098
>> GPR16: c0000003a7777da0 c0000003a7777dec 0000000000000000 =
00000000000084a8
>> GPR20: d000000003fef000 d000000003fe2b28 c00000000252dc90 =
0000000000000001
>> GPR24: c00000000254d314 0000000000000000 c0000000025338f8 =
d000000003fe089f
>> GPR28: 0000000000000000 d000000003fe1400 d000000003fdd578 =
d000000003fe07df
>> [   11.393115] NIP [c0000000017bcffc] =
static_key_set_entries.isra.10+0x3c/0x50
>> [   11.393119] LR [c0000000017bd46c] =
jump_label_module_notify+0x20c/0x420
>> [   11.393122] Call Trace:
>> [   11.393125] [c0000003a7777a80] [c0000000017bd42c] =
jump_label_module_notify+0x1cc/0x420 (unreliable)
>> [   11.393132] [c0000003a7777b40] [c0000000016b38e0] =
notifier_call_chain+0x90/0x100
>> [   11.393137] [c0000003a7777b90] [c0000000016b3db0] =
__blocking_notifier_call_chain+0x60/0x90
>> [   11.393142] [c0000003a7777be0] [c0000000017357bc] =
load_module+0x1c1c/0x2750
>> [   11.393147] [c0000003a7777d70] [c000000001736550] =
SyS_finit_module+0xc0/0xf0
>> [   11.393152] [c0000003a7777e30] [c0000000015cb8e0] =
system_call+0x38/0xfc
>> [   11.393156] Instruction dump:
>> [   11.393158] 40c20018 e9230000 792907a0 7c844b78 f8830000 4e800020 =
3d42fff2 892a0514
>> [   11.393166] 2f890000 40feffe0 39200001 992a0514 <0fe00000> =
4bffffd0 60000000 60000000
>> [   11.393173] ---[ end trace a5f8fbc5d8226aec ]---
>>=20
>> Have attached boot log.
>>=20
>> Thanks
>> -Sachin
>>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" =
in
> the body of a message to majordomo@vger.kernel.org =
<mailto:majordomo@vger.kernel.org>
> More majordomo info at  http://vger.kernel.org/majordomo-info.html =
<http://vger.kernel.org/majordomo-info.html>

--Apple-Mail=_DDF4BF2D-38BD-403C-8D87-F090E0DA9BCE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 20-Feb-2017, at 8:27 PM, Jason Baron &lt;<a =
href=3D"mailto:jbaron@akamai.com" class=3D"">jbaron@akamai.com</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Hi,</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><br style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">On 02/19/2017 09:07 AM, Sachin Sant =
wrote:</span><br style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">While booting next-20170217 =
on a POWER8 LPAR following<br class=3D"">warning is displayed.<br =
class=3D""><br class=3D"">Reverting the following commit helps boot =
cleanly.<br class=3D"">commit 3821fd35b5 : &nbsp;jump_label: Reduce the =
size of struct static_key<br class=3D""><br class=3D"">[ =
&nbsp;&nbsp;11.393008] ------------[ cut here ]------------<br =
class=3D"">[ &nbsp;&nbsp;11.393031] WARNING: CPU: 5 PID: 2890 at =
kernel/jump_label.c:287 static_key_set_entries.isra.10+0x3c/0x50<br =
class=3D""></blockquote><br style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Thanks for the report. So this is saying =
that the jump_entry table is</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">not at least 4-byte aligned. I =
wonder if this fixes it up?</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><br style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div>Yes. With this =
patch the warning is gone.</div><div><br =
class=3D""></div><div>Thanks</div><div>-Sachin<br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D""><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">diff --git =
a/arch/powerpc/include/asm/jump_label.h</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" =
class=3D"">b/arch/powerpc/include/asm/jump_label.h</span><br =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">index 9a287e0ac8b1..f870a85bac46 =
100644</span><br style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">--- =
a/arch/powerpc/include/asm/jump_label.h</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">+++ =
b/arch/powerpc/include/asm/jump_label.h</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">@@ -24,6 +24,7 @@ static =
__always_inline bool arch_static_branch(struct</span><br =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">static_key *key, bool bran</span><br =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">asm_volatile_goto("1:\n\t"</span><br =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>"nop # =
arch_static_branch\n\t"</span><br style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>".pushsection __jump_table, =
&nbsp;\"aw\"\n\t"</span><br style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">+</span><span class=3D"Apple-tab-span" =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>".balign 4 \n\t"</span><br =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>JUMP_ENTRY_TYPE "1b, =
%l[l_yes], %c0\n\t"</span><br style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>".popsection =
\n\t"</span><br style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>: : &nbsp;"i" (&amp;((char =
*)key)[branch]) : : l_yes);</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">@@ -38,6 +39,7 @@ static =
__always_inline bool</span><br style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">arch_static_branch_jump(struct static_key =
*key, bool</span><br style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: pre; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">asm_volatile_goto("1:\n\t"</span><br =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>"b %l[l_yes] # =
arch_static_branch_jump\n\t"</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>".pushsection __jump_table, =
&nbsp;\"aw\"\n\t"</span><br style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">+</span><span class=3D"Apple-tab-span" =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>".balign 4 \n\t"</span><br =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>JUMP_ENTRY_TYPE "1b, =
%l[l_yes], %c0\n\t"</span><br style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>".popsection =
\n\t"</span><br style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>: : &nbsp;"i" (&amp;((char =
*)key)[branch]) : : l_yes);</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">@@ -63,6 +65,7 @@ struct =
jump_entry {</span><br style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">#define ARCH_STATIC_BRANCH(LABEL, =
KEY)</span><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">\</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">1098:</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">nop;</span><span class=3D"Apple-tab-span" =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">\</span><br style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">.pushsection __jump_table, =
"aw";</span><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">\</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">+</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">.balign 4;</span><span class=3D"Apple-tab-span" =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
class=3D"Apple-tab-span" style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: pre; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;">	</span><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">\</span><br style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">FTR_ENTRY_LONG 1098b, LABEL, =
KEY;</span><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">\</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span class=3D"Apple-tab-span" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">	=
</span><span style=3D"font-family: Menlo-Regular; font-size: 11px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">.popsection</span><br style=3D"font-family:=
 Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">#endif</span><br =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family:=
 Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><br style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Thanks,</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><br style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">-Jason</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><br style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">[ &nbsp;&nbsp;11.393035] =
Modules linked in: nfsd(+) ip_tables x_tables autofs4<br class=3D"">[ =
&nbsp;&nbsp;11.393043] CPU: 5 PID: 2890 Comm: modprobe Not tainted =
4.10.0-rc8-next-20170217-autotest #1<br class=3D"">[ =
&nbsp;&nbsp;11.393047] task: c0000003a5692500 task.stack: =
c0000003a7774000<br class=3D"">[ &nbsp;&nbsp;11.393051] NIP: =
c0000000017bcffc LR: c0000000017bd46c CTR: 0000000000000000<br =
class=3D"">[ &nbsp;&nbsp;11.393054] REGS: c0000003a7777800 TRAP: 0700 =
&nbsp;&nbsp;Not tainted &nbsp;(4.10.0-rc8-next-20170217-autotest)<br =
class=3D"">[ &nbsp;&nbsp;11.393058] MSR: 800000000282b033 =
&lt;SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE&gt;<br class=3D"">[ =
&nbsp;&nbsp;11.393065] &nbsp;&nbsp;CR: 48248282 &nbsp;XER: 00000001<br =
class=3D"">[ &nbsp;&nbsp;11.393070] CFAR: c0000000017bcfcc SOFTE: 1<br =
class=3D"">GPR00: c0000000017bd42c c0000003a7777a80 c00000000262ce00 =
d000000003fdd580<br class=3D"">GPR04: d000000003fe07df 0000000100000017 =
c0000000017bcd50 0000000000000000<br class=3D"">GPR08: 0000000000053a09 =
0000000000000001 c00000000254ce00 0000000000000001<br class=3D"">GPR12: =
c000000001b56c40 c00000000ea81400 0000000000000020 d000000005081098<br =
class=3D"">GPR16: c0000003a7777da0 c0000003a7777dec 0000000000000000 =
00000000000084a8<br class=3D"">GPR20: d000000003fef000 d000000003fe2b28 =
c00000000252dc90 0000000000000001<br class=3D"">GPR24: c00000000254d314 =
0000000000000000 c0000000025338f8 d000000003fe089f<br class=3D"">GPR28: =
0000000000000000 d000000003fe1400 d000000003fdd578 d000000003fe07df<br =
class=3D"">[ &nbsp;&nbsp;11.393115] NIP [c0000000017bcffc] =
static_key_set_entries.isra.10+0x3c/0x50<br class=3D"">[ =
&nbsp;&nbsp;11.393119] LR [c0000000017bd46c] =
jump_label_module_notify+0x20c/0x420<br class=3D"">[ =
&nbsp;&nbsp;11.393122] Call Trace:<br class=3D"">[ =
&nbsp;&nbsp;11.393125] [c0000003a7777a80] [c0000000017bd42c] =
jump_label_module_notify+0x1cc/0x420 (unreliable)<br class=3D"">[ =
&nbsp;&nbsp;11.393132] [c0000003a7777b40] [c0000000016b38e0] =
notifier_call_chain+0x90/0x100<br class=3D"">[ &nbsp;&nbsp;11.393137] =
[c0000003a7777b90] [c0000000016b3db0] =
__blocking_notifier_call_chain+0x60/0x90<br class=3D"">[ =
&nbsp;&nbsp;11.393142] [c0000003a7777be0] [c0000000017357bc] =
load_module+0x1c1c/0x2750<br class=3D"">[ &nbsp;&nbsp;11.393147] =
[c0000003a7777d70] [c000000001736550] SyS_finit_module+0xc0/0xf0<br =
class=3D"">[ &nbsp;&nbsp;11.393152] [c0000003a7777e30] =
[c0000000015cb8e0] system_call+0x38/0xfc<br class=3D"">[ =
&nbsp;&nbsp;11.393156] Instruction dump:<br class=3D"">[ =
&nbsp;&nbsp;11.393158] 40c20018 e9230000 792907a0 7c844b78 f8830000 =
4e800020 3d42fff2 892a0514<br class=3D"">[ &nbsp;&nbsp;11.393166] =
2f890000 40feffe0 39200001 992a0514 &lt;0fe00000&gt; 4bffffd0 60000000 =
60000000<br class=3D"">[ &nbsp;&nbsp;11.393173] ---[ end trace =
a5f8fbc5d8226aec ]---<br class=3D""><br class=3D"">Have attached boot =
log.<br class=3D""><br class=3D"">Thanks<br class=3D"">-Sachin<br =
class=3D""><br class=3D""></blockquote><span style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">--</span><br =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">To unsubscribe from this list: send the line =
"unsubscribe linux-next" in</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">the body of a message to<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"mailto:majordomo@vger.kernel.org" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" =
class=3D"">majordomo@vger.kernel.org</a><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Menlo-Regular; font-size: =
11px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">More majordomo info at =
&nbsp;</span><a href=3D"http://vger.kernel.org/majordomo-info.html" =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D"">http://vger.kernel.org/majordomo-info.html</a></div></blockquot=
e></div><br class=3D""></body></html>=

--Apple-Mail=_DDF4BF2D-38BD-403C-8D87-F090E0DA9BCE--
