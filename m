Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5959CC3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 13:28:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69212077B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 13:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69212077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JRPv0VCZzDr6y
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 23:28:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JRKr4TcjzDr31
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 23:24:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46JRKq2bxWz9sDQ;
 Wed, 28 Aug 2019 23:24:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [DOC][PATCH] powerpc: Provide initial documentation for PAPR
 hcalls
In-Reply-To: <be5dc005-dfa5-31ad-87e2-54cef8e70508@linux.vnet.ibm.com>
References: <20190827152326.2784-1-vaibhav@linux.ibm.com>
 <be5dc005-dfa5-31ad-87e2-54cef8e70508@linux.vnet.ibm.com>
Date: Wed, 28 Aug 2019 23:24:30 +1000
Message-ID: <87d0gpv2wh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, msuchanek@suse.de,
 Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> Le 27/08/2019 =C3=A0 17:23, Vaibhav Jain a =C3=A9crit=C2=A0:
>> This doc patch provides an initial description of the hcall op-codes
>> that are used by Linux kernel running as a guest (LPAR) on top of
>> PowerVM or any other sPAPR compliant hyper-visor (e.g qemu).
>>=20
>> Apart from documenting the hcalls the doc-patch also provides a
>> rudimentary overview of how hcall ABI, how they are issued with the
>> Linux kernel and how information/control flows between the guest and
>> hypervisor.
>>=20
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>
> Hi Vaibhav,
>
> Thanks for documenting this.
>
> Besides my few remarks below, please consider:
>
> Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
>
>> ---
>> Change-log:
>>=20
>> Initial version of this doc-patch was posted and reviewed as part of
>> the patch-series "[PATCH v5 0/4] powerpc/papr_scm: Workaround for
>> failure of drc bind after kexec"
>> https://patchwork.ozlabs.org/patch/1136022/. Changes introduced on top
>> the original patch:
>>=20
>> * Replaced the of term PHYP with Hypervisor to indicate both
>> PowerVM/Qemu [Laurent]
>> * Emphasized that In/Out arguments to hcalls are in Big-endian format
>> [Laurent]
>> * Fixed minor word repetition, spell issues and grammatical error
>> [Michal, Mpe]
>> * Replaced various variant of term 'hcall' with a single
>> variant. [Mpe]
>> * Changed the documentation format from txt to ReST. [Mpe]
>> * Changed the name of documentation file to papr_hcalls.rst. [Mpe]
>> * Updated the section describing privileged operation by hypervisor
>> to be more accurate [Mpe].
>> * Fixed up mention of register notation used for describing
>> hcalls. [Mpe]
>> * s/NVDimm/NVDIMM [Mpe]
>> * Added section on return values from hcall [Mpe]
>> * Described H_CONTINUE return-value for long running hcalls.
>> ---
>>   Documentation/powerpc/papr_hcalls.rst | 200 ++++++++++++++++++++++++++
>>   1 file changed, 200 insertions(+)
>>   create mode 100644 Documentation/powerpc/papr_hcalls.rst
>>=20
>> diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/power=
pc/papr_hcalls.rst
>> new file mode 100644
>> index 000000000000..7afc0310de29
>> --- /dev/null
>> +++ b/Documentation/powerpc/papr_hcalls.rst
>> @@ -0,0 +1,200 @@
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> +Hypercall Op-codes (hcalls)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> +
>> +Overview
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Virtualization on 64-bit Power Book3S Platforms is based on the PAPR
>> +specification [1]_ which describes the run-time environment for a guest
>> +operating system and how it should interact with the hypervisor for
>> +privileged operations. Currently there are two PAPR compliant hyperviso=
rs:
>> +
>> +- **IBM PowerVM (PHYP)**: IBM's proprietary hypervisor that supports AI=
X,
>> +  IBM-i and  Linux as supported guests (termed as Logical Partitions
>> +  or LPARS). It supports the full PAPR specification.
>> +
>> +- **Qemu/KVM**: Supports PPC64 linux guests running on a PPC64 linux ho=
st.
>> +  Though it only implements a subset of PAPR specification called LoPAP=
R [2]_.
>> +
>> +On PPC64 arch a guest kernel running on top of a PAPR hypervisor is cal=
led
>> +a *pSeries guest*. A pseries guest runs in a supervisor mode (HV=3D0) a=
nd must
>> +issue hypercalls to the hypervisor whenever it needs to perform an acti=
on
>> +that is hypervisor priviledged [3]_ or for other services managed by the
>> +hypervisor.
>> +
>> +Hence a Hypercall (hcall) is essentially a request by the pSeries guest
>> +asking hypervisor to perform a privileged operation on behalf of the gu=
est. The
>> +guest issues a with necessary input operands. The hypervisor after perf=
orming
>                   ^ hcall ?
>
>> +the privilege operation returns a status code and output operands back =
to the
>> +guest.
>> +
>> +HCALL ABI
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +The ABI specification for a hcall between a pSeries guest and PAPR hype=
rvisor
>> +is covered in section 14.5.3 of ref [2]_. Switch to the  Hypervisor con=
text is
>> +done via the instruction **HVCS** that expects the Opcode for hcall is =
set in *r3*
>> +and any in-arguments for the hcall are provided in registers *r4-r12* in
>> +Big-endian byte order.
> Indeed, register valuer are not byte ordered, only values passed through=
=20
> buffer in memory are byte ordered.
>
> Should it be explicitly said that Big-endian order is only concerning dat=
a=20
> stored in memory?
> What about something like that:
> "...any in-arguments for the hcall are provided in registers *r4-r12*. If=
=20
> values have to be passed through a memory buffer, the data stored in that=
=20
> buffer are in Big-endian order."

Yes that would be better.

I guess to be pedantic every structure passed in memory needs to be
defined in PAPR and could have some arbitrary ordering, but in practice
everything is big endian.

cheers
