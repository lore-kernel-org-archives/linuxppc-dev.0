Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7F5B3gZXzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:09:02 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3J88ipm101649
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 04:08:50 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29wqpvacrk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 04:08:50 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 13:38:47 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3J88jEY18809078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:38:45 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3J88iYN030676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:38:45 +0530
Date: Wed, 19 Apr 2017 08:08:40 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: RE: [PATCH v2 1/5] kprobes: convert kprobe_lookup_name() to a function
To: David Laight <David.Laight@ACULAB.COM>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <2780c632bc2c6e39f27920f8cc98e17430189e27.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD3C07@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFD3C07@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492589122.ncy876vm18.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from David Laight's message of April 18, 2017 18:22:
> From: Naveen N. Rao
>> Sent: 12 April 2017 11:58
> ...
>> +kprobe_opcode_t *kprobe_lookup_name(const char *name)
>> +{
> ...
>> +	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
>> +	const char *modsym;
>> +	bool dot_appended =3D false;
>> +	if ((modsym =3D strchr(name, ':')) !=3D NULL) {
>> +		modsym++;
>> +		if (*modsym !=3D '\0' && *modsym !=3D '.') {
>> +			/* Convert to <module:.symbol> */
>> +			strncpy(dot_name, name, modsym - name);
>> +			dot_name[modsym - name] =3D '.';
>> +			dot_name[modsym - name + 1] =3D '\0';
>> +			strncat(dot_name, modsym,
>> +				sizeof(dot_name) - (modsym - name) - 2);
>> +			dot_appended =3D true;
>=20
> If the ':' is 'a way down' name[] then although the strncpy() won't
> overrun dot_name[] the rest of the code can.

Nice catch, thanks David!
We need to be validating the length of 'name'. I'll put out a patch for=20
that.

As an aside, I'm not sure I follow what you mean when you say that the=20
strncpy() won't overrun dot_name[]. If we have a name[] longer than=20
sizeof(dot_name) with the ':' after that, the strncpy() can also overrun=20
dot_name[].


- Naveen

>=20
> The strncat() call is particularly borked.
>=20
> 	David
>=20
>=20
=
