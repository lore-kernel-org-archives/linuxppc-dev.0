Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s9422lKxzF1PT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:20:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] selftests/powerpc: Add test to verify rfi flush
 across a system call
In-Reply-To: <5777d4ff6a9216b189f349f98217d47b38278661.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
 <5777d4ff6a9216b189f349f98217d47b38278661.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 24 May 2018 23:20:29 +1000
Message-ID: <87r2m142ci.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> diff --git a/tools/testing/selftests/powerpc/security/rfi_flush.c b/tools/testing/selftests/powerpc/security/rfi_flush.c
> new file mode 100644
> index 000000000000..a20fe8eca161
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/security/rfi_flush.c
> @@ -0,0 +1,132 @@
...
> +
> +int rfi_flush_test(void)
> +{
> +	char *p;
> +	int repetitions = 10;
> +	int fd, passes = 0, iter, rc = 0;
> +	struct perf_event_read v;
> +	uint64_t l1d_misses_total = 0;
> +	unsigned long iterations = 100000, zero_size = 24*1024;
> +	int rfi_flush_org, rfi_flush;
> +
> +	SKIP_IF(geteuid() != 0);
> +
> +	if (read_debugfs_file("powerpc/rfi_flush", &rfi_flush_org)) {
> +		perror("error reading powerpc/rfi_flush debugfs file");
> +	        printf("unable to determine current rfi_flush setting");
> +		return 1;
> +	}

This leads to a hard error on old kernels, which I don't want (breaks my CI).

So I changed it to:

	if (read_debugfs_file("powerpc/rfi_flush", &rfi_flush_org)) {
		perror("Unable to read powerpc/rfi_flush debugfs file");
		SKIP_IF(1);
	}

cheers
