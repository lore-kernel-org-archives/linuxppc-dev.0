Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skbd2C3yzF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:31:24 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4PBUNMk078480
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 07:31:22 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j6f65ennh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 07:31:04 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 25 May 2018 12:30:47 +0100
Date: Fri, 25 May 2018 17:00:43 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] selftests/powerpc: Add test to verify rfi flush
 across a system call
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
References: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
 <5777d4ff6a9216b189f349f98217d47b38278661.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
 <87r2m142ci.fsf@concordia.ellerman.id.au>
 <1527185167.d6rdwm7ol7.naveen@linux.ibm.com>
 <87k1rsqat1.fsf@concordia.ellerman.id.au>
In-Reply-To: <87k1rsqat1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1527247830.8e16y8urfz.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> Michael Ellerman wrote:
>>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>>> diff --git a/tools/testing/selftests/powerpc/security/rfi_flush.c b/to=
ols/testing/selftests/powerpc/security/rfi_flush.c
>>>> new file mode 100644
>>>> index 000000000000..a20fe8eca161
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/powerpc/security/rfi_flush.c
>>>> @@ -0,0 +1,132 @@
>>> ...
>>>> +
>>>> +int rfi_flush_test(void)
>>>> +{
>>>> +	char *p;
>>>> +	int repetitions =3D 10;
>>>> +	int fd, passes =3D 0, iter, rc =3D 0;
>>>> +	struct perf_event_read v;
>>>> +	uint64_t l1d_misses_total =3D 0;
>>>> +	unsigned long iterations =3D 100000, zero_size =3D 24*1024;
>>>> +	int rfi_flush_org, rfi_flush;
>>>> +
>>>> +	SKIP_IF(geteuid() !=3D 0);
>>>> +
>>>> +	if (read_debugfs_file("powerpc/rfi_flush", &rfi_flush_org)) {
>>>> +		perror("error reading powerpc/rfi_flush debugfs file");
>>>> +	        printf("unable to determine current rfi_flush setting");
>>>> +		return 1;
>>>> +	}
>>>=20
>>> This leads to a hard error on old kernels, which I don't want (breaks m=
y CI).
>>
>> Hmm... didn't realize new tests would be run on older kernels. Are those=
=20
>> older stable/distro releases, or actually just earlier kernel versions?
>=20
> All of the above :)
>=20
> Obviously keeping all the tests working across all kernel versions ever
> is impossible, but when it's relatively easy like in this case, it's
> nice to do.
>=20
> So that was mostly just an FYI, I don't expect test writers to get their
> tests running across all kernel versions.

Good to know, thanks!
- Naveen

=
