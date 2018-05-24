Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sHwr73pCzF1QS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:29:48 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4OITgio053025
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 14:29:46 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j62baryma-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 14:29:45 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 24 May 2018 19:29:24 +0100
Date: Thu, 24 May 2018 23:59:19 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] selftests/powerpc: Add test to verify rfi flush
 across a system call
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
References: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
 <5777d4ff6a9216b189f349f98217d47b38278661.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
 <87r2m142ci.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r2m142ci.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1527185167.d6rdwm7ol7.naveen@linux.ibm.com>
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
>> diff --git a/tools/testing/selftests/powerpc/security/rfi_flush.c b/tool=
s/testing/selftests/powerpc/security/rfi_flush.c
>> new file mode 100644
>> index 000000000000..a20fe8eca161
>> --- /dev/null
>> +++ b/tools/testing/selftests/powerpc/security/rfi_flush.c
>> @@ -0,0 +1,132 @@
> ...
>> +
>> +int rfi_flush_test(void)
>> +{
>> +	char *p;
>> +	int repetitions =3D 10;
>> +	int fd, passes =3D 0, iter, rc =3D 0;
>> +	struct perf_event_read v;
>> +	uint64_t l1d_misses_total =3D 0;
>> +	unsigned long iterations =3D 100000, zero_size =3D 24*1024;
>> +	int rfi_flush_org, rfi_flush;
>> +
>> +	SKIP_IF(geteuid() !=3D 0);
>> +
>> +	if (read_debugfs_file("powerpc/rfi_flush", &rfi_flush_org)) {
>> +		perror("error reading powerpc/rfi_flush debugfs file");
>> +	        printf("unable to determine current rfi_flush setting");
>> +		return 1;
>> +	}
>=20
> This leads to a hard error on old kernels, which I don't want (breaks my =
CI).

Hmm... didn't realize new tests would be run on older kernels. Are those=20
older stable/distro releases, or actually just earlier kernel versions?

>=20
> So I changed it to:
>=20
> 	if (read_debugfs_file("powerpc/rfi_flush", &rfi_flush_org)) {
> 		perror("Unable to read powerpc/rfi_flush debugfs file");
> 		SKIP_IF(1);
> 	}

Sure, thanks!
- Naveen

=
