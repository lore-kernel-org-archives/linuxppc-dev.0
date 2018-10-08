Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8FC677E4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 20:49:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529F22085B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 20:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529F22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TXXc1N0DzF3Fv
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 07:49:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=gromero@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TXVR4ddVzF3Bv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 07:47:27 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w98JmqWV112165
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Oct 2018 15:59:11 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n0b7mxc09-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 15:59:11 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Mon, 8 Oct 2018 13:59:10 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 8 Oct 2018 13:59:08 -0600
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w98Jx7QO46596096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Oct 2018 12:59:07 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE4447805E;
 Mon,  8 Oct 2018 13:59:07 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD7EE7805C;
 Mon,  8 Oct 2018 13:59:06 -0600 (MDT)
Received: from oc6336877782.ibm.com (unknown [9.85.197.166])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  8 Oct 2018 13:59:06 -0600 (MDT)
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: Looking for architecture papers
To: Raz <raziebe@gmail.com>
References: <CAPB=Z-rEoVWFFDBS_XhuOQyL+YxR8jScSAAQfO1X-n_Lbm=StA@mail.gmail.com>
 <87sh1nk70y.fsf@concordia.ellerman.id.au>
 <CAPB=Z-pLCkXcsAXD5YWt5pwPzFzJrdZsdDye_bZjE0-ea-Ur6A@mail.gmail.com>
Date: Mon, 8 Oct 2018 16:59:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPB=Z-pLCkXcsAXD5YWt5pwPzFzJrdZsdDye_bZjE0-ea-Ur6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100819-8235-0000-0000-00000E0F65F3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009843; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01099801; UDB=6.00568971; IPR=6.00879849; 
 MB=3.00023668; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-08 19:59:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100819-8236-0000-0000-000042EC55D9
Message-Id: <3f5ace27-7692-6d95-6e34-611d3eee3ead@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-08_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080186
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Raz,

On 10/04/2018 04:41 AM, Raz wrote:
> Frankly, the more I read the more perplexed I get. For example,
> according to BOOK III-S, chapter 3,
> the MSR bits are differ from the ones described in
> arch/powerpc/include/asm/reg.h.
> Bit zero, is LE, but in the book it is 64-bit mode.
> 
> Would someone be kind to explain what I do not understand?

Yes, I know that can be confusing at the first sight when one is used to, for
instance, x86.

x86 documents use LSB 0 notation, which means (as others already pointed out)
that the least significant bit of a value is marked as being bit 0.

On the other hand Power documents use MSB 0 notation, which means that the most
significant bit of a value is marked as being bit 0 and as a consequence the
least significant bit in that notation in a 64-bit platform is bit 63, not bit
0. MSB 0 notation is also known as IBM bit notation/bit numbering.

Historically LSB 0 notation tend to be used on docs about little-endian
architectures (for instance, x86), whilst MSB 0 notation tend to be used on docs
about big-endian architectures (for instance, Power - Power is actually a little
different because it's now bi-endian actually).

However LSB 0 and MSB 0 are only different notations, so LSB 0 can be employed
on a big-endian architecture documentation, and vice versa.

It happens that kernel code is written in C and for shifts, etc, it's convenient
the LSB 0 notation, not the MSB 0 notation, so it's convenient to use LSB 0
notation when creating a mask, like in arch/powerpc/include/asm/reg.h), i.e.
it's convenient to employ bit positions as '63 - <bit position in PowerISA>'.

So, as another example, in the following gcc macro '_TEXASR_EXTRACT_BITS' takes
a bit position 'BITNUM' as found in the PowerISA documentation but then for the
shift right it uses '63 - BITNUM':

https://github.com/gcc-mirror/gcc/blob/master/gcc/config/rs6000/htmintrin.h#L44-L45

I think it's also important to mention that on PowerISA the elements also follow
the MSB 0 notation. So byte, word, and dword elements in a register found in the
instruction descriptions when referred to 0 are the element "at the left tip",
i.e. "the most significant elements", so to speak. For instance, take
instruction "vperm": doc says 'index' takes bits 3:7 of a byte from [byte]
element 'i'. So for a byte element i=0 it means the most significant byte
("on the left tip") of vector register operand 'VRC'. Moreover, specified bits
in that byte element, i.e. bits 3:7,  also follow the MSB 0, so for the
little-endian addicted thought they are bits 4:0 (LSB 0 notation).

Now, if bits 4:0 = 0b00011 (decimal 3), we grab byte element 3 from 'src'
(256-bit). However byte element 3 is also in MSB 0 notation, so it means third
byte of 'src' but starting counting bytes from 0 from the left to the right
(which in IMO looks indeed more natural since we count, for instance, Natural
Numbers on the 'x' axis similarly).

Hence, it's like to say that 'vperm' instruction in a certain sense has a
"big-endian semantics" for the byte indices. The 'vpermr' instruction introduced
by PowerISA v3.0 is meant to cope with that, so 'vpermr' byte indices have a
"little-endian semantics", so for bits 3:7 MSB 0 (or bits 4:0 in LSB 0 notation) =
0b00011 (decimal 3), on the 'vpermr' instruction it really means we must count
bytes starting from right to left as in the LSB 0 notation and grab the third byte
element from right to left.

So, for instance:

vr0            uint128 = 0x00000000000000000000000000000000
vr1            uint128 = 0x00102030405060708090a0b0c0d0e0f0
vr2            uint128 = 0x01112233445566779999aabbccddeeff
vr3            uint128 = 0x03000000000000000000000000000000

we have 'src' as:

MSB 0:             v--- byte 0, 1, 2, 3, ...
LSB 0:                                                                                  ...  3, 2, 1, byte 0 ---v
src = vr1 || vr2 = 00 10 20 30 40 50 60 70 80 90 A0 B0 C0 D0 E0 F0 01 11 22 33 44 55 66 77 99 99 AA BB CC DD EE FF

vperm   vr0, vr1, vr2, vr3 result is:
vr0            uint128 = 0x30000000000000000000000000000000
byte 3 in MSB 0  = 0x30 ---^ and 0x00 (byte 0 in MSB 0) copied to the remaining bytes

whilst with vpermr (PowerISA v3.0 / POWER9):
vpermr   vr0, vr1, vr2, vr3 result is:
vr0            uint128 = 0xccffffffffffffffffffffffffffffff
byte 3 in LSB 0  = 0xCC----^ and 0xFF (byte 0 in LSB 0) copied to the remaining bytes


Anyway, vperm/vpermr was just an example about notation not being restricted to
bits on Power ISA. So read the docs carefully :) GDB is always useful for checking
if one's understanding about a given Power instruction is correct.

HTH.


Regards,
Gustavo

