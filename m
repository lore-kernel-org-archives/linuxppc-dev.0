Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9wwJ5nCZzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 03:10:40 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3NH8uWS003644
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 13:10:33 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a0mqfb1pa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 13:10:33 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 24 Apr 2017 03:10:30 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3NHAKZ447513672
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 03:10:28 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3NH9teN018304
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 03:09:56 +1000
Date: Sun, 23 Apr 2017 17:09:34 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 4/7] powerpc/kprobes: Use safer string functions in
 kprobe_lookup_name()
To: Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, pc@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>
References: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170421123320.7344-1-naveen.n.rao@linux.vnet.ibm.com>
 <5393535f-4469-d6b7-f7ce-256a5612999f@us.ibm.com>
 <e3b3a444-fa98-5ed3-7dd7-a45d93db8b1f@us.ibm.com>
In-Reply-To: <e3b3a444-fa98-5ed3-7dd7-a45d93db8b1f@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492967265.w6y5305xmj.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Paul Clarke's message of April 21, 2017 19:22:
> Sent too soon.  The suggestions don't guarantee null termination.  Refine=
d, below. (Sorry for the noise.)

Yeah, the string operations here are a bit of a minefield...

>=20
> On 04/21/2017 08:33 AM, Paul Clarke wrote:
>> On 04/21/2017 07:33 AM, Naveen N. Rao wrote:
>>> Convert usage of strchr()/strncpy()/strncat() to
>>> strnchr()/memcpy()/strlcat() for simpler and safer string manipulation.
>=20
>>> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobe=
s.c
>>> index 97b5eed1f76d..c73fb6e3b43f 100644
>>> --- a/arch/powerpc/kernel/kprobes.c
>>> +++ b/arch/powerpc/kernel/kprobes.c
>>> @@ -65,28 +65,27 @@ kprobe_opcode_t *kprobe_lookup_name(const char *nam=
e, unsigned int offset)
>>>  	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
>>>  	const char *modsym;
>>>  	bool dot_appended =3D false;
>>> -	if ((modsym =3D strchr(name, ':')) !=3D NULL) {
>>> +	if ((modsym =3D strnchr(name, ':', MODULE_NAME_LEN)) !=3D NULL) {

... as I just realized this is an epic FAIL! ;/

I will take my time to redo this.

- Naveen

=
