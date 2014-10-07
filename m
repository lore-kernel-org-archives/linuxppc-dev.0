Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32DC11A03F3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 17:23:39 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Oct 2014 00:23:37 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 924DCC90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 02:12:17 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s976NXKg5636474
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Oct 2014 06:23:33 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s976NWZP001391
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Oct 2014 02:23:33 -0400
Date: Mon, 6 Oct 2014 23:23:05 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, eranian@google.com,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 0/5] powerpc/perf: Miscellaneous fixes
Message-ID: <20141007062305.GA20849@us.ibm.com>
References: <1412143402-26061-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <1412143402-26061-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org,
 Michael Ellerman <michaele@au1.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
| Miscellaenous fixes for perf and 24x7 counters in powerpc.
| 
| Patches 1,3,4 were submitted earlier as a part of the parametrized
| events for 24x7 counters. But they are not directly related to the
| parametrized events.
| 
| Patch 2 simplifies and fixes a bug in catalog_read() which causes the
| catalog file to not read first page.
| 
| Changelog[v3]
| 	[Michael Ellerman] Cleanup patches 1 and 2 and fix a bug
| 	Add patch 5/5 to update contact info for 24x7 and GPCI counters
| 
| Changelog[v2]
| 	Rebase to perf/core tree.
| 
| Cody P Schafer (3):
|   powerpc/perf/hv-24x7: use kmem_cache instead of aligned stack
|     allocations
|   perf Documentation: sysfs events/ interfaces
|   perf Documentation: remove duplicated docs for powerpc cpu specific
|     events

Per Michael Ellerman's suggestion, attaching an informal test case to
demonstrate the bug and the fix.

Sukadev

--FCuugMFkClbJLl1L
Content-Type: text/x-csrc; charset=us-ascii
Content-Description: cp-catalog.c
Content-Disposition: attachment; filename="cp-catalog.c"

#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>

/*
 * Usage: cp-catalog <read_size>
 *
 * Read the catalog from beginning to end. Read 'read_size' bytes
 * on each read.
 *
 * To ensure that a bug in catalog_read() in the kernel code is fixed.
 * 	cp-catalog 5 > /tmp/catalog-5
 * 	cp-catalog  > /tmp/catalog-4096
 * 	diff /tmp/catalog-5 /tmp/catalog-4096
 *
 * If both files are identical and size is about 256K, the bug is fixed.
 */
#define CATALOG	"/sys/bus/event_source/devices/hv_24x7/interface/catalog"
#define TMP_CATALOG	"/tmp/catalog"

main(int argc, char *argv[])
{
	int read_size, rfd, wfd, rc;
	struct stat stat_buf;
	char *input_file;
	char buf[4096];
	char output_file[256];

	read_size = 4096;
	if (argc > 1)
		read_size = atoi(argv[1]);

	if (read_size > sizeof(buf))
		read_size = sizeof(buf);

	input_file = CATALOG;
	sprintf(output_file, "%s-%d", TMP_CATALOG, read_size);

	rfd = open(input_file, O_RDONLY);
	if (rfd < 0) {
		perror(input_file);
		_Exit(1);
	}

	wfd  = open(output_file, O_WRONLY|O_CREAT|O_TRUNC);
	if (wfd < 0) {
		perror(output_file);
		_Exit(1);
	}

	while(1) {
		memset(buf, 0, sizeof(buf));
		rc = read(rfd, buf, read_size);
		if (rc <= 0)
			break;
		if (write(wfd, buf, rc) != rc) {
			perror("write()");
			break;
		}
	}
	if (fstat(wfd, &stat_buf) < 0) {
		perror("fstat()");
		_Exit(1);
	}
	printf("catalog size %zd\n", stat_buf.st_size);
}

--FCuugMFkClbJLl1L--
